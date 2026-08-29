# Kellan's NixOS & macOS Flake Configuration

Declarative, modular system configuration for NixOS and macOS (nix-darwin) using Nix Flakes and Home Manager.

## Structure

```
.
├── flake.nix                         # Flake entry point (inputs, outputs, host definitions)
├── flake.lock                        # Pinned dependency versions
├── hosts/                            # Per-host configurations
│   ├── nixos/                        # NixOS home server
│   │   ├── default.nix               # Host config (bootloader, user, hostname)
│   │   └── hardware-configuration.nix
│   └── macbook/                      # macOS (nix-darwin) — template
│       └── default.nix
└── modules/                          # Shared & platform-specific modules
    ├── core/                         # Cross-platform (Nix settings, GC, locale, Zsh)
    │   └── default.nix
    ├── home/                         # Home Manager (cross-platform user environment)
    │   ├── default.nix               # Packages, Zsh config, home directory
    │   ├── aliases.nix               # Shell aliases (eza, grep)
    │   └── oh-my-posh.nix            # Prompt theme
    └── nixos/                        # NixOS-only system modules
        ├── default.nix               # Aggregator (imports desktop, network, services)
        ├── desktop.nix               # Pantheon DE, LightDM, Pipewire, Helium
        ├── network.nix               # Firewall, NetworkManager, sleep inhibition
        └── services/                 # Individual service modules
            ├── home-assistant.nix    # Home Assistant on port 8123
            ├── ssh.nix               # OpenSSH server
            ├── traefik.nix           # Traefik reverse proxy (Cloudflare ACME wildcard SSL)
            └── uxplay.nix            # UxPlay AirPlay receiver
```

## Usage

### Rebuild NixOS

```bash
sudo nixos-rebuild switch --flake ~/nix
```

### Set up macOS (future)

1. Uncomment `darwinConfigurations.macbook` in `flake.nix`
2. Run:
   ```bash
   nix run nix-darwin -- switch --flake ~/nix#macbook
   ```

### Adding a New Service

1. Create `modules/nixos/services/my-service.nix`
2. Import it in `modules/nixos/default.nix`
3. Rebuild

### Adding a New Host

1. Create `hosts/<hostname>/default.nix` (and `hardware-configuration.nix` if NixOS)
2. Add a new `nixosConfigurations.<hostname>` or `darwinConfigurations.<hostname>` entry in `flake.nix`
3. Rebuild with `--flake ~/nix#<hostname>`

## Secrets

Traefik's Cloudflare API token lives outside the repo at `/var/lib/traefik/cloudflare.env`.
