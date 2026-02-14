# Table of contents
- [Information](#information)
- [Automatic installation](#automatic-installation)
- [Automatic remove](#automatic-remove)
- [Manual installation](#manual-installation)
- [Manual remove](#manual-remove)





# Information
- Replaces `dtoverlay=gpio-poweroff` by two python scripts and two services
- You can customize gpio pin
- You can customize target services





# Automatic installation
Download install script
```
wget https://raw.githubusercontent.com/blenherr/rpi5-better-gpio-poweroff/refs/heads/main/install.sh
```
Make changes to the file if necessary
```
nano install.sh
```
Run install script
`sh install.sh`


# Automatic remove
Download remove script
```
wget https://raw.githubusercontent.com/blenherr/rpi5-better-gpio-poweroff/refs/heads/main/remove.sh
```
Run remove script
`sh remove.sh`





# Manual installation
Clone repositorie
```
git clone https://github.com/blenherr/rpi5-better-gpio-poweroff.git
```
Change directory
```
cd rpi5-better-gpio-poweroff
```
Make changes to the files if necessary
```
nano rpi-state-set-gpio-high.py
```
```
nano rpi-state-set-gpio-low.service
```
```
nano rpi-state-set-gpio-high.py
```
```
nano rpi-state-set-gpio-low.service
```
Copy python files
```
sudo cp rpi-state-set-gpio-high.py /usr/bin/rpi-state-set-gpio-high.py && \
sudo cp rpi-state-set-gpio-low.py /usr/bin/rpi-state-set-gpio-low.py
```
Copy service files
```
sudo cp rpi-state-set-gpio-high.service /lib/systemd/system/rpi-state-set-gpio-high.service && \
sudo cp rpi-state-set-gpio-low.service /lib/systemd/system/rpi-state-set-gpio-low.service
```
Enable services
```
sudo systemctl enable rpi-state-set-gpio-high.service && \
sudo systemctl enable rpi-state-set-gpio-low.service
```
Reload deamon
```
sudo systemctl daemon-reload
```





# Manual remove
Disable services
```
sudo systemctl disable rpi-state-set-gpio-high.service && \
sudo systemctl disable rpi-state-set-gpio-low.service
```
Remove services
```
sudo rm /lib/systemd/system/rpi-state-set-gpio-high.service && \
sudo rm /lib/systemd/system/rpi-state-set-gpio-low.service
```
Remove python scripts
```
sudo rm /usr/bin/rpi-state-set-gpio-high.py && \
sudo rm /usr/bin/rpi-state-set-gpio-low.py
```
Reload deamon
```
sudo systemctl daemon-reload
```
