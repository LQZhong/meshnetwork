


read -p 'server-ip: ' server_ip


echo "starting iperf client"
echo ".."
echo " "


iperf -V -c $server_ip  -i 1 -u -b 1G -t 1200  -y C > iperf_log_$HOSTNAME_$(date +%Y-%m-%d-%H:%M:%S).csv &

echo " iperf is connected to $server_ip"
echo " "
echo " "


echo  "starting ping client" 
echo ".."
echo " "

bash pingc -6 $server_ip  > ping_log_$HOSTNAME_$(date +%Y-%m-%d-%H:%M:%S).csv &


echo " ping is running" 
echo " "
echo " "


tcpdump  -i wlan0  -s 0 -w dump_$HOSTNAME_$(date +%Y-%m-%d-%H:%M:%S).pcap &

echo " tcpdump is running"
