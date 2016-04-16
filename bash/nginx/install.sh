#!/bin/bash
old_dir="`pwd`/`basename "$0"`"
old_dir=`dirname "$old_dir"`
cd "`dirname "$0"`"
script_dir="`pwd`/`basename "$0"`"
script_dir=`dirname "$script_dir"`

NGINX_PATH=nginx-1.9.9

current_os=$1
current_user=$2
current_user_group=$3
code_to_exec=$4
current_machine="$(uname -m)"	
if [ -z $current_user ]; then
	current_user="$(whoami)"
fi
if [ -z $current_user_group ]; then
	current_user_group="$(id -g --name)"
fi
if [ -z $current_os ]; then
	current_os="$(uname -s)"
fi
ID_UTILITY="id"
if [ $current_os = "SunOS" ]
then
	ID_UTILITY="/usr/xpg4/bin/id"
fi
if [ ! `$ID_UTILITY -u` = "0" ]
then
	if [ $current_os = "SunOS" ]
	then
		echo "Solaris: Run as root !"
		exit 2
	elif [ $current_os = "Linux" ]
	then
		if [ `grep -i debian /etc/issue | wc -l` -gt "0" ]
		then
			current_os="Debian"
			install_success="false"
			su --preserve-environment -c "bash $current_os $current_user $current_user_group" && install_success="true"
			if [ $install_success = "false" ]
			then
				exit 20
			fi
		elif [ `grep -i ubuntu /etc/issue | wc -l` -gt "0" ]
		then
			current_os="Ubuntu"
			install_success="false"
			sudo -E bash $current_os $current_user $current_user_group && install_success="true"
			if [ $install_success = "false" ]
			then
				exit 21
			fi
		else
			echo "Unknown Linux distributive is not supported yet"
			exit 2
		fi
	elif [ $current_os = "Darwin" ]
	then
		echo "Mac X is not supported yet"
		exit 2
	elif [ $current_os = "HP-UX" ]
	then
		echo "HP-UX is not supported yet"
		exit 2
	else
		echo "UnknownOS is not supported yet"
		exit 2
	fi
else
	if [ $current_os = "Debian" ] || [ $current_os = "Ubuntu" ]
	then
		if [ -z $code_to_exec ]; then
			install_success="false"
			apt-get install unzip libpcre3 libpcre3-dev openssl libssl-dev build-essential && install_success="true"
			if [ $install_success = "false" ]
			then
				exit 1
			fi
			exit 0
		else
			/etc/init.d/nginx stop
			
			update-rc.d -f nginx remove

			install_success="false"
			cd /tmp/$NGINX_PATH && install_success="true"
			if [ $install_success = "false" ]
			then
				exit 15
			fi
	
			install_success="false"
			make install && install_success="true"
			if [ $install_success = "false" ]
			then
				exit 4
			fi
			
			install_success="false"
			mv ../etc_init_d_nginx /etc/init.d/nginx && install_success="true"
			if [ $install_success = "false" ]
			then
				exit 5
			fi
			
			install_success="false"
			chmod +x /etc/init.d/nginx && install_success="true"
			if [ $install_success = "false" ]
			then
				exit 6
			fi
			
			install_success="false"
			update-rc.d -f nginx defaults && install_success="true"
			if [ $install_success = "false" ]
			then
				exit 7
			fi
			
			install_success="false"
			/etc/init.d/nginx start && install_success="true"
			if [ $install_success = "false" ]
			then
				exit 8
			fi
			
			exit 0
		fi
	fi
fi

rm -rf /tmp/etc_init_d_nginx
rm -rf /tmp/$NGINX_PATH*
rm -rf /tmp/nginx-rtmp-module-master*


install_success="false"
wget http://nginx.org/download/"$NGINX_PATH".tar.gz -O /tmp/"$NGINX_PATH".tar.gz && install_success="true"
if [ $install_success = "false" ]
then
	exit 10
fi

install_success="false"
tar -xzvf /tmp/"$NGINX_PATH".tar.gz -C /tmp && install_success="true"
if [ $install_success = "false" ]
then
	exit 11
fi

install_success="false"
wget https://raw.githubusercontent.com/JasonGiedymin/nginx-init-ubuntu/master/nginx -O /tmp/etc_init_d_nginx && install_success="true"
if [ $install_success = "false" ]
then
	exit 12
fi

install_success="false"
wget https://github.com/arut/nginx-rtmp-module/zipball/master -O /tmp/nginx-rtmp-module-master.zip && install_success="true"
if [ $install_success = "false" ]
then
	exit 13
fi

install_success="false"
unzip nginx-rtmp-module-master.zip -d /tmp/nginx-rtmp-module-master && install_success="true"
if [ $install_success = "false" ]
then
	exit 14
fi

install_success="false"
cd /tmp/$NGINX_PATH && install_success="true"
if [ $install_success = "false" ]
then
	exit 15
fi

install_success="false"
./configure --add-module=/tmp/nginx-rtmp-module-master/arut-nginx-rtmp-module-*/ --with-http_ssl_module && install_success="true"
if [ $install_success = "false" ]
then
	exit 16
fi

install_success="false"
make && install_success="true"
if [ $install_success = "false" ]
then
	exit 17
fi

if [ ! `$ID_UTILITY -u` = "0" ]
then
	if [ $current_os = "Debian" ]
	then
		su --preserve-environment -c "bash $current_os $current_user $current_user_group endcode_to_exec" && install_success="true"
		if [ $install_success = "false" ]
		then
			exit 18
		fi		
	elif [ $current_os = "Ubuntu" ]
	then
		sudo -E bash $current_os $current_user $current_user_group endcode_to_exec && install_success="true"
		if [ $install_success = "false" ]
		then
			exit 19
		fi
	fi
fi

echo -e "\nPress <ENTER> to continue"
read OS
