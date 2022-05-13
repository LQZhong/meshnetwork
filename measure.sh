echo("starting iperf client")
echo("..")
echo(" ")
server_ip =$1

iperf -V -c $server_ip  -i 1 -u -b 1G -t 1200 -l 10000  -r -y C > iperf_log_$HOSTNAME.csv &
echo(" iperf is connected to $server_ip")
echo(" ")
echo(" ")


echo("starting ping client")
echo("..")
echo(" ")

ping -6 ff02::1%wlan0 -D > ping_log_$HOSTNAME.csv &

echo(" ping is running")
echo(" ")
echo(" ")


tcpdump  -i wlan0 -w -s 0 dump_$HOSTNAME.pcap &
echo(" tcpdump is running")