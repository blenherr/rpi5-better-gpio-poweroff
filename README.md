# Table of contents
- [Information](#information)
- [Automatic installation](#automatic-installation)
- [Automatic remove](#automatic-remove)
- [Manual installation](#manual-installation)
- [Manual remove](#manual-remove)





# Information
- Sets a gpio pin HIGH or LOW by given target service
- Two python scripts and two service files
- You can customize gpio pin and target services





# Automatic installation
Download install script
```
curl -O https://raw.githubusercontent.com/blenherr/rpi-gpio-ready-state/refs/heads/main/install.sh
```
Make changes to the file if necessary
```
nano install.sh
```
Run install script
```
sh install.sh
```


# Automatic remove
Download remove script
```
curl -O https://raw.githubusercontent.com/blenherr/rpi-gpio-ready-state/refs/heads/main/remove.sh
```
Run remove script
```
sh remove.sh
```





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
Change python file permissions
```
sudo chmod 755 /usr/bin/rpi-state-set-gpio-high.py && \
sudo chmod 755 /usr/bin/rpi-state-set-gpio-low.py
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
