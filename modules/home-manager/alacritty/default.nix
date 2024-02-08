{ options, config, lib, pkgs, inputs, ... }:
let
  cfg = config.yomaq.alacritty;
in
{
  imports = [];
  options.yomaq.alacritty = {
    enable = with lib; mkOption {
      type = types.bool;
      default = false;
      description = ''
        enable custom alacritty module
      '';
    };
  };
 config = lib.mkIf cfg.enable {
    programs = {
      alacritty = {
        enable = true;
        settings = {
          window = {
            opacity = 0.8;
            decorations = "None";
          };
        };
      };
    };
 };
}
