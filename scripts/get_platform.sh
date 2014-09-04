#! /bin/sh -
 
#########################
# 
# Name: get_plastform.sh
#
# Purpose: Retrieve current platform name to use with ec-conf
#
# Usage: ./get_platform.sh -t (build|run)
#
# Revision history: 2014-04-08  --  Script created, Martin Evaldsson, Rossby Centre
#
# Contact persons:  martin.evaldsson@smhi.se
#
########################

program=$0

function usage {
 echo "Usage: ./get_platform.sh -t (build|run)
" 1>&2 
}

function usage_and_exit {
  exit_code=${1:-0}
  usage
  exit $exit_code
}

if [ ! $# -eq 2 ]; then
  echo "Wrong number of arguments" 1>&2
  usage_and_exit
fi

while (( "$#" )); do 
  case $1 in 
     -t)
        type=$2
        shift 2
        ;;
     --help|--hel|--he|--h|-help|-hel|-he|-h)
        usage_and_exit
        ;;
      --)
        set --
        ;;
      *)
        printf '\n%s\n\n' "Unknown flag $1" 1>&2
        usage_and_exit 1
        ;;
  esac  
done
platform_file="configurations/platforms.txt"
hostname=$(hostname)
if [ "$type" == "run" ]; then
    platform=$(awk -v key=${hostname}_run '//{print $2}'
elif [ "$type" == "build" ]; then
    platform=2
else
    printf '\n%s\n\n' "Invalid argument type=${type}" 1>&2
    usage_and_exit 1
fi
echo $platform
