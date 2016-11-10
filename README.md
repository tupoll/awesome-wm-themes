#### awesome
### Dependencies

* awesome v3.5.9 (works with latest git version)
* LuaDBI - A database interface library for Lua

### Install

```bash
git clone https://github.com/tupoll/awesome.git ~/.config/awesome

```
touch /usr/local/bin/skb 
echo "xset -q | awk 'BEGIN { a[1]="ru"; a[0]="en"; } /LED/ { print a[$10 && 32]; }'">/usr/local/bin/skb
chmod 755 /usr/local/bin/skb

touch /usr/local/bin/cpu
 % cat /usr/local/bin/cpu
cpu="$(eval $(awk '/^cpu /{print "previdle=" $5 "; prevtotal=" $2+$3+$4+$5 }' /compat/linux/proc/stat);sleep 0.95; 
                eval $(awk '/^cpu /{print "idle=" $5 "; total=" $2+$3+$4+$5 }' /compat/linux/proc/stat);
                intervaltotal=$((total-${prevtotal:-0}));
                echo "$((100*( (intervaltotal) - ($idle-${previdle:-0}) ) / (intervaltotal) ))")"
echo "$cpu"
chmod 755 /usr/local/bin/cpu

chmod +x ~/.config/awesome/unity/memory/memory.sh
####
to get to lain.weather widget checking in, download the file city.list.json.gz parse your id:
tupoll @ shell ~% cat /home/tupoll/Downloads/city.list.json | grep Vladivostok
{ "_id": 2013348, "name": "Vladivostok", "country": "RU", "coord": { "lon": 131.873535, "lat": 43.105621}}.Na your site create a key -All write in lain.weather
# awesome-freebsd-ru
