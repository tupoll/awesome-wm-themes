#### awesome
### Dependencies

awesome devel (Too long)
 • Compiled against Lua 5.2.4 (running with Lua 5.2)
 • D-Bus support: ✔
 • execinfo support: ✔
 • xcb-randr version: 1.6
 • LGI version: 0.9.2

### Install

```bash
git clone https://github.com/tupoll/awesome.git ~/.config/awesome
```
touch /usr/local/bin/gscrot 
chmod 755 /usr/local/bin/gscrot
 % cat /usr/local/bin/gscrot
 notify-send "не тупи мышей обводи"
scrot -d10 -s -t '%Y-%m-%d_%h%M%S-$wx$h.png' -e 'mv $f /home/tupoll/Изображения/screenshots/'

chmod +x ~/.config/awesome/compact/mixer/vol.sh
chmod +x ~/.config/awesome/compact/mixer/mixer.sh
chmod +x ~/.config/awesome/compact/memory/memory.sh

cd /usr/ports/multimedia/libav && make install clean
pkg lock libav

When assembling specify flag 'sdl'
####
to get to lain.weather widget checking in, download the file city.list.json.gz parse your id:
tupoll @ shell ~% cat /home/tupoll/Downloads/city.list.json | grep Vladivostok
{ "_id": 2013348, "name": "Vladivostok", "country": "RU", "coord": { "lon": 131.873535, "lat": 43.105621}}.Na your site create a key -All write in lain.weather
####
The font size is adjusted to the monitor resolution. The left-hand offset of the widgets is adjusted in the rightmost widget.
# awesome-freebsd-ru


When you first start awesome-wm:

1) Change the access rights to run scripts *.sh-FreeBSD:
 chmod 755 ~/.config/awesome/compact/os/make_freebsd.sh
Linux: chmod 755 ~/.config/awesome/compact/os/make_linux.sh
chmod 755 ~/.config/awesome/compact/mount/df_linux.sh
as well as ~/.config/awesome/compact/memory/memory_linux.sh
if it’s not enough we move the last script to /usr/local/bin  or another place and allow sudo to run it.

2) In the os-widget menu, select the operating system:
Linux - will need to be re-logged after clicking.
FreeBSD - restart awesome-wm: restart.
DragonFly:
gsed must be installed
chmod 755 ~/.config/awesome/compact/os/make_dragonfly.sh
restart awesome-wm:  restart

Yandex-translate:
git clone https://github.com/delvin-fil/Yandex-translator-GUI.git
 move yatrans-gtk.py to ~ /.local/bin  or change the path in rc.lua
pip3.6 install optional packages are in the repositories for
Gentoo (Funtoo) linux.
