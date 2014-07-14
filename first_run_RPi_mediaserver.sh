# RPi_mediaserver FIRST RUN SCRIPT
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

SCRIPTS=/home/pi/RPi_mediaserver/scripts

sudo apt-get clean
sudo apt-get update
sudo apt-get upgrade

$SCRIPTS/kivy_git_firstrun.sh
echo "KIVY successfully downloaded and installed for the first time from GIT REPO"

$SCRIPTS/ola_git_firstrun.sh
echo "OLA successfully downloaded and installed for the first time from GIT REPO"

$SCRIPTS/ola-rpiui_git_firstrun.sh
echo "OLA-RPIUI successfully downloaded and installed for the first time from GIT REPO"

exit 