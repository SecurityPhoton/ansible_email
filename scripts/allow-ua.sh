# Create the ipset list
sudo ipset -N ua hash:net

# remove any old list that might exist from previous runs of this script
rm ua.zone

# Pull the latest IP set for UA
wget -P . http://www.ipdeny.com/ipblocks/data/countries/ua.zone

# Add each IP address from the downloaded list into the ipset 'ua'
for i in $(cat ua.zone ); do sudo ipset -A ua $i; done

# Set iptables rules
sudo iptables -C INPUT -p tcp -m set --match-set ua src --dport 443 -j ACCEPT || sudo iptables -A INPUT -p tcp -m set --match-set ua src --dport 443 -j ACCEPT
sudo iptables -C INPUT -p tcp -m set --match-set ua src --dport 80 -j ACCEPT || sudo iptables -A INPUT -p tcp -m set --match-set ua src --dport 80 -j ACCEPT
sudo iptables -C INPUT -p tcp -m set --match-set ua src --dport 22 -j ACCEPT || sudo iptables -A INPUT -p tcp -m set --match-set ua src --dport 22 -j ACCEPT
sudo iptables -C INPUT -p tcp --dport 443 -j DROP || sudo iptables -A INPUT -p tcp --dport 443 -j DROP
sudo iptables -C INPUT -p tcp --dport 80 -j DROP || sudo iptables -A INPUT -p tcp --dport 80 -j DROP
sudo iptables -C INPUT -p tcp --dport 22 -j DROP || sudo iptables -A INPUT -p tcp --dport 22 -j DROP
