{...}: {
  imports = [
    ./shell.nix
  ];
#  # imports by full path without copying to /nix/store
#  imports = builtins.map (n: toString ./. + "/${n}") (builtins.attrNames (builtins.removeAttrs (builtins.readDir ./.) [(builtins.unsafeGetAttrPos "_" {_ = null;}).file]));
#  
#  # copies all files from the current directory to /nix/store and imports from /nix/store
#  # imports = builtins.map (n: "${./.}/${n}") (builtins.attrNames (builtins.removeAttrs (builtins.readDir ./.) [(builtins.unsafeGetAttrPos "_" {_ = null;}).file]));
}
