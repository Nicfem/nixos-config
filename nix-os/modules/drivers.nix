{
  # Fix scroll/motion event swap bug for X68HE Mouse (usb:3151:502d)
  environment.etc."libinput/local-overrides.quirks".text = ''
    [X68HE Mouse scroll fix]
    MatchUdevType=mouse
    MatchName=*X68HE Mouse
    AttrEventCode=-EV_REL:0x0b;-EV_REL:0x0c
  '';

  services.xserver.videoDrivers = ["nvidia"];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {

    modesetting.enable = true;

    open = false;
    
    nvidiaSettings = true;
  };
}
