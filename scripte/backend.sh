ip route add 172.24.0.0/24 via 172.22.0.4   # Verbindung zu den Clients
ip route add 172.21.0.0/24 via 172.22.0.4   # Verbindung zu den Servern
ip route add 172.23.0.0/24 via 172.22.0.4   # Verbindung zur World

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # accept all incoming established connections
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # accept all outgoing established connections

iptables -A INPUT -p tcp --dport ssh -j ACCEPT # allow new incoming ssh connections
iptables -P INPUT DROP # dont allow any other incoming connections
iptables -A OUTPUT -p tcp --dport ssh -j ACCEPT # allow new outgoing ssh connections
iptables -P OUTPUT DROP # dont allow any other outgoing connections
