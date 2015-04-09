#!/bin/bash

ANSIBLE=/usr/bin/ansible

help(){
   echo "usage: $0 -h <host> -u <username>" 
   echo "make sure user already exist on prmmg01"
   exit 1  
}

while getopts h:u: opt ; do
  case $opt in
      h) host=$OPTARG ;;
      u) username=$OPTARG ;;
      \?) help;;
  esac
done

if [ -z "$host" ] || [ -z "$username" ] ; then   
    help
fi    

uid=`grep -w $username /etc/passwd | awk -F: '{print $3}'`
comment=`grep -w $username /etc/passwd | awk -F: '{print $5}'`

if [ -z "$uid" ] ;  then
   help
fi 

$ANSIBLE -s $host -m group -a "name=app-dev gid=505 state=present"
$ANSIBLE -s $host -m user -a "name=$username comment=\"$comment\" uid=$uid group=app-dev"
$ANSIBLE -s $host -m authorized_key -a "user=$username key='{{ lookup('file', '/home/hana/dragon-ops/keys/$username.pub.key') }}'"