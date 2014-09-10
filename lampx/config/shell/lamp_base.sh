#!/bin/sh
if cd "`dirname \"$0\"`"; then
    absdirpath=`pwd`
    cd "$OLDPWD" || exit 1
else
    exit 1
fi
SCRIPTDIR=$absdirpath
BASEDIR=$(dirname $SCRIPTDIR)
SCRIPTNAME=$(basename $0 .sh)

echo ""
echo "===== $SCRIPTNAME ====="
echo ""

echo "update.."
sudo apt-get update

echo "install dependencies..."
echo mysql-server mysql-server/root_password select "vagrant" | debconf-set-selections
echo mysql-server mysql-server/root_password_again select "vagrant" | debconf-set-selections
sudo apt-get install -y ntp lynx finger zip bzip2 vim curl apache2 mysql-server git subversion git-svn libapache2-mod-php5 php5 php5-mysql php5-curl php5-gd php5-mcrypt libapache2-mod-wsgi python-pip python-virtualenv openjdk-6-jdk tomcat7-user libapache2-mod-jk libapache2-mod-suphp

cp /home/vagrant/files/suphp.conf /etc/suphp/suphp.conf

a2dismod php5
a2enmod rewrite
a2enmod headers
a2enmod wsgi
a2enmod jk

service apache2 restart

echo "set rights for suphp.."
chown vagrant:www-data /home/vagrant
chmod 710 /home/vagrant

echo "create logs dir .."
mkdir -p /home/vagrant/logs
chown -R vagrant:vagrant /home/vagrant/


NODE_VERSION="0.10.31"

echo "download precompiled node.."
MACHINE_TYPE=`uname -m`
ARCHSTR="x86"
if [ "${MACHINE_TYPE}" = "x86_64" ]; then
	ARCHSTR="x64"
fi
cd /tmp
wget http://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-${ARCHSTR}.tar.gz -O node.tar.gz
tar xfz node.tar.gz
mkdir -p /opt/node
PATHTONODE=/opt/node/node-v${NODE_VERSION}
mv node-v${NODE_VERSION}-linux-${ARCHSTR} $PATHTONODE
ln -s $PATHTONODE/bin/node /usr/local/bin/node
ln -s $PATHTONODE/bin/node /usr/bin/node 
ln -s $PATHTONODE/bin/npm /usr/local/bin/npm 
ln -s $PATHTONODE/bin/npm /usr/bin/npm 

echo "various settings..."
usermod -a -G adm vagrant

echo "cleanup.."
rm -rf /home/vagrant/files

