#!/bin/bash
old_dir="`pwd`/`basename "$0"`"
old_dir=`dirname "$old_dir"`
cd "`dirname "$0"`"
script_dir="`pwd`/`basename "$0"`"
script_dir=`dirname "$script_dir"`

current_os=$1
current_user=$2
current_user_group=$3
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
	elif [ $current_os = "Linux" ]
	then
		if [ `grep -i debian /etc/issue | wc -l` -gt "0" ]
		then
			current_os="Debian"
			
		elif [ `grep -i ubuntu /etc/issue | wc -l` -gt "0" ]
		then
			current_os="Ubuntu"
		else
			echo "Run as root !"
		fi
	elif [ $current_os = "Darwin" ]
	then
		echo "Mac X: Run as root !"
	elif [ $current_os = "HP-UX" ]
	then
		echo "HP-UX: Run as root !"
	else
		echo "UnknownOS: Run as root !"
	fi
fi

if [ $current_os = "Debian" ]
then
	su --preserve-environment -c "/etc/init.d/nginx stop || apt-get install unzip libpcre3 libpcre3-dev openssl libssl-dev build-essential"
elif [ $current_os = "Ubuntu" ]
then
	sudo /etc/init.d/nginx stop
	sudo apt-get install unzip libpcre3 libpcre3-dev openssl libssl-dev build-essential
else
	echo -e "$current_os is not yet supported\n"
fi
NGINX_PATH=nginx-1.9.9

rm -rf nginx-1.9.9*
rm -rf nginx-rtmp-module-master*

wget http://nginx.org/download/"$NGINX_PATH".tar.gz
tar -xzvf "$NGINX_PATH".tar.gz

wget https://github.com/arut/nginx-rtmp-module/zipball/master -O nginx-rtmp-module-master.zip
unzip nginx-rtmp-module-master.zip -d nginx-rtmp-module-master

cd $NGINX_PATH
./configure --prefix=/usr --conf-path=/etc/nginx/nginx.conf --add-module=../nginx-rtmp-module-master/arut-nginx-rtmp-module-*/ --pid-path=/var/run/nginx.pid --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-http_ssl_module
make

if [ $current_os = "Debian" ]
then
	su --preserve-environment -c "make install && /etc/init.d/nginx start"
elif [ $current_os = "Ubuntu" ]
then
	sudo make install
	sudo /etc/init.d/nginx start
else
	echo -e "$current_os is not yet supported\n"
fi

echo -e "\nPress <ENTER> to continue"
read OS
