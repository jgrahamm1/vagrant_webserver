#!/usr/bin/env bash

### IP Change 1=old_IP 2=new_IP
if [ \("$1" != "" -a "$2" != ""\) ]; then
	
	# Linux and FreeBSD have different syntax for sed
	if [[ "$OSTYPE" == "linux-gnu" ]]; then
		sed -i -e "s/$1/$2/g" ../bootstrap.sh
		sed -i -e "s/$1/$2/g" ../Vagrantfile
		sed -i -e "s/$1/$2/g" ../000-default.conf
		sed -i -e "s/$1/$2/g" *.sh
	else
		sed -i '.bak' "s/$1/$2/g" ../bootstrap.sh
		sed -i '.bak' "s/$1/$2/g" ../Vagrantfile
		sed -i '.bak' "s/$1/$2/g" ../000-default.conf
		sed -i '.bak' "s/$1/$2/g" *.sh	
	fi
	rm -f *.bak
	rm -f ../*.bak
else
	echo "USAGE: $0 <old_ip> <new_ip>"
fi
