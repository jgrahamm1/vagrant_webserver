#!/usr/bin/env bash

### IP Change 1=old_IP 2=new_IP
if [ \("$1" != "" -a "$2" != ""\) ]; then
	sed -i '.bak' "s/$1/$2/g" ../bootstrap.sh
	sed -i '.bak' "s/$1/$2/g" ../Vagrantfile
	sed -i '.bak' "s/$1/$2/g" ../000-default.conf
	sed -i '.bak' "s/$1/$2/g" *.sh	
	rm *.bak
	rm ../*.bak
else
	echo "USAGE: $0 <old_ip> <new_ip>"
fi
