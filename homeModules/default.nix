{ inputs, ... }@flakeContext:
{ config, lib, pkgs, ... }: {
  config = {
    nixpkgs = {
      config = {
        allowUnfree = true;
      };
    };
    home = {
      packages = [
        pkgs.tailscale
        pkgs.discord
        pkgs.vscode
        pkgs.vim
        pkgs.talosctl
        pkgs.kubectl
        pkgs.nerdfonts
        pkgs.chezmoi
        pkgs._1password
        pkgs.tmuxinator
        pkgs.kubernetes-helm
      ];
      stateVersion = "23.11";
    };
    programs = {
     tmux = {
        enable = true;
        shell = "/etc/profiles/per-user/carln/bin/zsh";
      };
      bash = {
        enable = true;
        enableCompletion = true;
        initExtra = "[ -f $HOME/.bashrc2 ] && . $HOME/.bashrc2";
      };
      zsh = {
        enable = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        initExtra = "for FILE in ~/.zshrcs/*; do source $FILE; done";
        oh-my-zsh = {
          enable = true;
          theme = "darkblood";
          plugins = [
            "kubectl" 
          ];
        };
      };
    };
  };
}