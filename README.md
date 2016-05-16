GRUB rescue
===================


Ever reinstalled your dualboot Windows and then found out that your GRUB is gone? Or you just played with grub.cfg and now you cannot boot? Now, it is pretty easy to repair it. Just download this simple script an run it!

----------
## Installation & Running ##
Boot to LiveOS with same version as your installed Linux distribution, download the latest version of script from GitHub, make it executable and run it as root.

    wget https://raw.githubusercontent.com/esoadamo/GrubRescuse/master/repairGRUB.sh
    chmod +x repairGRUB.sh 
    sudo ./repairGRUB.sh 
And follow instructions from script. If you run into problem, check requirements, help and list of OS which are knew to not work.

## Requirements ##

 1. script has to be called repairGRUB.sh
 2. script has to be located in working directory
 3. script has to be run by root (or using sudo command) or by any user with superuser permissions

## Help ##
If you need, pass --help

    ./repairGRUB.sh --help
It will show informations about tested OS and if requirements are met.
## Working OS ##
OS that works out of the box

 - Ubuntu 14.04
 - Ubuntu 15.04
 - Ubuntu 15.10
 - Ubuntu 16.04

## Not working OS ##
These OS are know to not working without modification

 - Fedora 23 - problem with grub-install, user has to mount some directories
