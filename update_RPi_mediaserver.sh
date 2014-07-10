# RPi_mediaserver UPDATE SCRIPT
#    
#	Copyright (C) <year>  Tim Massey
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

$SCRIPTS/ola_git_update.sh
echo "OLA updated from GIT REPO"

$SCRIPTS/RPi_mediaserver_git_update.sh
echo "RPi_mediaserver updated from GIT REPO"

$SCRIPTS/ola-rpiui_git_update.sh
echo "OLA-RPIUI updated from GIT REPO"

exit 
