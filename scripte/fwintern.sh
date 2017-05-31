ip route add 172.23.0.0/24 via 172.21.0.4   #(Verbindung zur World)

iptables -A FORWARD -i eth2 -o eth1 -p tcp --syn --dport 3128 -m conntrack --ctstate NEW -j ACCEPT # allow packages from the servers to the clients over port 3128

iptables -A FORWARD -i eth2 -o eth1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT # accept all forwading established connections from eth2 to eth1
iptables -A FORWARD -i eth1 -o eth2 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT # accept all forwading established connections from eth1 to eth2

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # accept all incoming established connections
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # accept all outgoing established connections

iptables -A INPUT -p tcp --dport ssh -j ACCEPT # allow new incoming ssh connections
iptables -P INPUT DROP # dont allow any other incoming connections
iptables -A OUTPUT -p tcp --dport ssh -j ACCEPT # allow new outgoing ssh connections
iptables -P OUTPUT DROP # dont allow any other outgoing connections
