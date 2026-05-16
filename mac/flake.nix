{
  description = "nix-darwin + home-manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }:
  let
    # ユーザー固有の設定 — 別マシンにセットアップする際はここだけ変更する
    user = {
      name     = "gtn-74";
      home     = "/Users/gtn-74";
      hostname = "mac-air";
    };
  in
  {
    darwinConfigurations."${user.hostname}" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = { inherit user; };
      modules = [
        ./darwin.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."${user.name}" = import ./home.nix;
          home-manager.extraSpecialArgs = { inherit user; };
        }
      ];
    };
  };
}
