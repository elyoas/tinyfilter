#!/bin/bash

# reset settings
sudo iptables --flush
sudo iptables --flush -t nat
sudo ip6tables --flush

# set default policies to DROP (if no ACCEPT is matched, the policy is applied, matching is done one by one from top, once ACCEPT is matched in a chain, no more rules are matched)
sudo iptables -P FORWARD DROP
sudo iptables -P INPUT DROP
sudo iptables -P OUTPUT DROP

sudo ip6tables -P FORWARD DROP
sudo ip6tables -P INPUT DROP
sudo ip6tables -P OUTPUT DROP

sudo iptables -A INPUT  -j ACCEPT -i lo -m comment --comment "loopback"
sudo iptables -A OUTPUT -j ACCEPT -o lo -m comment --comment "loopback"

sudo iptables -A INPUT  -j ACCEPT -m conntrack --ctstate ESTABLISHED,RELATED -m comment --comment "conntrack"
sudo iptables -A OUTPUT -j ACCEPT -m conntrack --ctstate ESTABLISHED,RELATED -m comment --comment "conntrack"

sudo iptables -A OUTPUT -j ACCEPT -p icmp --icmp-type 8 -m comment --comment "PING"
sudo iptables -A OUTPUT -j ACCEPT -p tcp --dport 22   -m comment --comment "SSH secure shell"
sudo iptables -A OUTPUT -j ACCEPT -p tcp --dport 80   -m comment --comment "HTTP"
sudo iptables -A OUTPUT -j ACCEPT -p tcp --dport 443  -m comment --comment "HTTPS"
sudo iptables -A OUTPUT -j ACCEPT -p tcp --dport 21   -m comment --comment "FTP"
sudo iptables -A OUTPUT -j ACCEPT -p tcp --dport 53   -m comment --comment "DNS/TCP"
sudo iptables -A OUTPUT -j ACCEPT -p udp --dport 53   -m comment --comment "DNS/UDP"
sudo iptables -A OUTPUT -j ACCEPT -p tcp --dport 123  -m comment --comment "NTP"
sudo iptables -A OUTPUT -j ACCEPT -p tcp --dport 5037 -m comment --comment "ADB"
sudo iptables -A OUTPUT -j ACCEPT -p tcp --dport 143  -m comment --comment "IMAP"
sudo iptables -A OUTPUT -j ACCEPT -p tcp --dport 993  -m comment --comment "IMAP/SSL"
sudo iptables -A OUTPUT -j ACCEPT -p tcp --dport 25   -m comment --comment "SMTP"
sudo iptables -A OUTPUT -j ACCEPT -p tcp --dport 26   -m comment --comment "SMTP 2nd"
sudo iptables -A OUTPUT -j ACCEPT -p tcp --dport 465  -m comment --comment "SMTP/SSL"
sudo iptables -A OUTPUT -j ACCEPT -p tcp --dport 587  -m comment --comment "Thunderbird port"

sudo iptables -A INPUT -j LOG --log-prefix "elias_in:" --log-level 6
sudo iptables -A OUTPUT -j LOG --log-prefix "elias_out:" --log-level 6

sudo iptables -A INPUT -j ACCEPT -m comment --comment "tinyproxy" -s 127.0.0.1 -p tcp --dport 8888
sudo iptables -I OUTPUT -p tcp -m owner ! --uid-owner 186 -m multiport --dports http,https -j REJECT -m comment --comment "force tinyproxy"

sudo ip6tables -A INPUT -j LOG --log-prefix "elias_in_ipv6:" --log-level 6
sudo ip6tables -A OUTPUT -j LOG --log-prefix "elias_out_ipv6:" --log-level 6

sudo iptables-save  -f /etc/iptables/iptables.rules
sudo ip6tables-save -f /etc/iptables/ip6tables.rules

sudo systemctl enable iptables.service
sudo systemctl enable ip6tables.service
sudo systemctl enable tinyproxy

sudo iptables  -vnL --line-numbers
sudo iptables  -vnL --line-numbers -t nat
sudo ip6tables -vnL --line-numbers

