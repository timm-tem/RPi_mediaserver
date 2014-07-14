# THIS IS A SCRIPT TO UPDATE OLA FROM THE GIT REPO
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

OLA_DIR=/home/pi/ola

sudo /etc/init.d/olad stop
cd
cd $OLA_DIR
git pull
autoreconf
./configure --enable-rdm-tests --enable-python-libs
make
sudo make install
sudo ldconfig
sudo /etc/init.d/olad start

echo "OLA updated from GIT REPO"

exit 