# THIS IS A SCRIPT TO CLONE OLA GIT REPO AND MAKE & INSTALL IT
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

echo "Installing OLA dependencies"

sudo apt-get install libcppunit-dev libcppunit-1.12-1 uuid-dev pkg-config libncurses5-dev \
libtool autoconf automake  g++ libmicrohttpd-dev libmicrohttpd10 protobuf-compiler libprotobuf-lite7 \
python-protobuf libprotobuf-dev libprotoc-dev zlib1g-dev bison flex make libftdi-dev  libftdi1 \
libusb-1.0-0-dev liblo-dev libavahi-client-dev

echo "Installed OLA dependencies"
echo "Installing OLA"

OLA_DIR=/home/pi/ola

sudo apt-get install libcppunit-dev libcppunit-1.12-1 uuid-dev pkg-config libncurses5-dev libtool autoconf automake  g++ libmicrohttpd-dev libmicrohttpd10 protobuf-compiler libprotobuf-lite7 python-protobuf libprotobuf-dev libprotoc-dev zlib1g-dev bison flex make libftdi-dev  libftdi1 libusb-1.0-0-dev liblo-dev libavahi-client-dev

mkdir $OLA_DIR
git clone https://github.com/OpenLightingProject/ola.git ola
cd $OLA_DIR
autoreconf -i
./configure --enable-rdm-tests --enable-python-libs
make
make check
sudo make install
sudo ldconfig
sudo /etc/init.d/olad start

echo "OLA successfully downloaded and installed for the first time from GIT REPO"

exit 
