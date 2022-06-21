read -p "Enter date (YYYYMMDDHHmm): " dateinput 
date -s $dateinput

echo "date set to $dateinput"
echo " "
echo "_________________________________"

read -p "Enter Scenario name" scenario

mkdir -p $scenario # create directory for scenario if it doesn't allready exist
cd $scenario

