{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # import custom modules
    inputs.self.nixosModules.yomaq
    inputs.self.nixosModules.pods
    # import users
    (inputs.self + /users/admin)
  ];
  config = {
    networking.hostName = "azure";
    system.stateVersion = "23.05";

    yomaq = {
      autoUpgrade.enable = true;
      primaryUser.users = [ "admin" ];
      tailscale = {
        enable = true;
        extraUpFlags = [
          "--ssh=true"
          "--reset=true"
          "--accept-dns=true"
          "--advertise-exit-node=true"
        ];
        useRoutingFeatures = "server";
      };
      glances.enable = lib.mkForce false;
      _1password.enable = true;
      timezone.central = true;
      suites = {
        basics.enable = true;
        foundation.enable = true;
      };
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      boot.initrd.network.enable = true;
      boot.initrd.network.ssh = {
        enable = true;
        port = 22;
        shell = "/bin/cryptsetup-askpass";
        authorizedKeys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUdKeCY7RoiO8r3v7TCNN27gExT7T2Rb6Fo3LwXxteKKi0sObIShy/UQuYAe3sY5xPLKHTSKQKab3t9B2jyuYTHTs6CLCKzkBb5hKmDfWIS0Rxfr/OsVYMp1ElIm6xQRLURJ9A71BFDwQrEwGqzsPMtKcZirXFcPuGtV9Sr6gcyt8bfK8AdJopbflkFDg3VVPyIFmi5PEkjUBGJOpYpjOYo6Mt9Zpja/WSbUwrnTDJ3pKWk99kRmUxlwV+sh1zEW+bQXtCWI4YIWUm0iESyzZASb6LMw3FfsVdbTSplmiW+YOb0VJSHb31gQoFSsRc9oM4gHeKnU+26/HyvPNOU/Yh ssh-key-2024-11-02"];
        hostKeys = [ "/etc/ssh/initrd" ];
      };
      boot.initrd.secrets = {
        "/etc/ssh/initrd" = "/etc/ssh/initrd";
      };
      # disk configuration
      #disks = {
      #  enable = true;
      #  systemd-boot = true;
      #  initrd-ssh = {
      #    enable = true;
      #    ethernetDrivers = [ "e1000e" ];
      #  };
      #  zfs = {
      #    enable = true;
      #    hostID = "2C2883D7";
      #    root = {
      #      disk1 = "nvme0n1";
      #      impermanenceRoot = true;
      #    };
      #  };
      #};
    };
  };
}
