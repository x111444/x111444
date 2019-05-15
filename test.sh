#!/bin/bash
tput cup 0 0
echo "-name-------------------CMD----------------PID----STIME---"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "-                    -                    -     -        -"
echo "----------------------------------------------------------"
echo "if you want to exit, Please type q                        "
arr=($(cut -d: -f 1 /etc/passwd|sort))
for((i=1;i<21;i++))
do
tput cup $i 2
echo "${arr[$i-1]}"
done

ap=1
dp=2
key=""
checkdp=
checkap=
tput civis
tput cup 1 2
echo  [41m "${arr[0]}" [0m

arrcmd=($(ps -fu ${arr[0]} | cut -b51-69))

for((i=1;i<21;i++))
do
tput cup $i 22
echo "${arrcmd[$i]}"
done

arrpid=($(ps -fu ${arr[0]} | cut -b11-15))

for((i=1;i<21;i++))
do
tput cup $i 43
echo "${arrpid[$i]}"
done

arrstime=($(ps -fu ${arr[0]} | cut -b26-31))

for((i=1;i<21;i++))do
tput cup $i 50
echo "${arrstime[$i]}"
done


until [ "${key}" == "q" ]
do

 read -n 1 key

if [ "${key}" == "w" ];then

if [ "${dp}" == "2" ];then

tput cup $ap $dp
echo  [0m "${arr[$ap-1]}"  [0m

let ap=$ap-1
if [ "${ap}" == "0" ];then
let ap=$ap+1
fi

tput cup $ap $dp
echo  [41m "${arr[$ap-1]}" [0m

unset arrcmd
unset arrpid
unset arrstime

for((i=1;i<21;i++))
do
tput cup $i 22
echo "                   "
done

for((i=1;i<21;i++))
do
tput cup $i 43
echo "     "
done

for((i=1;i<21;i++))
do
tput cup $i 50
echo "     "
done

arrcmd=($(ps -fu ${arr[$ap-1]} | cut -b51-69))

for((i=1;i<21;i++))
do
tput cup $i 23
echo "${arrcmd[$i]}"
done

arrpid=($(ps -fu ${arr[$ap-1]} | cut -b11-15))

for((i=1;i<21;i++))
do
tput cup $i 43
echo "${arrpid[$i]}"
done

arrstime=($(ps -fu ${arr[$ap-1]} | cut -b26-31))

for((i=1;i<21;i++))do
tput cup $i 50
echo "${arrstime[$i]}"
done


else

tput cup $ap $dp
echo  [0m "${arrcmd[$ap]}"  [0m

let ap=$ap-1
if [ "${ap}" == "0" ];then
let ap=$ap+1
fi
tput cup $ap $dp
echo  [42m "${arrcmd[$ap]}" [0m

fi

 
elif [ "${key}" == "s" ];then
if [ "${dp}" == "2" ];then

tput cup $ap $dp
echo  [0m "${arr[$ap-1]}" [0m

let ap=$ap+1
if [ "${ap}" == "21" ];then
let ap=$ap-1
fi

tput cup $ap $dp
echo [41m "${arr[$ap-1]}" [0m

unset arrcmd
unset arrpid
unset arrstime

for((i=1;i<21;i++))
do
tput cup $i 23
echo "                   "
done

for((i=1;i<21;i++))
do
tput cup $i 43
echo "     "
done

for((i=1;i<21;i++))
do
tput cup $i 50
echo "     "
done

arrcmd=($(ps -fu ${arr[$ap-1]} | cut -b51-69))

for((i=1;i<21;i++))
do
tput cup $i 23
echo "${arrcmd[$i]}"
done

arrpid=($(ps -fu ${arr[$ap-1]} | cut -b11-15))

for((i=1;i<21;i++))
do
tput cup $i 43
echo "${arrpid[$i]}"
done

arrstime=($(ps -fu ${arr[$ap-1]} | cut -b26-31))

for((i=1;i<21;i++))do
tput cup $i 50
echo "${arrstime[$i]}"
done

else

tput cup $ap $dp
echo  [0m "${arrcmd[$ap]}"  [0m

let ap=$ap+1
if [ "${arrcmd[$ap]}" == "" ];then
let ap=$ap-1
elif [ "${ap}" == "21" ];then
let ap=$ap-1
fi

tput cup $ap $dp
echo  [42m "${arrcmd[$ap]}" [0m



fi






elif [ "${key}" == "d" ]
then
let checkap=$ap
let checkdp=$dp
let dp=23
let ap=1
tput cup $ap $dp
echo [42m "${arrcmd[$ap]}" [0m



elif [ "${key}" == "a" ]
then
tput cup $checkap $checkdp
echo [0m "${arr[$checkap-1]}" [0m

let dp=2
let ap=1
tput cup $ap $dp
echo [41m "${arr[$ap-1]}" [0m

for((i=1;i<21;i++))
do
tput cup $i 23
echo "                   "
done

for((i=1;i<21;i++))
do
tput cup $i 43
echo "     "
done

for((i=1;i<21;i++))
do
tput cup $i 50
echo "     "
done


arrcmd=($(ps -fu ${arr[0]} | cut -b51-69))

for((i=1;i<21;i++))
do
tput cup $i 22
echo "${arrcmd[$i]}"
done

arrpid=($(ps -fu ${arr[0]} | cut -b11-15))

for((i=1;i<21;i++))
do
tput cup $i 43
echo "${arrpid[$i]}"
done

arrstime=($(ps -fu ${arr[0]} | cut -b26-31))

for((i=1;i<21;i++));do
tput cup $i 50
echo "${arrstime[$i]}"
done



else

tput cup $ap $dp
if [ "${dp}" == "2"  ]
then
echo  [41m "${arr[$ap-1]}" [0m

else

echo [42m "${arrcmd[$ap]}" [0m

fi

fi

done

clear
tput cup  0 0

