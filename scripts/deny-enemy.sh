# Create the ipset list
sudo ipset -N enemy hash:net

# remove any old list that might exist from previous runs of this script
rm ru.zone

# Pull the latest IP set for UA
wget -P . http://www.ipdeny.com/ipblocks/data/countries/ru.zone

# Add each IP address from the downloaded list into the ipset 'enemy'
for i in $(cat ru.zone); do sudo ipset -A enemy $i; done

# Set iptables rules
sudo iptables -A INPUT -p tcp -m set --match-set enemy src -j DROP
