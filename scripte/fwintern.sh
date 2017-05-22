ip route add 172.23.0.0/24 via 172.21.0.4   #(Verbindung zur World)


iptables -A FORWARD -i eth2 -o eth1 -p tcp --syn --dport 3128 -m conntrack --ctstate NEW -j ACCEPT

iptables -A FORWARD -i eth2 -o eth1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i eth1 -o eth2 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
