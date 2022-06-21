read -p "Enter date (YYYYMMDDHHmm): " dateinput 
date -s $dateinput

echo "date set to $dateinput"
echo " "
echo "_________________________________"

read -p "Enter Scenario name " scenario

mkdir -p $scenario # create directory for scenario if it doesn't allready exist
cd $scenario


echo " running meshmerize link"
echo " "
echo "_________________________________"
meshmerize link
echo " "
echo "_________________________________"
echo ""
echo " ipv6 neighbors are:"
echo " "
ip -6 neigh show
echo " "
echo "_________________________________"
echo "  "
echo " "
#read -p 'server-ip: ' server_ip

echo " choose target router ( server) out of router 1 to 5"
echo "  "
echo " "
read -p 'type router number  ' router_number
ipv6_address=( [1]="fe80::9683:c4ff:fe04:5d1b%wlan0" [2]="fe80::9683:c4ff:fe10:23db%wlan0" [3]="fe80::9683:c4ff:fe10:241d%wlan0" [4]="No IP" [5]="fe80::9683:c4ff:fe10:23b7%wlan0")

server_ip=${ipv6_address[router_number]}

echo "  "
echo " "

echo " server address is $server_ip which is router $router_number"
echo " "
echo "_________________________________"
echo "  "
echo " "
read -p "set script run time" runtime
echo "  "
echo " "


echo "starting iperf client"
echo ".."
echo " "


iperf -V -c $server_ip  -i 1 -u -b 1G -t $runtime -y C > iperf_log_$HOSTNAME_$(date +%Y-%m-%d-%H:%M:%S).csv &

echo " iperf is connected to $server_ip"
echo " "
echo " "
echo "_________________________________"
echo " "
echo  "starting ping client" 
echo ".."
echo " "

bash pingc -6 $server_ip  > ping_log_$HOSTNAME_$(date +%Y-%m-%d-%H:%M:%S).csv &


echo " ping is running" 
echo " "
echo " "
echo "_________________________________"
echo " "
echo " starting tcpdump"
echo ".."
echo " "
tcpdump  -i wlan0  -s 0 -w dump_$HOSTNAME_$(date +%Y-%m-%d-%H:%M:%S).pcap &
echo " "
echo " tcpdump is running"
echo " "
