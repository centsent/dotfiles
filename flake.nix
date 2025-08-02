{
  description = "Root flake delegating to ./nix";

  inputs.nix.url = "./nix";

  outputs = inputs@{ nix, ... }: nix.outputs (nix.inputs // { self = nix; });
}
