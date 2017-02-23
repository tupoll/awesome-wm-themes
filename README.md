#### awesome
### Dependencies

* awesome v3.5.9 (works with latest git version)
* LuaDBI - A database interface library for Lua

### Install

```bash
git clone https://github.com/tupoll/awesome.git ~/.config/awesome

```

Copy from /bin to /usr/local/ bin necessary files for widgets, and give them the right to run.

chmod 755 /usr/local/bin/skb
chmod 755 /usr/local/bin/gscrot
chmod 755 /usr/local/bin/cpu

chmod +x ~/.config/awesome/unity/memory/memory.sh

cd /usr/ports/multimedia/libav && make install clean
pkg lock libav

When assembling specify flag 'sdl'

####
to get to lain.weather widget checking in, download the file city.list.json.gz parse your id:
tupoll @ shell ~% cat /home/tupoll/Downloads/city.list.json | grep Vladivostok
{ "_id": 2013348, "name": "Vladivostok", "country": "RU", "coord": { "lon": 131.873535, "lat": 43.105621}}.Na your site create a key -All write in lain.weather
# awesome-freebsd-ru
