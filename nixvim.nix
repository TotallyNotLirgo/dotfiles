{ inputs, ... }:
{
    imports = [
        inputs.nixvim.homeManagerModules.nixvim
    ];
    programs.nixvim = let
    _nixvim = import ./nixvim;
    _imports = builtins.map (plugin: import plugin) _nixvim.imports;
    _plugins = builtins.foldl' (plugin: acc: acc // plugin) {} _imports;
    in _plugins // { enable = true; };
}
