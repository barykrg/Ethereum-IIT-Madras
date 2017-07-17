#sed  -e 's/Tx(/0x/;s/) to (Debug message)://' logMinter.log > transactionHash


#sed -e 's/Tx(\(.*\) to (Debug message):/\1/' logMinter.log > transactionHash
grep -o '\Tx(.*) '  $1 | sed  -e 's/Tx(0x//;s/) //' > transactionHash.txt


