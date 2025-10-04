{
  # Fügt Pakete für die Hardware-Videobeschleunigung hinzu.
  hardware.graphics.extraPackages = with pkgs; [
    libva-utils
    libva
  ];
}
