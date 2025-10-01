{
  lib,
  pkgs,
  config,
  ...
}: let
  inherit (lib) mkDefault;
in {
  # Extra drivers settings
  hardware = {
    enableAllFirmware = true;
    enableRedistributableFirmware = true;

    firmware = with pkgs; [
      sof-firmware
      linux-firmware
    ];

    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };
}
