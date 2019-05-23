#!/bin/bash
###################################################################
#Description: This module will delete the user from the system.
#
#Arguments: USERNAME- The username which has to be deleted.
#Output: 0: If the user got deleted successfully 
#	 1: If the user is not found or it could not be deleted.
###################################################################
USERNAME=$1
Error_Info_Msg()
{
###########################################################################
#Description: This function will throw log messages depending on whether  #
#             the input is error or info.                                 #
#Arguments Used:                                                          #
###########################################################################

while true
        do
        if [ "$1" == "" ]
        then
                break
        fi
        case "$1" in
                -r | --resultvar ) RESULT_VAR=$2; shift 2 ;;
                -m | --msg ) MESSAGE="$2"; shift 2 ;;
                 * ) break ;
        esac
done
if [ $RESULT_VAR == 'err' ]
        then
               # echo "$MESSAGE"
                echo "[Err][$DATE]" ${MESSAGE}
elif [ $RESULT_VAR == 'info' ]
        then
                echo "[INF][$DATE]" ${MESSAGE}
fi

}
Usage()
{
echo "The usage of the script is - bash script_name ( -u USERNAME ) "
exit
}

if [ $# -eq 2 ]
then
	while true
		do
		if [ "$1" == "" ]
		then 
			break
		fi
		case "$1" in 
			-u | --username ) USERNAME=$2; shift 2;;
			-h ) Usage ;;
			* ) Usage ;
		esac
done
else
	Usage
fi





User_Delete()
{
#######################################################################################
#Description: This function will delete the user based upon the presence of the user.
#	      This will dlete the home folder of the user as well.
#
#
#######################################################################################
USERNAME=$1

if id $USERNAME > /dev/null
then
	Error_Info_Msg -r info -m "User found , Proceeding with deletion" 
	userdel -r $USERNAME 
	if [ $? -eq 0 ]
	then 
		Error_Info_Msg -r info -m "ptOutput><PrivateLog>User $USERNAME Deleted</PrivateLog><Status>Success</Status></ScriptOutput>"
		return 0
	else 
		Error_Info_Msg -r err -m "<ScriptOutput><PrivateLog>User $USERNAME could not be deleted, Please check manually</PrivateLog><Status>Failure</Status></ScriptOutput>"
		return 1
	fi
else
	Error_Info_Msg -r err -m "<ScriptOutput><PrivateLog>User $USERNAME not present in the system , Please provide the correct username</PrivateLog><Status>Failure</Status></ScriptOutput>"
	return 0
fi
}
User_Delete $USERNAME
