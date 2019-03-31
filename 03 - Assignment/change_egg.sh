#!/bin/bash

length=`expr length $1`
if [ -z "$1" ]
  then
    echo "Usage $0 <EGG>"
    exit 1
  elif [ $length -ge 5 ]
    then
      echo "Please provide a 4 character argument"
      exit 1
fi

EGG=`printf $1 | od -An -t x1 | sed 's/ /\\\\x/g'`
echo "EGG:"$EGG

cat shellcode_temp.c | sed "s/EGG/`printf $1 | od -An -t x1 | sed 's/ /\\\\\\\\x/g'`/g" > shellcode_new.c
gcc -w -fno-stack-protector -z execstack shellcode_new.c -o shellcode_new
