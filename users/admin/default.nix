{
  config,
  lib,
  pkgs,
  modulesPath,
  inputs,
  ...
}:
let
  inherit (config.yomaq.impermanence) dontBackup;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  yomaq.ssh.enable = true;
  # Force all user accounts to require nix configuration, any manual changes to users will be lost
  users.mutableUsers = false;
  # Configure admin account
  users.users.admin = {
    isNormalUser = true;
    description = "admin";
    # disable password for admin account
    hashedPassword = null;
    # Set authorized keys to authenticate to ssh as admin user
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDUdKeCY7RoiO8r3v7TCNN27gExT7T2Rb6Fo3LwXxteKKi0sObIShy/UQuYAe3sY5xPLKHTSKQKab3t9B2jyuYTHTs6CLCKzkBb5hKmDfWIS0Rxfr/OsVYMp1ElIm6xQRLURJ9A71BFDwQrEwGqzsPMtKcZirXFcPuGtV9Sr6gcyt8bfK8AdJopbflkFDg3VVPyIFmi5PEkjUBGJOpYpjOYo6Mt9Zpja/WSbUwrnTDJ3pKWk99kRmUxlwV+sh1zEW+bQXtCWI4YIWUm0iESyzZASb6LMw3FfsVdbTSplmiW+YOb0VJSHb31gQoFSsRc9oM4gHeKnU+26/HyvPNOU/Yh ssh-key-2024-11-02"
    ];
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  # Enable admin account to use ssh without password (since the admin account doesn't HAVE a password)
  security.sudo.extraRules = [
    {
      users = [ "admin" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];
  environment.persistence."${dontBackup}" = {
    users.admin = {
      directories = [
        "nix"
        "documents"
      ];
    };
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      # Import your home-manager configuration
      admin = import ./homeManager;
    };
  };
}
