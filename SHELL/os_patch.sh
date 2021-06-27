#script to know os name
x=`cat /etc/redhat-release | sed 's/|/ /' | awk '{print $1, $8}'`
if [ $x = "CentOS" ]
then
echo "OS is : $x"
yum update -y
else
echo "Other OS"
apt-get update
apt-get upgrade -y
fi

#To check if reboot need 

if [ $x = "CentOS" ]
then
KERNEL_NEW=$(rpm -q --last kernel |head -1 | awk '{print $1}' | sed 's/kernel-//')
KERNEL_NOW=$(uname -r)
if [[ $KERNEL_NEW != $KERNEL_NOW ]] 
then 
echo "reboot_needed"
reboot
else 
echo "reboot_not_needed" 
fi
else 
echo "Ansible module can check for other OS"
echo "check reboot-required file is present"
if [ -e /var/run/reboot-required ]
then
echo "reboot_needed"
reboot
else
echo "reboot_not_needed" 
fi
