# warcraftlogs-nix

Warcraft Logs combat log uploader packaged for NixOS.

Automatically updated via GitHub Actions every 6 hours.

## Usage

### Flake

```nix
{
  inputs.warcraftlogs.url = "github:tomsch/warcraftlogs-nix";
}
```

```nix
environment.systemPackages = [ inputs.warcraftlogs.packages.x86_64-linux.default ];
```

### Direct build

```bash
nix build github:tomsch/warcraftlogs-nix
```
