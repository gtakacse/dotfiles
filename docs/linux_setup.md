# Linux Setup

## Prepare the install
Download image from https://archlinux.org/download/

Save the ISO image to a USB. On Mac,
find the USB by 
$ diskutil list
unmount the device
$ diskutil unmountDisk /dev/disk4

Save the image to the USB drive, make sure to add the "r" before it
$ sudo dd if=archlinux-x86_64.iso of=/dev/rdisk4 bs=1m status=progress

In the Lenovo ThinkPad,
- make sure the boot is set to UEFI booting, as the Linux image only supports UEFI loading (open with F1)
- make sure the laptop is charged
- use the left USB port (the rest seems to be broken)
- press F12 to open the boot manager at startup

## Run the install
After the initial setup, when greeted with the root@archiso prompt,
- setup the internet connection by running
$ iwctl
[iwd] device list
[iwd] station wlan0 scan
[iwd] station wlan0 get-nerworks
[iwd] station wlan0-connect Telekom-096347
passphase: *****
Check setup
[iwd] station wlan show

More compactly
$ iwctl --passphrase passphrase station name connect SSID

Run setup script:
$ archinstall

### Set options
Mirror > Hu
Disk configuration 
> Best effort 
> Select drive with the most space
> Use btrfs filesystem
> Use default config
> With configuration

Boot loader > Grub
Add root password
Add user with superuser
Audio > Pipeiwire
Kernel > Linux

Network config > Use NetworkManager

When the setup is complete, select "Install"

## Post install configuration

Chroot into the installation by selecting yes

Install desktop environment
$ pacman -S gnome

Restart computer by
$ exit
$ shutdown -h now

After start, select Arch Linux installation and login to user
Enable gnome
$ sudo systemctl enable gdm.service
$ sudo systemctl start gdm.service

## System setup

Install a few useful apps

$ sudo pacman -S less
$ sudo pacman -S vim
$ sudo pacman -S neovim
$ sudo pacman -S neofetch
$ sudo pacman -S firefox
$ sudo pacman -S ripgrep
$ sudo pacman -S bat
$ sudo pacman -S fzf
$ sudo pacman -S fd
$ sudo pacman -S jq
$ sudo pacman -S tmux

Install yay
$ sudo pacman -S --needed git base-devel
$ git clone https://aur.archlinux.org/yay.git
$ cd yay
$ makepkg -si 

Upgrade system
$ sudo pacman -Syu
Upgrade grub after updates
$ sudo pacman grub-mkconfig -o /boot/grub/grub.cfg
To avoid breaking grub with kernel upgrades
$ yay -S grub-hook

Install nerdfont
$ yay -S ttf-lilex-nerd

### Dotfile setup
$ sudo pacman -S stow
Fetch dotfiles from github
$ stow nvim -t $HOME
$ stow tmux -t $HOME
Install tpm and/or theme

### Setup kitty
$ sudo pacman -S kitty
$ kitten theme
Select Night Owl
Hit "M" to modify kitty.conf
$ nvim ~/.config/kitty/kitty.conf

Add pritty prompt by starship
$ sudo pacman -S starship
$ stow starship -t $HOME
Add to .bashrc
eval "$(starship init bash)"

### Setup yazi
$ sudo pacman -S yazi
Create alias y and change working directory if exiting with 'q' by adding the following to ~/.bashrc
```
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
```
$ mkdir ~/.config/yazi
$ nvim ~/.config/yazi/yazi.conf
Change default editor by adding
```
[opener]
edit = [
	{ run = 'nvim "$@"', block = true, for = "unix" },
]
```
Show hidden files
```
[manager]
show_hidden = true
```

## Setup Hyprland
$ suod pacman -S hyprland
