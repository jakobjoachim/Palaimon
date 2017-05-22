ip route add 172.24.0.0/24 via 172.21.0.6   #(Verbindung zu den Clients)
ip route add 172.22.0.0/24 via 172.21.0.6   #(Verbindung zum Backend)


iptables -A FORWARD -i eth1 -o eth0 -p tcp --syn --dport 80 -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -i eth1 -o eth0 -p tcp --syn --dport 443 -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -i eth1 -o eth0 -p tcp --syn --dport 465 -m conntrack --ctstate NEW -j ACCEPT

iptables -A FORWARD -s 172.21.0.2 -o eth1 -p tcp --syn --dport 80 -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -s 172.21.0.5 -o eth1 -p tcp --syn --dport 25 -m conntrack --ctstate NEW -j ACCEPT


iptables -A FORWARD -i eth1 -o eth0 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i eth0 -o eth1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -P FORWARD DROP

iptables -A INPUT -p tcp --dport ssh -j ACCEPT
iptables -P INPUT DROP
iptables -A OUTPUT -p tcp --dport ssh -j ACCEPT
iptables -P OUTPUT DROP

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
