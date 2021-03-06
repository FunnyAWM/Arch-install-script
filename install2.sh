#! /bin/bash
#定义文文字颜色
r='\033[1;31m'	#---红
g='\033[1;32m'	#---绿
y='\033[1;33m'	#---黄
b='\033[1;36m'	#---蓝
w='\033[1;37m'	#---白
rw='\033[1;41m'    #--红白
wg='\033[1;42m'    #--白绿
ws='\033[1;43m'    #--白褐
wb='\033[1;44m'    #--白蓝
wq='\033[1;45m'    #--白紫
wa='\033[1;46m'    #--白青
wh='\033[1;46m'    #--白灰
h='\033[0m'		   #---后缀
bx='\033[1;4;36m'  #---蓝 下划线
wy='\033[1;41m' 
h='\033[0m'
#本地化
clear
rm /etc/locale.gen
echo "Which language will you use for default language?"
echo "1.Chinese."
echo "2.English."
read -p "[1,2]" language
case $language in
1)
  echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
  locale-gen
  rm /etc/locale.conf
  echo "LANG=zh_CN.UTF8" >> /etc/locale.conf
  echo "LANG=en_US.UTF8" >> /etc/locale.conf
  ;;
2)
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
  locale-gen
  rm /etc/locale.conf
  echo "LANG=en_US.UTF8" >> /etc/locale.conf
  ;;
esac
bash adduser.sh
#安装桌面
clear
pacman -S xorg
echo "Please choose your GPU"
echo $(echo -e "${b}1.Intel${h}") 
echo $(echo -e "${r}2.AMD${h}") 
echo $(echo -e "${r}3.ATI${h}") 
echo $(echo -e "${g}4.NVDIA(blob driver)${h}") 
read -p "If you have two GPUs,then entertwo numbers(ATI and NVIDIA,ATI and AMD could not appear in the same time):"  GPU
case $GPU in
 1)
  pacman -S xf86-video-intel --noconfirm
  ;;
 2)
  pacman -S xf86-video-amdgpu --noconfirm
  ;;
 3)
  pacman -S xf86-video-ati --noconfirm
  ;;
 4)
  pacman -S nvidia nvidia-utils nvidia-settings opencl-nvidia --noconfirm
  ;;
 12)
  pacman -S xf86-video-intel xf86-video-amdgpu --noconfirm
  ;;
 13)
  pacman -S xf86-video-intel xf86-video-ati --noconfirm
  ;;
 14)
  pacman -S xf86-video-intel nvidia nvidia-utils nvidia-settings opencl-nvidia --noconfirm
  ;;
 24)
  pacman -S xf86-video-amdgpu nvidia nvidia-utils nvidia-settings opencl-nvidia --noconfirm
  ;;
esac
clear
echo "Which desktop environment do you want to install?"
echo "1.KDE-full"
echo "2.KDE-minimal"
echo "3.GNOME"
echo "4.Xfce"
echo "5.MATE"
echo "6.LXDE"
echo "7.Cinnamon"
read -p "8.i3wm"
case $desktop in
  1)
    pacman -S plasma kde-applications sddm --noconfirm
    systemctl enable sddm
    ;;
  2)
    pacman -S plasma dolphinn okular kate konsole --noconfirm
    systemctl enable sddm
    ;;
  3)
    pacman -S gnome gdm --noconfirm
    systemctl enable gdm
    ;;
  4)
    pacman -S xfce lightdm --noconfirm
    systemctl enable lightdm
    ;;
  5)
    pacman -S mate lightdm --noconfirm
    systemctl enable lightdm
    ;;
  6)
    pacman -S lxde lightdm --noconfirm
    systemctl enable lightdm
    ;;
  7)
    pacman -S cinnamon lightdm --noconfirm
    systemctl enable lightdm
    ;;
  8)
    pacman -S i3wm lightdm --noconfirm
    systemctl enable lightdm
    ;;
esac
echo "Which Internet browser do you want to choose?"
echo "1.Firefox"
echo "2.Google Chrome(for Chinese user)"
read -p "3.Chromium" browser
case $browser in
  1)
    pacman -S firefox --noconfirm
    ;;
  2)
    pacman -S google-chrome --noconfirm
    ;;
  3)
    pacman -S chromium --noconfirm
    ;;
 esac
echo "Which office suite do you want to use?"
echo "1.Libreoffice"
echo "2.WPS(for Chinese user)"
read -p "3.No office suite" office
case $office in
  1)
    pacman -S libreoffice --noconfirm
    ;;
  2)
    pacman -S wps-office-cn wps-office-mime-cn wps-office-mui-zh-cn --noconfirm
    ;;
 esac
read -p "Do you need some softwares for Chinese user[y/n]?" softcn
case $softcn in
y)
  pacman -S netease-cloud-music wine-wechat --noconfirm
  ;;
n)
  clear
  ;;
esac
echo "Witch way do you want to boot up your computer?"
echo "1.Legacy"
read -p "2.UEFI" boot
case $boot in
  1)
    pacman -S os-prober
    grub-install --target=i386-pc /dev/sda
    grub-mkconfig -o /boot/grub/grub.cfg
    ;;
  2)
    pacman -S efibootmgr os-prober
    read -p "Please select the EFI partition(example:sda1)" esp
    grub-install --target=x86_64-efi --efi-directory=/dev/$esp --bootloader-id=ARCH
    ;;
 esac
echo "Now please enjoy your Arch Linux.Remember to pull out your USB drive first."
echo "Press any key to exit the installation.to reboot,please type in'reboot'"
read -p "Press any key to continue..."
rm -rf adduser.sh
rm -rf install2.sh
exit && reboot