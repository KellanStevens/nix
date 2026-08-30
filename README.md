# How to install this Nix configuration

This guide installs the `nixos` configuration on a NixOS computer or the
`TL-FW21FX96ND` configuration on an Apple Silicon Mac.

## Set up NixOS

Start from the NixOS installer. Partition the disks and mount the target system
at `/mnt`. Mount the EFI system partition at `/mnt/boot/efi` because this
configuration uses that path.

Generate the hardware configuration:

```sh
sudo nixos-generate-config --root /mnt
```

The repository is private. Open a shell with Git and the GitHub CLI, then sign
in to GitHub:

```sh
nix-shell -p git gh
gh auth login
```

Clone the repository into the target home directory:

```sh
gh repo clone KellanStevens/nix /tmp/nix
sudo mkdir -p /mnt/home/kellan.stevens
sudo mv /tmp/nix /mnt/home/kellan.stevens/nix
```

Replace the existing hardware configuration with the configuration generated
for the new computer:

```sh
sudo cp /mnt/etc/nixos/hardware-configuration.nix \
  /mnt/home/kellan.stevens/nix/hosts/nixos/hardware-configuration.nix
```

Install NixOS:

```sh
sudo nixos-install --flake /mnt/home/kellan.stevens/nix#nixos
```

Set the password for the configured user and correct the repository ownership:

```sh
sudo nixos-enter --root /mnt -c 'passwd kellan.stevens'
sudo chown -R 1000:100 /mnt/home/kellan.stevens
```

Reboot into the installed system:

```sh
sudo reboot
```

Open a terminal and verify the configuration:

```sh
nix-rebuild
```

## Set up macOS

Use the `kellan.stevens` macOS account on an Apple Silicon Mac.

Install the Apple command-line tools:

```sh
xcode-select --install
```

Install [Determinate Nix](https://manual.determinate.systems/installation/):

```sh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

Open a new terminal after the installer finishes.

Install [Homebrew](https://brew.sh/) and load it into the current shell:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"
```

Install the GitHub CLI, sign in, and clone the private repository:

```sh
brew install gh
gh auth login
gh repo clone KellanStevens/nix ~/nix
cd ~/nix
```

Move the existing system files aside before the first nix-darwin activation:

```sh
sudo mv /etc/bashrc /etc/bashrc.before-nix-darwin
sudo mv /etc/pam.d/sudo_local /etc/pam.d/sudo_local.before-nix-darwin
```

Run the first activation:

```sh
sudo -H nix run github:nix-darwin/nix-darwin/nix-darwin-26.05#darwin-rebuild \
  -- switch --flake ~/nix#TL-FW21FX96ND
```

Open a new terminal and verify the configuration:

```sh
nix-rebuild
```

> [!WARNING]
> The macOS activation removes Homebrew formulae and casks that are not listed
> in `modules/macos/homebrew`.
