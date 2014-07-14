# THIS IS A SCRIPT TO CLONE OLA-RPIUI GIT REPO AND MAKE & INSTALL IT
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
    
#!/bin/bash

KIVY_DIR=/home/pi/kivy
CYTHON_DIR=/home/pi/cython

echo "Installing KIVY dependencies"

sudo apt-get clean
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install python-setuptools python-pygame python-opengl python-gst0.10 \
python-enchant gstreamer0.10-plugins-good python-dev build-essential libgl1-mesa-dev \
libgles2-mesa-dev python-pip

echo "Installed dependancies"

echo "Installing CYTHON"

cd ..
mkdir $CYTHON_DIR
cd $CYTHON_DIR
sudo pip install --upgrade cython

echo "Installed CYTHON"

echo "KIVY downloading and installed for the first time from GIT REPO"

cd ..
git clone git://github.com/kivy/kivy.git
cd $KIVY_DIR
python setup.py build_ext --inplace -f
sudo python setup.py install

echo "KIVY successfully downloaded and installed for the first time from GIT REPO"

exit 
