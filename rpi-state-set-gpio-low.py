#!/usr/bin/python
import RPi.GPIO as GPIO

# Define pin
GPIO_PIN = 22

# Setup pin
GPIO.setmode(GPIO.BCM)
GPIO.setup(GPIO_PIN, GPIO.OUT)

# Set pin
GPIO.output(GPIO_PIN, GPIO.LOW)
