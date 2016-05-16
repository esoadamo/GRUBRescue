#Test results
workingOn="Ubuntu 14.04, 15.04, 15.10, 16.04"
notWorkingOn="Fedora 23"

#Defaults
device="sda"
number="1"

if [ -f /repairGRUBpart2.sh ]
then
	#This part is executed after chrooting to /mnt
	#$1 has to be device to install grub to
	echo "Part 2 continuing"
	echo "Installing grub"
	grub-install /dev/$1
	echo "Checking grub install"
	grub-install --recheck /dev/$1
	echo "Updating grub"
	update-grub
	echo "Removing part 2"
	rm /repairGRUBpart2.sh
	echo "====================================
Thank you for using this script :-)
Exiting"
	exit
fi

if [ "$1" = "--help" ]
then
	echo "This script will install grub on your PC from live OS"
	echo "Requirements:"
	echo "1) script is called \"repairGRUB.sh\" and is located inside working folder"
	if [ -f repairGRUB.sh ]
	then
		echo "	...Ok"
	else
		echo "	...fail!"
	fi

	echo "2) script is running with superuser permissions"
	user=$(whoami)
	if [ "$user" = "root" ]
	then
		echo "	...Ok"
	else
		echo "	...maybe? (Runned as $user)"
	fi

	echo "Script test results:"
	echo "	Tested as working on $workingOn"
	echo "	Tested as not working on $notWorkingOn"
	exit 0
fi

echo "Welcome to the repair GRUB 2 script. Made by Adam Hlavacek, 2015-2016. Feel free to use, modify, copy."
echo "For getting help or info about tested OS pass --help parameter
"

if [ ! -f repairGRUB.sh ]
then
	echo "Please rename script to \"repairGRUB.sh\" and move it inside working folder"
	exit 1
fi

infoSet="false"
while [ "$infoSet" != "true" ]
do
	user=$(whoami)
	if [ "$user" != "root" ]
	then
		echo "Warning: Has user $user superuser permissions?"
	fi

	lsblk
	echo "Enter the device target name: [$device] "
	read respond
	if [ "$respond" != "" ]
	then
		device=$respond
	fi

	fdisk -l /dev/$device
	echo "Enter the number of Linux partision: [$number] "
	read respond
	if [ "$respond" != "" ]
	then
		number=$respond
	fi
	echo "You entered that your Linux is located on /dev/$device$number"
	echo "Is that right? Y/n"
	read respond
	case "$respond" in
		"Y")
			infoSet="true"
		;;
		"")
			infoSet="true"
		;;
		"y")
			infoSet="true"
		;;
		*)
			clear
		;;
	esac
done

echo "Starting"

echo "Mounting Linux partision to mnt"
mount /dev/$device$number /mnt

echo "Mounting others"
mount --bind /dev /mnt/dev &&
mount --bind /dev/pts /mnt/dev/pts &&
mount --bind /proc /mnt/proc &&
mount --bind /sys /mnt/sys

echo "Coping scipt for part 2"
cp repairGRUB.sh /mnt/repairGRUBpart2.sh

echo "Making second part executable"
chmod +x /mnt/repairGRUBpart2.sh

echo "Changing root to mnt and executing part 2"
chroot /mnt ./repairGRUBpart2.sh $device
