#!/bin/bash

sync;
#---------------------------------->Очистка стандартных логов + кэш
echo "[Очистка системы логов] => Процесс..."
sudo rm -Rf /home/$USER/.cache/*
sudo rm -Rf /tmp/*
sudo rm -Rf /var/cache/*
sudo rm -Rf /var/tmp/*
sudo rm -Rf /var/log/*
sudo find ~/ -depth -type f -name "*.cache" -delete
sudo find ~/ -depth -type f -name "*.log" -delete
echo "[Очистка системы логов] => Успешно :)"
#---------------------------------->Очистка логов пользователя
echo "[Очистка логов пользователя] => Процесс..."
#Системное
sudo rm -Rf /home/$USER/.cache
sudo rm -Rf /home/$USER/.ssh
sudo rm -Rf /home/$USER/.nv
sudo rm -Rf /home/$USER/.java
sudo rm -Rf /home/$USER/.thumbnails/
sudo rm -Rf /home/$USER/.oracle_jre_usage
sudo rm -Rf /home/$USER/Изображения/Screenshots/*
sudo rm -Rf /home/$USER/Изображения/Снимки\ экрана/*
sudo rm -Rf /home/$USER/Загрузки/*
sudo rm -Rf /home/$USER/Pictures/Screenshots/*
#Браузер
sudo rm -Rf /home/$USER/.mozilla/*
sudo rm /home/$USER/.mozilla
#Unity
sudo rm -Rf /opt/Unity/Editor/BugReporter
#wine
sudo rm -Rf /home/$USER/.wine/drive_c/windows/Installer
sudo rm -Rf /home/$USER/.wine/drive_c/users/$USER/Application\ Data/Unity
sudo rm /home/$USER/.wine/drive_c/users/$USER/Application\ Data/Unity
sudo rm -Rf /home/$USER/.wine/drive_c/users/$USER/Temp
sudo rm -Rf /home/$USER/.wine/drive_c/users/$USER/AppData/LocalLow/Unity
sudo rm /home/$USER/.wine/drive_c/users/$USER/AppData/LocalLow/Unity
#jdownloader
sudo rm -Rf /home/$USER/jd2/logs
sudo rm -Rf /home/$USER/jd2/tmp
sudo rm -Rf /home/$USER/jd2/cfg
sudo rm -Rf /home/$USER/jd2/jre
sudo rm /home/$USER/jd2/jre
sudo rm -Rf /home/$USER/jd2/output.log
sudo rm -Rf /home/$USER/jd2/error.log
#gradle
sudo rm -Rf /home/$USER/.gradle
sudo rm /home/$USER/.gradle
#openshot
sudo rm -Rf /home/$USER/.openshot_qt
sudo rm /home/$USER/.openshot_qt
#Загрузки
sudo rm -Rf /home/$USER/Downloads/*
sudo rm -Rf /home/$USER/Downloads/.*
#minecraft лаунчер
sudo rm -Rf /home/$USER/.tlauncher/bin
#root
sudo rm -Rf /root/*
sudo rm -Rf /root/.*
#DevelNext
sudo rm -Rf /home/$USER/.DevelNext/cache
sudo rm -Rf /home/$USER/.DevelNext/log
#Telegram
sudo rm -Rf /home/$USER/.local/share/TelegramDesktop/log.txt
sudo rm -Rf /home/$USER/.local/share/TelegramDesktop/tdata/user_data
sudo rm -Rf /home/$USER/.local/share/TelegramDesktop/tdata/emoji
sudo rm -Rf /home/$USER/.local/share/TelegramDesktop/tdata/dumps
sudo rm -Rf /home/$USER/.local/share/TelegramDesktop/tupdates
sudo rm /home/$USER/.local/share/TelegramDesktop/tupdates
#Дискорд
sudo rm -Rf /home/$USER/.config/discord/Cache
sudo rm -Rf /home/$USER/.config/discord/VideoDecodeStats
sudo rm -Rf /home/$USER/.config/discord/modules.log
#subl
sudo rm -Rf /home/$USER/.config/sublime-text-3/Cache
#compose-cache
sudo rm -Rf /home/$USER/.compose-cache/*
#android
sudo rm -Rf /home/$USER/.android
#pki
sudo rm -Rf /home/$USER/.pki
#run
sudo rm -Rf /home/$USER/.run
#bash
sudo rm -Rf /home/$USER/.bash_history
#mysql
sudo rm -Rf /home/$USER/.mysql_history
#wget
sudo rm -Rf /home/$USER/.wget-hsts
#python-history
sudo rm -Rf /home/$USER/.python-history
#Прочее
sudo rm -Rf /home/$USER/.gnupg
sudo rm -Rf /home/$USER/.password-store
sudo rm -Rf /home/$USER/.xsession-errors.old
sudo rm -Rf /home/$USER/.xsession-errors
sudo rm -Rf /home/$USER/.node_repl_history
sudo rm -Rf /home/$USER/.log.swp
sudo rm -Rf /home/$USER/.sudo_as_admin_successful
sudo rm -Rf /home/$USER/.local/share/epiphany
sudo rm /home/$USER/.local/share/epiphany
sudo rm -Rf /home/$USER/.local/share/flatpak
sudo rm /home/$USER/.local/share/flatpak
sudo rm -Rf /home/$USER/.local/share/webkitgtk
sudo rm /home/$USER/.local/share/webkitgtk
sudo rm -Rf /home/localhost/.config/mpv
sudo rm /home/localhost/.config/mpv
sudo rm -Rf /home/localhost/.config/epiphany
sudo rm /home/localhost/.config/epiphany
echo "[Очистка логов пользователя] => Успешно :)"
#---------------------------------->Очистка снап логов
echo "[Очистка снап логов] => Процесс..."
sudo rm -Rf /home/$USER/snap/telegram-desktop/current/.local/share/TelegramDesktop/log.txt
sudo rm -Rf /home/$USER/snap/telegram-desktop/current/.local/share/TelegramDesktop/tdata/user_data
sudo rm -Rf /home/$USER/snap/telegram-desktop/current/.local/share/TelegramDesktop/tdata/emoji
sudo rm -Rf /home/$USER/snap/telegram-desktop/current/.local/share/TelegramDesktop/tdata/dumps
sudo rm -Rf /home/$USER/snap/telegram-desktop/current/.local/share/TelegramDesktop/tupdates
sudo rm /home/$USER/snap/telegram-desktop/current/.local/share/TelegramDesktop/tupdates
echo "[Очистка снап логов] => Успешно :)"
#---------------------------------->Очистка памяти
echo "[Очистка памяти] => Процесс..."
sudo sysctl -w vm.drop_caches=4
echo "[Очистка памяти] => Успешно :)"
#---------------------------------->Очистка корзины
echo "[Очистка корзины] => Процесс..."
sudo rm -Rf /home/$USER/.local/share/Trash/files/*
sudo rm -Rf /home/$USER/.local/share/Trash/info/*
sudo rm -Rf /home/$USER/.local/share/Trash/expunged/*
#Очистка скрытых расширение
sudo rm -Rf /home/$USER/.local/share/Trash/files/.*
sudo rm -Rf /home/$USER/.local/share/Trash/info/.*
sudo rm -Rf /home/$USER/.local/share/Trash/expunged/.*
#Очистка всех корзин
for i in `ls /media/$USER`
do
    sudo rm -Rf /media/$USER/$i/.Trash-1000/files/*
    sudo rm -Rf /media/$USER/$i/.Trash-1000/info/*
    sudo rm -Rf /media/$USER/$i/.Trash-1000/expunged/*
    #Очистка скрытых расширение
    sudo rm -Rf /media/$USER/$i/.Trash-1000/files/.*
    sudo rm -Rf /media/$USER/$i/.Trash-1000/info/.*
    sudo rm -Rf /media/$USER/$i/.Trash-1000/expunged/.*
    "/media/$USER/$i"
done
echo "[Очистка корзины] => Успешно :)"

#---------------------------------->Настройка защиты сети
echo "[Настройка защиты сети] => Процесс..."
./inet.sh
echo "[Настройка защиты сети] => Успешно:)"
#---------------------------------->Очистка прочего
echo "[Очистка службы] => Процесс..."
sudo systemctl disable syslog
sudo systemctl disable apparmor
sudo systemctl disable rsyslog
sudo systemctl disable upower
sudo systemctl disable motd-news
echo "[Очистка службы] => Успешно:)"
#---------------------------------->Очистка apt
echo "[Очистка apt] => Процесс..."
# Устаревшие пакеты
dpkg -l | awk '/^rc/ {print $2}' | xargs sudo dpkg --purge 
sudo apt autoremove --purge
sudo rm -Rf /var/lib/apt/lists/*
sudo apt clean -y
sudo apt autoclean -y
sudo apt update
sudo apt install -f -y
#unlink dev package
dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
sudo apt autoremove
echo "[Очистка apt] => Успешно:)"
echo "[Очистка прочего] => Процесс..."
sudo apt -q -y purge flatpak epiphany-* alsa-* webkitgtk-* fonts-roboto* fonts-liberation-* fonts-croscore* fonts-noto-mono* fonts-kacst* fonts-noto-hinted* fonts-noto-hinted* fonts-sil-padauk* fonts-arphic-ukai* fonts-arphic-uming* fonts-droid-fallback* wine-development catdoc rygel lintian xterm torbrowser-launcher io.elementary.feedback* doc-base fig2dev ufw* torsocks orca cron hunspell* language* onboard rsyslog speech-dispatcher* brltty gsfonts geoclue opera-stable odysseus* chromium* irqbalance* rtkit* anacron* cron* xxd*
echo "[Очистка прочего] => Успешно:)"

#---------------------------------->Обновление прочего
echo "[Обновление прочего] => Процесс..."
sudo npm install -g npm
sudo rm -Rf /usr/local/lib/node_modules/changelogs
sudo rm -Rf /usr/local/lib/node_modules/docs
sudo rm -Rf /usr/local/lib/node_modules/man
sudo rm /usr/local/lib/node_modules/changelogs
sudo rm /usr/local/lib/node_modules/docs
sudo rm /usr/local/lib/node_modules/man
echo "[Обновление прочего] => Успешно:)"
#---------------------------------->Фикс прочего
echo "[Очистка Фикс прочего] => Процесс..."
#apache2
sudo mkdir /var/log/apache2
#mysql
sudo mkdir /var/log/mysql
sudo touch /var/log/mysql/error.log
sudo chmod 0777 /var/log/mysql/error.log
#nvidia
sudo chmod -R 0777 /etc/X11/
#Clear other
sudo systemd-resolve --flush-caches
sudo swapoff -a && sudo swapon -a
echo "[Очистка Фикс прочего] => Успешно:)"
#---------------------------------->Очистка локали
echo "[Очистка локали] => Процесс..."
sudo rm -Rf /var/lib/locales/supported.d/*
sudo rm -Rf /usr/lib/locale/*
sudo sh -c "echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen"
sudo sh -c "echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen"
sudo sh -c "echo 'ja_JP.UTF-8 UTF-8' >> /etc/locale.gen"
sudo locale-gen
echo "[Очистка локали] => Успешно :)"
#----------------------------------
echo "success ;)"<
