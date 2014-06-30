#!/usr/bin/env python3
from __future__ import print_function
import sys
import unittest
import threading
import pifacecommon
import pifacedigitalio
import argparse
import time
import multiprocessing


def test_input_pins(self):
        for pfd in pifacedigitals:
            for i in range(INPUT_RANGE):
                # input("Connect input {i}, then press enter.".format(i=i))
                pfd.output_pins[7-i].turn_on()
                self.assertEqual(pfd.input_pins[i].value, 1)
                pfd.output_pins[7-i].turn_off()
