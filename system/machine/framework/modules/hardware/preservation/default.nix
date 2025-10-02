# This new file replaces the old impermanence modules.
# It centralizes all persistence settings for your system.
{
  config,
  lib,
  pkgs,
  username,
  ...
}: {
  # You might need to adjust your rollback script or remove it
  # if preservation handles everything you need.
  # For now, I'll leave your original rollback script logic commented out
  # as it is highly specific to your BTRFS setup and might need a review.
  # boot.initrd.systemd.services.rollback = { ... };

  programs.fuse.userAllowOther = true;

  preservation = {
    enable = true;
    preserveAt."/persist" = {
      # This replaces environment.persistence
      directories = [
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"
        "/etc/wireguard"
        "/etc/secureboot"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/log"
        "/var/lib/docker"
        "/var/lib/netbird"
        "/var/lib/containers"
        "/var/lib/qemu"
        "/var/lib/private"
        "/var/db"
        "/var/lib/NetworkManager"
        "/var/lib/chrony"
        "/var/lib/iwd"
        "/var/lib/libvirt"
        "/var/lib/systemd"
      ];

      files = [
        # Special handling for machine-id
        { file = "/etc/machine-id"; inInitrd = true; }
        # Special handling for SSH host keys
        { file = "/etc/ssh/ssh_host_ed25519_key"; how = "symlink"; configureParent = true; }
        { file = "/etc/ssh/ssh_host_ed25519_key.pub"; how = "symlink"; configureParent = true; }
        { file = "/etc/ssh/ssh_host_rsa_key"; how = "symlink"; configureParent = true; }
        { file = "/etc/ssh/ssh_host_rsa_key.pub"; how = "symlink"; configureParent = true; }
      ];

      # This section replaces home.persistence for the user "sebastian"
      users.${username} = {
        directories = [
          "Code"
          "Desktop"
          "Downloads"
          "Documents"
          "go"
          "Music"
          "Pictures"
          "Public"
          "Templates"
          "Videos"
          "VirtualBox VMs"
          "Trash"
          "Sync"
          ".ansible_inventory"
          ".docker"
          ".emacs.d"
          ".flutter-devtools"
          ".kube"
          ".m2"
          ".mozilla"
          ".librewolf"
          ".thunderbird"
          ".obsidian"
          ".openvpn"
          ".password-store"
          ".themes"
          ".terraform.d"
          ".yandex"
          ".ollama"
          ".config/google-chrome"
          ".config/sops"
          ".config/vesktop"
          ".config/sops-nix"
          ".config/obsidian"
          ".config/Code"
          ".config/dconf"
          ".config/htop"
          ".config/nvim"
          ".config/syncthing"
          ".config/obs-studio"
          ".config/pulse"
          ".config/Thunar"
          ".config/vlc"
          ".local/share/chat.fluffy.fluffychat"
          ".local/share/zoxide"
          ".local/share/fish"
          ".local/share/nix"
          ".local/share/nvf"
          ".local/share/containers"
          ".local/share/Trash"
          ".local/share/TelegramDesktop"
          ".local/share/keyrings"
          ".local/share/nvim"
          ".local/state"
          ".vscode"
          ".pki"
          ".ssh"
          ".gnupg"
        ];

        files = [
          ".bash_history"
          ".bash_logout"
          ".flutter"
          ".face"
          ".face.icon"
          ".zsh_history"
          ".cache/cliphist/db"
        ];
      };
    };
  };

  # According to preservation docs, this is needed for first boot with symlinked machine-id
  systemd.services.systemd-machine-id-commit = {
    unitConfig.ConditionPathIsMountPoint = [
      "" "/persist/etc/machine-id"
    ];
    serviceConfig.ExecStart = [
      "" "${pkgs.systemd}/bin/systemd-machine-id-setup --commit --root /persist"
    ];
  };
}
