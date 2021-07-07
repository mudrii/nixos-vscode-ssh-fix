# Visual Studio Code Server support in NixOS

Experimental support for VS Code Server in NixOS. The NodeJS by default supplied by VS Code cannot be used within NixOS due to missing hardcoded paths, so it is automatically replaced by a symlink to a compatible version of NodeJS that does work under NixOS.

## Installation

### Install using flakes (flake.nix)

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-vscode-server.url ="github:thirusk86/nixos-vscode-ssh-fix/main";
  };

  outputs = inputs@{self, nixpkgs, ...}: {
    nixosConfigurations.some-host = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        # For more information of this field, check:
        # https://github.com/NixOS/nixpkgs/blob/master/nixos/lib/eval-config.nix
        modules = [
          ./configuration.nix
          {
            imports = [ inputs.auto-fix-vscode-server.nixosModules.system ];
          }
        ];
      };
  };
}
```
### Enable the service
systemctl --user enable nixos-vscode-server.service

### Start the service
systemctl --user start nixos-vscode-server.service

### Usage

This service only works if the VSCode server has yet to be installed. If the server has already been installed, remove `~/.vscode-server`, restart the
service, and then try to connect to the VSCode server from another client again. 

The service can be restarted with `systemctl --user restart nixos-vscode-server` or by rebooting the machine.
