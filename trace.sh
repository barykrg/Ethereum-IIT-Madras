#IFS=$'\n'       # make newlines the only separator
set -f          # disable globbing
#for i in $(cat < "$1") 
#do
#    myarray[j]="${i}"
 #   ((++j))
#done 
IFS=$'\n'
for k in $(cat < "$1") 
do
   nodeid[q]="${k}"
   ((++q))
done
: ' for ((l=0 ; l<j; l++))
do
 echo ${myarray[l]}
 
 echo "hello"
done '
# grep -o '\"time":".*"}' | sed  -e 's/^........//;s/\"\}//' |
count=0
trace_path() {
echo $2;
if(("$2"=="2"));then
((count++))
fi
command=`grep -R "$1" log$2.log | sort | grep -m 1 "tx" | grep -o '\"from":".*","payloadHash"' | sed  -e 's/"from":"//;s/","payloadHash"//'`
stat=`grep -R "\Tx(0x$1) "  log$2.log`
#echo $command
#echo $stat
if(( ${#stat} == 0 ))
then
  #recursion code goes here!!!
for ((l=0 ; l<q; l++))
do
   if [ "$command" == "${nodeid[l]}" ]
     then
	sav=$l;
	break
   fi
done
trace_path $1 $sav
  
else
  echo "-------------------------------------------------------------"
fi
}

#trace_path $2 $3
total=0
IFS=$'\n'
set -f
for i in $(cat < "$2") 
do
trace_path $i $3
((total++))
done
echo $count
echo $total
