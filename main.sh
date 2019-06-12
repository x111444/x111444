#!/bin/bash

cursor=0
sub_cursor=-1
flag=0
wh=$(whoami)
input="   "
more=0
more1=`expr $more + $i`
function logo() {
	echo ""
	echo '______                     _    _             '
	echo '| ___ \                   | |  (_)             '
	echo '| |_/ / _ __   __ _   ___ | |_  _   ___   ___  '
	echo '|  __/ |  __| / _  | / __|| __|| | / __| / _ \ '
	echo '| |    | |   | (_| || (__ | |_ | || (__ |  __/ '
	echo '\_|    |_|    \__,_| \___| \__||_| \___| \___| '
	echo ""
	echo '(_)       | |    (_)                    '
	echo ' _  _ __  | |     _  _ __   _   _ __  __'
	echo '| ||  _ \ | |    | ||  _ \ | | | |\ \/ /'
	echo '| || | | || |____| || | | || |_| | >  < '
	echo '|_||_| |_|\_____/|_||_| |_| \__,_|/_/\_\'
	echo ""
}

function getUsers() {
	#using ps, get Uers, return to arrUsers
	arrUsers=(`ps -ef | cut -f 1 -d " " | sed "1d" | sort | uniq`)
}

function getCmds() {
	#IFS : Internal Field Separator 내부 필드 구분자

	#using ps, get CMDs, return to arrCmds
	ps -ef O-p > temp
	grep ^$1 temp > psfu
	rm ./temp
	IFS_backup="$IFS"
	# backup IFS
	IFS=$'\n'
	arrCmds=(`cat psfu | cut -c 54-`)
	arrPIDs=(`cat psfu | cut -c 11-15`)
	arrSTIMEs=(`cat psfu | awk '{print $5}'`)
	#arrSTIMEs=(`cat psfu | cut -c 25-29`)

	IFS="$IFS_backup"
	# restore IFS
}

getUsers
getCmds ${arrUsers[$cursor]}

numUsers=${#arrUsers[*]}
numCmds=${#arrCmds[*]}


highlight() {
	if [ $2 = $1 ]; then
		echo -n [$3m
	fi
}

stoppid() {
  if [ $wh = ${arrUsers[$cursor]} ]; then
   kill -9 ${arrPIDs[$sub_cursor]}
else
clear
echo error
sleep 3
fi
}


until [ "$input" = "q" -o "$input" = "Q" ]; do
clear
	getUsers
	getCmds ${arrUsers[$cursor]}

	numUsers=${#arrUsers[*]}
	numCmds=${#arrCmds[*]}

	# 1 + 20 + 1 + 20 + 1 + 5 + 1 + 8 + 1
	logo
	echo "-NAME-----------------CMD------------------PID---STIME----"
	for (( i=0; i < 20; i++)); do
        printf "|"
		highlight $i $cursor 41
		printf "%20s" ${arrUsers[$i]}
		echo -n [0m
        printf "|"
		IFS_backup="$IFS"
		IFS=$'\n'
        highlight $i $sub_cursor 42
		printf "%-20.20s|%5s|%8s" ${arrCmds[`expr $more + $i`]} ${arrPIDs[`expr $more + $i`]} ${arrSTIMEs[`expr $more + $i`]}
        echo -n [0m
        printf "|"
		IFS="$IFS_backup"
		printf "\n"
	done
	echo "----------------------------------------------------------"
	echo "If you want to exit , Please Type 'q' or 'Q'"
        echo "if you want to know produser's phone number type p"
        echo $more
        echo $sub_cursor
        echo $flag
    printf ""
        
	read -n 3 -t 3 input
       
	case "$input" 
	in
		[A) if [ $flag -eq 0 ]; then
                       [ $cursor -gt 0 ] && cursor=`expr $cursor - 1` 
                      else
                      if [ $sub_cursor -gt 0 ]; then
                        sub_cursor=`expr $sub_cursor - 1`
                      else
                      [ $more -ne 0 ] && more=`expr $more - 1`
                      fi
                       fi;;
		[B) if [ $flag -eq 0 ]; then 
				[ $cursor -lt `expr $numUsers - 1` ] && cursor=`expr $cursor + 1`
			elif [ $flag -eq 1 ]; then 
				if [ $sub_cursor -lt 19 ]; then 
                [ `expr $sub_cursor + $more` -lt `expr $numCmds - 1` ] && sub_cursor=`expr $sub_cursor + 1`
                else
                [ `expr $sub_cursor + $more` -lt `expr $numCmds - 1` ] && more=`expr $more + 1` 
                fi
			fi;;
        [C) [ $flag -eq 0 ] && sub_cursor=0 && flag=1;;
        [D) [ $flag -eq 1 ] && flag=0 && sub_cursor=-1 && more=0;;
          "") [ $flag -eq 1 ] && stoppid;;
          "p")clear;echo "010-xxxx-xxxx if you find error please call this number";sleep 3 
	esac
done

