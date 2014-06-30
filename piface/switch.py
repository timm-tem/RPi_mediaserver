# THIS IS THE PYTHON CODE FOR PiFACE SWITCH
#    
#	Copyright (C) 2014  Tim Massey
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#    Also add information on how to contact you by electronic and paper mail.
  
#!/usr/bin/python

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
