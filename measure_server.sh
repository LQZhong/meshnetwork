read -p "Enter date (YYYYMMDDHHmm): " dateinput 
date -s $dateinput


echo " running meshmerize link"
echo " "
echo "_________________________________"
meshmerize link
echo " "
echo "_________________________________"
echo ""

echo "_________________________________"
echo "  "
echo " "

my_ip=$(getent hosts $(cat /etc/hostname) | awk '{print $1; exit}')

echo " starting iperf server on $my_ip%wlan0"
echo ".. "

iperf -s -y C > server_log_$HOSTNAME_$(date +%Y-%m-%d-%H:%M:%S).csv &

echo "_________________________________"
echo " "
echo " starting tcpdump"
echo ".."
echo " "
tcpdump  -i wlan0  -s 0 -w dump_server_$HOSTNAME_$(date +%Y-%m-%d-%H:%M:%S).pcap &
echo " "
echo " tcpdump is running"
echo " "
