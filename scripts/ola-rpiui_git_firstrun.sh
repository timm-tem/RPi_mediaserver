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

OLA-RPIUI_DIR=/home/pi/ola-rpiui

mkdir $OLA-RPIUI_DIR
git clone https://github.com/jesseanderson/ola-rpiui.git

echo "OLA-RPIUI successfully downloaded and installed for the first time from GIT REPO"

exit 
