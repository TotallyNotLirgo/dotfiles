let
  _dir_contents = builtins.readDir ../plugins;
  _dir_files = builtins.attrNames _dir_contents;
  _imports = builtins.filter (path: path != "default.nix") _dir_files;
  _imports_fixed = builtins.map (path: "/" + path) _imports;
  _import_files = builtins.map(path: ./. + path) _imports_fixed;
  _imported = (builtins.map (plugin: import plugin) _import_files);
  _plugins = builtins.foldl' (plugin: acc: acc // plugin) {} _imported;
in
{
  plugins = _plugins;
}
