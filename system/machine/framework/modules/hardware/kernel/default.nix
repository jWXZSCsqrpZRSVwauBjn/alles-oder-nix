{
  pkgs,
  config,
  ...
}: {
  boot = {
    #kernelPackages = pkgs.linuxPackages_cachyos;
    kernelPackages = pkgs.linuxPackages_latest;

    kernelModules = [
      "amdgpu"
      "kvm-amd"
      #"zenpower"
    ];

    kernelParams = [
      "drm_kms_helper.poll=0"
      "amd_pstate=guided"
      "kernel.watchdog=0"
    ];

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usbhid"
        "usb_storage"
        "sd_mod"
        "thunderbolt"
        "uas"
      ];

      kernelModules = [
        "amdgpu"
      ];
    };

    kernel.sysctl = {
      "vm.swappiness" = 100;
      "vm.dirty_background_bytes" = 67108864;
      "vm.dirty_bytes" = 268435456;
      "vm.dirty_expire_centisecs" = 1500;
      "vm.dirty_writeback_centisecs" = 100;
      "vm.vfs_cache_pressure" = 50;
      "vm.max_map_count" = 1048576;
    };
  };
}
