ip route add 172.24.0.0/24 via 172.22.0.4   # Verbindung zu den Clients
ip route add 172.21.0.0/24 via 172.22.0.4   # Verbindung zu den Servern
ip route add 172.23.0.0/24 via 172.22.0.4   # Verbindung zur World

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # accept all incoming established connections
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # accept all outgoing established connections

iptables -A INPUT -p tcp --dport ssh -j ACCEPT # allow new incoming ssh connections

iptables -P FORWARD DROP # dont allow any forwarding connections
iptables -P INPUT DROP # dont allow any other incoming connections
iptables -P OUTPUT DROP # dont allow any other outgoing connections

# ONLY BACKEND 1
iptables -A INPUT -p tcp --dport 123 -j ACCEPT # allow ntp
iptables -A INPUT -p tcp --dport 3306 -j ACCEPT # allow sql

# ONLY BACKEND 2
iptables -A INPUT -p tcp --dport 53 -j ACCEPT # allow dns

# ONLY BACKEND 3
iptables -A INPUT -p tcp --dport 631 -j ACCEPT # allow print server
