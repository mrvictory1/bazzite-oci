#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
# dnf5 install -y tmux 
# cd ~
git clone https://github.com/frankcrawford/it87.git
cd it87
make clean
make
make install
touch /etc/modprobe.d/it87.conf && echo "options it87 ignore_resource_conflict=1" | tee /etc/modprobe.d/it87.conf
touch /etc/modules-load.d/it87.conf && echo "it87" | tee /etc/modules-load.d/it87.conf
dracut --regenerate-all --force
modprobe -r it87 && modprobe it87 ignore_resource_conflict=1
# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket
