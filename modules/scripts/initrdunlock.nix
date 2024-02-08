{ pkgs, inputs, ... }:


pkgs.writeShellScriptBin "example-script" ''

echo "hello world"

''
