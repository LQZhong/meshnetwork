read -p "Enter date (YYYYMMDDHHmm): " dateinput 
date -s $dateinput

echo "date set to $dateinput"
echo " "
echo "_________________________________"

read -p "Enter Scenario name" scenario

mkdir -p $scenario # create directory for scenario if it doesn't allready exist
cd $scenario


echo " running meshmerize link"
echo " "
echo "_________________________________"
meshmerize link

printf 'kill time required (y/n)? '
read answer


if echo "$answer" | grep -iq "^y" ;then

    printf 'enter runtime in sec ! '
    read killtime

    sleep killtime
    shutdown now



read answer
else
    echo "no killtime set"
fi


echo "_________________________________"
echo " "
echo " starting tcpdump"
echo ".."
echo " "
tcpdump  -i wlan0  -s 0 -w dump_relay_$HOSTNAME_$(date +%Y-%m-%d-%H:%M:%S).pcap &
echo " "
echo " tcpdump is running"
echo " "
