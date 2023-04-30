#!/usr/bin/python3
import sys, argparse
from ctypes import *

parser = argparse.ArgumentParser()
parser.add_argument('focus', type=int, nargs='?')
args = parser.parse_args()

if args.focus and args.focus >= 0 and args.focus <= 1024:
  focus = args.focus
else:
  focus = 310

arducam_vcm = CDLL('/home/pi/arducam/Motorized_Focus_Camera/python/lib/libarducam_vcm.so')

arducam_vcm.vcm_init()
print("Setting arducam focus to ",focus)
try:
  arducam_vcm.vcm_write(focus)
except:
  print("Error calling arducam library")
