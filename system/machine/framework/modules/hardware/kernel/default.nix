{ pkgs, ... }: {
  boot = {
    # Ein sicherer Standard-Kernel
    kernelPackages = pkgs.linuxPackages_latest;

    # Aus deiner generierten Konfiguration
    initrd.availableKernelModules = [ 
      "nvme" 
      "xhci_pci" 
      "thunderbolt" 
      "usb_storage" 
      "uas" 
      "sd_mod" 
    ];
    kernelModules = [ "kvm-amd" ];
    extraModulePackages = [ ];
  };
}
