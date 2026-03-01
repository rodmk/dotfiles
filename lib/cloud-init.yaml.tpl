#cloud-config

ssh_pwauth: false

users:
  - name: dev
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ${ssh_pubkey}

write_files:
  - path: /etc/systemd/system/ssh.service.d/priority.conf
    content: |
      [Service]
      CPUWeight=200
  - path: /run/op-sa-token
    permissions: "0600"
    content: ${op_sa_token}
  - path: /etc/systemd/system/vm-ttl.timer
    content: |
      [Unit]
      Description=Check VM activity and self-destruct on TTL
      [Timer]
      OnBootSec=5min
      OnUnitActiveSec=5min
      [Install]
      WantedBy=timers.target
  - path: /etc/systemd/system/vm-ttl.service
    content: |
      [Unit]
      Description=VM TTL watchdog
      [Service]
      Type=oneshot
      EnvironmentFile=/etc/vm-ttl.env
      ExecStart=/usr/local/sbin/vm-ttl-check
  - path: /etc/vm-ttl.env
    permissions: "0600"
    content: |
      HCLOUD_TOKEN=${hcloud_token}
      VM_TTL=900
      VM_MIN_TTL=3600
      VM_MAX_TTL=28800
  - path: /usr/local/sbin/vm-ttl-check
    permissions: "0755"
    content: |
      #!/bin/bash
      set -euo pipefail
      # https://docs.hetzner.cloud/#server-metadata
      self_destruct() {
        SERVER_ID=$(curl -sf http://169.254.169.254/hetzner/v1/metadata/instance-id)
        curl -sf -X DELETE \
          -H "Authorization: Bearer $HCLOUD_TOKEN" \
          "https://api.hetzner.cloud/v1/servers/$SERVER_ID"
      }
      # Hard stop: destroy VM after VM_MAX_TTL regardless of activity
      uptime_s=$(awk '{printf "%d", $1}' /proc/uptime)
      if (( uptime_s >= VM_MAX_TTL )); then
        self_destruct
        exit 0
      fi
      # Authenticated sshd children run as dev (ignores unauthenticated bots)
      MARKER=/run/vm-last-activity
      [ -f "$MARKER" ] || touch "$MARKER"
      if pgrep -u dev -x sshd >/dev/null ||
         pgrep -x mosh-server >/dev/null; then
        touch "$MARKER"
        exit 0
      fi
      last=$(stat -c %Y "$MARKER" 2>/dev/null || echo 0)
      now=$(date +%s)
      if (( now - last >= VM_TTL && uptime_s >= VM_MIN_TTL )); then
        self_destruct
      fi

swap:
  filename: /swapfile
  size: 8G

runcmd:
  - systemctl daemon-reload
  - systemctl restart ssh
  - touch /run/vm-last-activity
  - systemctl enable --now vm-ttl.timer
  - install -d -o dev -g dev /home/dev/.config && install -d -o dev -g dev -m 700 /home/dev/.config/op && install -o dev -g dev -m 600 /run/op-sa-token /home/dev/.config/op/sa-token && rm /run/op-sa-token
  - su - dev -c 'sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply rodmk && bash -ic dotfiles-deps'
  - su - dev -c 'bash -ic "mkdir -p ~/.ssh && chmod 700 ~/.ssh && secret ssh > ~/.ssh/id_ed25519 && chmod 600 ~/.ssh/id_ed25519 && ssh-keygen -y -f ~/.ssh/id_ed25519 > ~/.ssh/id_ed25519.pub && ssh-keyscan github.com >> ~/.ssh/known_hosts 2>/dev/null"'
