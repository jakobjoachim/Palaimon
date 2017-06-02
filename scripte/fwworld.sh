ip route add 172.24.0.0/24 via 172.21.0.6   # Verbindung zu den Clients
ip route add 172.22.0.0/24 via 172.21.0.6   # Verbindung zum Backend

iptables -A FORWARD -i eth1 -o eth0 -p tcp --syn --dport 80 -m conntrack --ctstate NEW -j ACCEPT # allow new http connections from the servers to the world
iptables -A FORWARD -i eth1 -o eth0 -p tcp --syn --dport 443 -m conntrack --ctstate NEW -j ACCEPT # allow new https connections from the servers to the world
iptables -A FORWARD -i eth1 -o eth0 -p tcp --syn --dport 465 -m conntrack --ctstate NEW -j ACCEPT # allow new smtps connections from the servers to the world

iptables -A FORWARD -s 172.21.0.2 -o eth1 -p tcp --syn --dport 80 -m conntrack --ctstate NEW -j ACCEPT # allow new http connections from the world to our server
iptables -A FORWARD -s 172.21.0.5 -o eth1 -p tcp --syn --dport 465 -m conntrack --ctstate NEW -j ACCEPT # allow new smtp connections from the world to our server

iptables -A FORWARD -i eth1 -o eth0 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT # accept all forwading established connections from eth1 to eth0
iptables -A FORWARD -i eth0 -o eth1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT # accept all forwading established connections from eth0 to eth1
iptables -P FORWARD DROP # dont allow any other forwading connections

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # accept all incoming established connections
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT # accept all outgoing established connections

iptables -A INPUT -p tcp --dport ssh -j ACCEPT # allow new incoming ssh connections
iptables -P INPUT DROP # dont allow any other incoming connections
iptables -A OUTPUT -p tcp --dport ssh -j ACCEPT # allow new outgoing ssh connections
iptables -P OUTPUT DROP # dont allow any other outgoing connections

iptables -A FORWARD -i eth1 -d 172.21.0.2 -p tcp --syn --dport 12345 -m conntrack --ctstate NEW -j ACCEPT # allow new tcp connections from the world to the proxy server over port 12345
