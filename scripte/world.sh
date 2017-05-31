ip route add 172.21.0.0/24 via 172.23.0.4   # Verbindung zu den Servern
ip route add 172.22.0.0/24 via 172.23.0.4   # Verbindung zum Backend
ip route add 172.24.0.0/24 via 172.23.0.4   # Verbindung zu den Clients
