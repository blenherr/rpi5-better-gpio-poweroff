#!/usr/bin/python
"""Sets a GPIO pin LOW"""

import RPi.GPIO as GPIO

GPIO_PIN = 4

GPIO.setmode(GPIO.BCM)
GPIO.setup(GPIO_PIN, GPIO.OUT)

GPIO.output(GPIO_PIN, GPIO.LOW)
