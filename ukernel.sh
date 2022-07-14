#!/bin/bash

sync;
VER=false #use false you not version
TYPE='generic'
#---------------------------------->Очистка Ядра
echo "[Очистка ядра] => Процесс..."
if [[ $VER != false ]]
then
	sudo apt -q install --reinstall linux-headers-$VER-$TYPE
	sudo apt -q install --reinstall linux-image-$VER-$TYPE
	sudo apt -q install --reinstall linux-modules-$VER-$TYPE
	sudo apt -q install --reinstall linux-modules-extra-$VER-$TYPE
else
	sudo apt -q install --reinstall linux-$TYPE
fi

SMODULES=$(ls -u /lib/modules | head -n1 | sed "s/-$TYPE//g")
echo $SMODULES
for iv in `ls /boot/`
do
	if [[ "config-$SMODULES-$TYPE" != $iv && "initrd.img-$SMODULES-$TYPE" != $iv && "System.map-$SMODULES-$TYPE" != $iv && "vmlinuz-$SMODULES-$TYPE" != $iv && $iv != "grub" && $iv != "initrd.img" && $iv != "vmlinuz" ]]
	then
		if [[ "$(read -e -p "Вы точно хотите удалить '/boot/$iv' ? [y/N] "; echo $REPLY)" == [Yy]* ]]
		then
			sudo rm -Rf "/boot/$iv*"
			echo "Clear => '$iv' success! :)"
		fi
	fi
done
for i in `ls /lib/modules`
do
	if [[ $i != $SMODULES && $i != "$SMODULES-$TYPE" ]]
	then
		if [[ "$(read -e -p "Вы точно хотите удалить '/lib/modules/$i' ? [y/N] "; echo $REPLY)" == [Yy]* ]]
		then
			sudo rm -Rf "/lib/modules/$i"
			sudo rm "/lib/modules/$i"
			echo "Clear => '$i' success! :)"
		fi
	fi
done

sudo rm -Rf /run/log/journal

#Удаление не нужного
#headers
for header in `dpkg -l | grep -i 'linux-headers' | cut -d' ' -f3`
do
	if [[ $header != "linux-headers-$SMODULES" && $header != "linux-headers-$TYPE" && $header != "linux-headers-$SMODULES-$TYPE" ]]
	then
	   sudo apt -q purge $header
	fi
done
#modules
for module in `dpkg -l | grep -i 'linux-modules' | cut -d' ' -f3`
do
	if [[ $module != "linux-modules-$SMODULES" && $module != "linux-modules-$SMODULES-$TYPE"  && $module != "linux-modules-extra-$SMODULES" && $module != "linux-modules-extra-$SMODULES-$TYPE" ]]
	then
	   sudo apt -q purge $module
	fi
done
#image
for image in `dpkg -l | grep -i 'linux-image' | cut -d' ' -f3`
do
	if [[ $image != "linux-image-$SMODULES" && $image != "linux-image-$TYPE" && $image != "linux-image-$SMODULES-$TYPE" ]]
	then
		sudo apt -q purge $image
	fi
done
echo "[Очистка ядра] => Успешно:)"
