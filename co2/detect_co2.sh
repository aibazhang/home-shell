VALUE_CO2=`python3 -m mh_z19 | jq -r '.co2'`
DATETIME=`date '+%Y-%m-%d %H:%M:%S'`
echo "$DATETIME,$VALUE_CO2" >> "/home/pi/Projects/co2/data/co2_bedroom.csv"