#author Antonio Tari, antonio@clearbridgemobile.com
MIN_JAVA_VER=18
MAX_JAVA_VER=18
INSTALL_FILES_DIR="nexus_install"
NEXUS_DIR="/usr/local/nexus"
JAVA_VER=$(java -version 2>&1 | sed -n ';s/.* version "\(.*\)\.\(.*\)\..*"/\1\2/p;')
echo "current java version: $JAVA_VER"
if [ $JAVA_VER -lt $MIN_JAVA_VER -o $JAVA_VER -gt $MAX_JAVA_VER ]; then
	sudo add-apt-repository ppa:webupd8team/java
	sudo apt update
	sudo apt install oracle-java8-set-default
fi

#wget https://download.sonatype.com/nexus/nexus-professional-bundle-latest.tar.gz
wget http://download.sonatype.com/nexus/3/latest-unix.tar.gz
mkdir $INSTALL_FILES_DIR
#mv latest-unix.tar.gz $INSTALL_FILES_DIR
tar xvzf latest-unix.tar.gz -C $INSTALL_FILES_DIR

DIR_NAME=$(ls $INSTALL_FILES_DIR | grep nexus)
echo $DIR_NAME
sudo mv "$INSTALL_FILES_DIR/$DIR_NAME" /usr/local/
sudo ln -s "/usr/local/$DIR_NAME" $NEXUS_DIR
echo "$NEXUS_DIR/bin/nexus start" >> nexus-startserver.sh
echo "$NEXUS_DIR/bin/nexus stop" >> nexus-stopserver.sh
chmod u+x nexus-startserver.sh
chmod u+x nexus-stopserver.sh
