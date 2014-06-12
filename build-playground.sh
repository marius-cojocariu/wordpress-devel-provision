#!/bin/bash

plugin="cms-calendar"
port="89"

if [ $# -eq 0 ]; then
	version="latest"
else
	version="$1"
	port="${version//[-._]/}"
fi

if [ -d "playground-wp-$version" ]; then
  echo "You already have that version. Remove it manually if needed"
  exit 2
fi

if [ $version == "latest" ]; then
	link="http://wordpress.org/latest.tar.gz";
else
	link="http://wordpress.org/wordpress-$version.tar.gz";
fi

echo $link

if ! wget -O "wp-$version.tar.gz" $link; then
	echo "Wordpress version not found, check your internet connection"
	rm "wp-$version.tar.gz"
	exit 1
fi

rm -Rf "playground-wp-$version"
mkdir -p "playground-wp-$version"
tar xzf "wp-$version.tar.gz" --strip-components=1 -C "playground-wp-$version"
rm "wp-$version.tar.gz"
ln -s `pwd`/src "$PWD/playground-wp-$version/wp-content/plugins/$plugin"

cd "playground-wp-$version"
cp ../Vagrantfile ../bootstrap.sh .
sed -i "s/8088/80$port/g" Vagrantfile

vagrant up
vagrant reload
