{ ... }:
{
  modulesFromPath = root: modules: builtins.map (mod: root + "/" + mod) modules;
}
