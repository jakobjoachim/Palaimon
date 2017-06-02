ip route add 172.24.0.0/24 via 172.21.0.6   # Verbindung zu den Clients
ip route add 172.22.0.0/24 via 172.21.0.6   # Verbindung zum Backend
ip route add 172.23.0.0/24 via 172.21.0.4   # Verbindung zur World

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # accept all incoming established connections
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # accept all outgoing established connections

iptables -A INPUT -p tcp --dport ssh -j ACCEPT # allow new incoming ssh connections
iptables -A OUTPUT -p tcp --dport ssh -j ACCEPT # allow new outgoing ssh connections

iptables -P FORWARD DROP # dont allow any forwarding connections
iptables -P INPUT DROP # dont allow any other incoming connections
iptables -P OUTPUT DROP # dont allow any other outgoing connections

# ONLY Server 1
iptables -A INPUT -p tcp --dport 465 -j ACCEPT # allow new incoming secure smtp
iptables -A OUTPUT -p tcp --dport 465 -j ACCEPT # allow new outgoing secure smtp
iptables -A INPUT -p tcp --dport 993 -j ACCEPT # allow new incoming secure imap

# ONLY Server 2
iptables -A INPUT -p tcp --dport 443 -j ACCEPT # allow new incoming secure http
iptables -A INPUT -p tcp --dport 80 -j ACCEPT # allow new incoming naughty http

# ONLY Server 3
iptables -A INPUT -p tcp --dport 3128 -j ACCEPT # allow new incoming proxy connections
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT # allow new outgoing secure http
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT # allow new outgoing naughty http
