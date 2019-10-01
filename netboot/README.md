Makes grub.efi to boot grub over UEFI network boot/iPXE/PXE

After building it, put the grub.efi and grub.cfg inside your netboot tftp folder to be served by dnsmasq. 

The grub.cfg can be customized in the tftp file, and machines boothing over network will load it from the tftp. 

This way, one can change the network boot menu without rebuilding grub.efi.
