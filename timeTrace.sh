set -f          

IFS=$'\n'
for k in $(cat < "$1") 
do
   nodeid[q]="${k}"
   ((++q))
done
old_time="99.99999999"
trace_time() {
echo $2;
check=`grep -R "$1" log$2.log | sort | grep -m 1 "tx"`
if [[ "${#check}" -eq "0" ]]
then
exit
fi
new_time=`grep -R "$1" log$2.log | sort | grep -m 1 "tx" | grep -o '\"time":".*+' | cut -c26-36`
if (( $(echo "$3 < $new_time" |bc) ));then
exit
fi
command=`grep -R "$1" log$2.log | sort | grep -m 1 "tx" | grep -o '\"from":".*","payloadHash"' | sed  -e 's/"from":"//;s/","payloadHash"//'`
for ((l=0 ; l<q; l++))
do
   if [ "$command" == "${nodeid[l]}" ]
     then
	sav=$l;
	break
   fi
done
trace_time $1 $sav $new_time
}

trace_time $2 $3 $old_time

# $2=transaction hash $3=node id to start with


