#!/bin/sh

# Setup Sleep
sudo -u gdm dbus-run-session gsettings list-recursively org.gnome.settings-daemon.plugins.power
#sudo -H -u gdm dbus-launch --exit-with-session gsettings list-recursively org.gnome.settings-daemon.plugins.power

#sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action 'nothing'
sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power lid-close-battery-action 'nothing'
sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
sudo -u gdm dbus-run-session gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

sudo -u gdm dbus-run-session gsettings list-recursively org.gnome.settings-daemon.plugins.power
#sudo -H -u gdm dbus-launch --exit-with-session gsettings list-recursively org.gnome.settings-daemon.plugins.power

# Setup Sleep (logind)
sudo vim /etc/systemd/logind.conf
# HandleLidSwitch=ignore
# HandleLidSwitchExternalPower=ignore

# Install-Thunderbird
sudo add-apt-repository -y ppa:mozillateam/ppa

echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: thunderbird
Pin: version 2:1snap*
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/thunderbird

sudo snap remove --purge thunderbird
sudo apt purge thunderbird

sudo apt install thunderbird

echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-thunderbird

# Install-Firefox
sudo add-apt-repository -y ppa:mozillateam/ppa

echo '
Package: firefox*
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 501

Package: firefox*
Pin: release o=Ubuntu
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/firefox

sudo snap remove --purge firefox
sudo apt purge firefox

sudo apt install firefox
