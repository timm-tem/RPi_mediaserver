#Some useful options include:
#
#-l, --log-level <level>
#    This change the logging level, valid values are 0 (minimum logging) 
#    to 4 (full logs). At log level 3 (INFO) and above, all actions 
#    (variable assignments and commands) will be logged. 
#-o, --offset <slot_offset>
#    This applies an offset to the configured slots. For example if the 
#    config file contains definitions for slots 0 and 1, if ola_trigger is 
#    run with -o 10 it will watch for values on slots 10 and 11. Defaults to 0. 
#-u, --universe <universe>
#    Specifies the universe to use. Defaults to 1. 

while getopts u:o: option
do
        case "${option}"
        in
                u) UNIVERSE=${OPTARG};;
                o) OFFSET=${OPTARG};;                
        esac
done

killall olad &
ola_trigger -u $UNIVERSE -o $OFFSET /home/pi/RPi_mediaserver/scripts/trigger.conf &


echo "OLA Trigger is running using universe "$UNIVERSE" and channel "$OFFSET" "

exit 
