#!/bin/sh

set -euo pipefail

cat << "MATHABORED"
.___  ___.      ___   .___________. __    __       ___      .______     ______   .______       _______  _______  
|   \/   |     /   \  |           ||  |  |  |     /   \     |   _  \   /  __  \  |   _  \     |   ____||       \ 
|  \  /  |    /  ^  \ `---|  |----`|  |__|  |    /  ^  \    |  |_)  | |  |  |  | |  |_)  |    |  |__   |  .--.  |
|  |\/|  |   /  /_\  \    |  |     |   __   |   /  /_\  \   |   _  <  |  |  |  | |      /     |   __|  |  |  |  |
|  |  |  |  /  _____  \   |  |     |  |  |  |  /  _____  \  |  |_)  | |  `--'  | |  |\  \----.|  |____ |  '--'  |
|__|  |__| /__/     \__\  |__|     |__|  |__| /__/     \__\ |______/   \______/  | _| `._____||_______||_______/ 
                                                                                                                
MATHABORED

##########################
#add line to /etc/profile#
##########################

cat >> /etc/profile << "TRACK1"

#I know what have you done to my server.
    HISTTIMEFORMAT="%Y-%m-%d_%H:%M:%S "
    export HISTTIMEFORMAT

function history_to_syslog {
declare command
remoteaddr="`who am i`"
pwd="`pwd`"
command=$(fc -nl 0 | cut -b3-)
if [ "$command" != "$old_command" ]; then
logger -p local2.notice -t bash -i "user : $USER    Command : $command    Directory : $pwd"
fi
old_command=$command
}
trap history_to_syslog DEBUG

TRACK1

#######################
#make it as log files.#
#######################

cat >> /etc/rsyslog.conf << "TRACK2"

#track commands
local2.notice                                           /var/log/cmd.log

TRACK2

#####################
#restart the rsyslog#
#####################

systemctl restart rsyslog 
systemctl status rsyslog \
&& cat << "QUOTE"


Now excuted command line using root profile will be saved at /var/log/cmd.log.
이제부터 루트권한을 사용하여 실행된 명령어들은 /var/log/cmd.log 에 기록됩니다.

May you be in peace and leave the place.
이제 마음놓으시고 장소를 떠나셔도 좋습니다.
 
QUOTE


