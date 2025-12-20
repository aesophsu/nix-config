{
  self,
  nixpkgs,
  pre-commit-hooks,
  ...
}@inputs:
let
  inherit (inputs.nixpkgs) lib;

  # =====================================================================================
  # Project-level extensions
  # =====================================================================================

  mylib  = import ../lib  { inherit lib; };
  myvars = import ../vars { inherit lib; };


  # =====================================================================================
  # SpecialArgs generator
  # Shared across nixos / darwin / home-manager / colmena
  # =====================================================================================

  genSpecialArgs =
    system:
    inputs
    // {
      inherit mylib myvars;

      # Alternative nixpkgs channels (select per-module if needed)
      # pkgs-unstable = import inputs.nixpkgs-unstable {
      #   inherit system;
      #   config.allowUnfree = true;
      # };

      pkgs-2505 = import inputs.nixpkgs-2505 {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs-patched = import inputs.nixpkgs-patched {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs-master = import inputs.nixpkgs-master {
        inherit system;
        config.allowUnfree = true;
      };

      # Cross-arch helper (build x86_64 on non-x86 hosts)
      pkgs-x64 = import nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };


  # =====================================================================================
  # Common args for haumea-style module trees
  # =====================================================================================

  args = {
    inherit inputs lib mylib myvars genSpecialArgs;
  };


  # =====================================================================================
  # System trees (per-architecture entry points)
  # =====================================================================================

  nixosSystems = {
    x86_64-linux  = import ./x86_64-linux  (args // { system = "x86_64-linux"; });
    aarch64-linux = import ./aarch64-linux (args // { system = "aarch64-linux"; });
    # riscv64-linux = import ./riscv64-linux (args // { system = "riscv64-linux"; });
  };

  darwinSystems = {
    aarch64-darwin = import ./aarch64-darwin (args // { system = "aarch64-darwin"; });
  };

  allSystems         = nixosSystems // darwinSystems;
  allSystemNames     = builtins.attrNames allSystems;
  nixosSystemValues  = builtins.attrValues nixosSystems;
  darwinSystemValues = builtins.attrValues darwinSystems;
  allSystemValues    = nixosSystemValues ++ darwinSystemValues;


  # =====================================================================================
  # Helpers
  # =====================================================================================

  forAllSystems = func:
    nixpkgs.lib.genAttrs allSystemNames func;

in
{
  # =====================================================================================
  # Debug / introspection
  # =====================================================================================

  debugAttrs = {
    inherit nixosSystems darwinSystems allSystems allSystemNames;
  };


  # =====================================================================================
  # NixOS & Darwin configurations
  # =====================================================================================

  nixosConfigurations =
    lib.attrsets.mergeAttrsList
      (map (it: it.nixosConfigurations or { }) nixosSystemValues);

  darwinConfigurations =
    lib.attrsets.mergeAttrsList
      (map (it: it.darwinConfigurations or { }) darwinSystemValues);


  # =====================================================================================
  # Colmena (remote deployment)
  # =====================================================================================

  colmena =
    {
      meta =
        let
          system = "x86_64-linux";
        in
        {
          nixpkgs     = import nixpkgs { inherit system; };
          specialArgs = genSpecialArgs system;
        };

      nodeNixpkgs =
        lib.attrsets.mergeAttrsList
          (map (it: it.colmenaMeta.nodeNixpkgs or { }) nixosSystemValues);

      nodeSpecialArgs =
        lib.attrsets.mergeAttrsList
          (map (it: it.colmenaMeta.nodeSpecialArgs or { }) nixosSystemValues);
    }
    // lib.attrsets.mergeAttrsList
         (map (it: it.colmena or { }) nixosSystemValues);


  # =====================================================================================
  # Packages & evaluation
  # =====================================================================================

  packages =
    forAllSystems (system: allSystems.${system}.packages or { });

  evalTests =
    lib.lists.all (it: it.evalTests == { }) allSystemValues;


  # =====================================================================================
  # Checks (CI / pre-commit)
  # =====================================================================================

  checks = forAllSystems (system: {
    eval-tests = allSystems.${system}.evalTests == { };

    pre-commit-check =
      pre-commit-hooks.lib.${system}.run {
        src = mylib.relativeToRoot ".";
        hooks = {
          nixfmt-rfc-style = {
            enable = true;
            settings.width = 100;
          };

          typos = {
            enable = true;
            settings = {
              write = true;
              configPath = ".typos.toml";
              exclude = "rime-data/";
            };
          };

          prettier = {
            enable = true;
            settings = {
              write = true;
              configPath = ".prettierrc.yaml";
            };
          };

          # deadnix.enable = true;
          # statix.enable  = true;
        };
      };
  });


  # =====================================================================================
  # Development environments
  # =====================================================================================

  devShells = forAllSystems (
    system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      default = pkgs.mkShell {
        name = "dots";

        packages = with pkgs; [
          bashInteractive
          gcc

          nixfmt
          deadnix
          statix

          typos
          nodePackages.prettier
        ];

        inherit (self.checks.${system}.pre-commit-check) shellHook;
      };
    }
  );


  # =====================================================================================
  # Formatter
  # =====================================================================================

  formatter =
    forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);
}
