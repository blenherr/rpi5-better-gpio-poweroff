#!/bin/sh

GPIO_PIN=22
TARGET_HIGH="multi-user.target"
TARGET_LOW="reboot.target halt.target poweroff.target"

FILENAME="rpi-state-set-gpio"
TEMP_DIR=$(mktemp -d)

# Create $TEMP_DIR/$FILENAME-high.py
echo "Create $TEMP_DIR/$FILENAME-high.py"
echo "#!/usr/bin/python" > $TEMP_DIR/$FILENAME-high.py
echo "import RPi.GPIO as GPIO" >> $TEMP_DIR/$FILENAME-high.py
echo "" >> $TEMP_DIR/$FILENAME-high.py
echo "# Define pin" >> $TEMP_DIR/$FILENAME-high.py
echo "GPIO_PIN = $GPIO_PIN" >> $TEMP_DIR/$FILENAME-high.py
echo "" >> $TEMP_DIR/$FILENAME-high.py
echo "# Setup pin" >> $TEMP_DIR/$FILENAME-high.py
echo "GPIO.setmode(GPIO.BCM)" >> $TEMP_DIR/$FILENAME-high.py
echo "GPIO.setup(GPIO_PIN, GPIO.OUT)" >> $TEMP_DIR/$FILENAME-high.py
echo "" >> $TEMP_DIR/$FILENAME-high.py
echo "# Set pin" >> $TEMP_DIR/$FILENAME-high.py
echo "GPIO.output(GPIO_PIN, GPIO.HIGH)" >> $TEMP_DIR/$FILENAME-high.py

# Create $TEMP_DIR/$FILENAME-low.py
echo "Create $TEMP_DIR/$FILENAME-low.py"
echo "#!/usr/bin/python" > $TEMP_DIR/$FILENAME-low.py
echo "import RPi.GPIO as GPIO" >> $TEMP_DIR/$FILENAME-low.py
echo "" >> $TEMP_DIR/$FILENAME-low.py
echo "# Define pin" >> $TEMP_DIR/$FILENAME-low.py
echo "GPIO_PIN = $GPIO_PIN" >> $TEMP_DIR/$FILENAME-low.py
echo "" >> $TEMP_DIR/$FILENAME-low.py
echo "# Setup pin" >> $TEMP_DIR/$FILENAME-low.py
echo "GPIO.setmode(GPIO.BCM)" >> $TEMP_DIR/$FILENAME-low.py
echo "GPIO.setup(GPIO_PIN, GPIO.OUT)" >> $TEMP_DIR/$FILENAME-low.py
echo "" >> $TEMP_DIR/$FILENAME-low.py
echo "# Set pin" >> $TEMP_DIR/$FILENAME-low.py
echo "GPIO.output(GPIO_PIN, GPIO.LOW)" >> $TEMP_DIR/$FILENAME-low.py

# Copy python files
echo "Copy python files into /usr/bin/"
sudo cp $TEMP_DIR/$FILENAME-high.py /usr/bin/$FILENAME-high.py
sudo cp $TEMP_DIR/$FILENAME-low.py /usr/bin/$FILENAME-low.py

# Change python file permissions
echo "Change python file permissions"
sudo chmod 755 /usr/bin/$FILENAME-high.py
sudo chmod 755 /usr/bin/$FILENAME-low.py

# Create $TEMP_DIR/$FILENAME-high.service
echo "Create $TEMP_DIR/$FILENAME-high.service"
echo "[Unit]" > $TEMP_DIR/$FILENAME-high.service
echo "Description=Listens for target and sets GPIO pin HIGH" >> $TEMP_DIR/$FILENAME-high.service
echo "Before=$TARGET_HIGH" >> $TEMP_DIR/$FILENAME-high.service
echo "DefaultDependencies=no" >> $TEMP_DIR/$FILENAME-high.service
echo "" >> $TEMP_DIR/$FILENAME-high.service
echo "[Service]" >> $TEMP_DIR/$FILENAME-high.service
echo "Type=oneshot" >> $TEMP_DIR/$FILENAME-high.service
echo "ExecStart=/usr/bin/python /usr/bin/$FILENAME-high.py" >> $TEMP_DIR/$FILENAME-high.service
echo "" >> $TEMP_DIR/$FILENAME-high.service
echo "[Install]" >> $TEMP_DIR/$FILENAME-high.service
echo "WantedBy=$TARGET_HIGH" >> $TEMP_DIR/$FILENAME-high.service

# Create $TEMP_DIR/$FILENAME-low.service
echo "Create $TEMP_DIR/$FILENAME-low.service"
echo "[Unit]" > $TEMP_DIR/$FILENAME-low.service
echo "Description=Listens for target and sets GPIO pin LOW" >> $TEMP_DIR/$FILENAME-low.service
echo "Before=$TARGET_LOW" >> $TEMP_DIR/$FILENAME-low.service
echo "DefaultDependencies=no" >> $TEMP_DIR/$FILENAME-low.service
echo "" >> $TEMP_DIR/$FILENAME-low.service
echo "[Service]" >> $TEMP_DIR/$FILENAME-low.service
echo "Type=oneshot" >> $TEMP_DIR/$FILENAME-low.service
echo "ExecStart=/usr/bin/python /usr/bin/$FILENAME-low.py" >> $TEMP_DIR/$FILENAME-low.service
echo "" >> $TEMP_DIR/$FILENAME-low.service
echo "[Install]" >> $TEMP_DIR/$FILENAME-low.service
echo "WantedBy=$TARGET_LOW" >> $TEMP_DIR/$FILENAME-low.service

# Copy services
echo "Copy services into /lib/systemd/system/"
sudo cp $TEMP_DIR/$FILENAME-high.service /lib/systemd/system/$FILENAME-high.service
sudo cp $TEMP_DIR/$FILENAME-low.service /lib/systemd/system/$FILENAME-low.service

# Enable services
echo "Enable services"
sudo systemctl enable $FILENAME-high.service
sudo systemctl enable $FILENAME-low.service

# Reload deamon
echo "Reload deamon"
sudo systemctl daemon-reload

# Done
echo "Done!"
