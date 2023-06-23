#!/bin/bash
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT 
#Liberei qualquer tráfego para interface de loopback no firewall

iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT 
#Permiti o tráfego de resposta relacionado e estabelecido

iptables -A INPUT -p tcp --dport 22 -j ACCEPT 
#Permiti o tráfego SSH

iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
#Permiti o tráfego HTTP e HTTPS

iptables -A INPUT -p udp --dport 53 -j ACCEPT
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
#Permiti o tráfego DNS

iptables -A INPUT -p icmp -j ACCEPT
#Permiti o tráfego ICMP (ping)

iptables -P INPUT DROP
iptables -P FORWARD DROP
#Estabeleci a política DROP (restritiva) para as chains INPUT e FORWARD da tabela filter

echo 1 > /proc/sys/net/ipv4/ip_forward
#Habilitei o redirecionamento de porta no kernel do Linux

iptables -t nat -A PREROUTING -i eth2 -p tcp --dport 80 -j DNAT --to-destination 10.1.1.10:80
#Criei uma regra de redirecionamento de porta para o HTTP (porta 80)

iptables -t nat -A PREROUTING -i eth2 -p tcp --dport 443 -j DNAT --to-destination 10.1.1.10:443
#Criei uma regra de redirecionamento de porta para o HTTPS (porta 443)

iptables -t nat -A POSTROUTING -o eth2 -s 10.1.1.0/24 -j MASQUERADE
#Configurei a tradução de endereço de rede (NAT) para permitir que os pacotes de retorno alcancem os hosts internos

iptables -N LOGGING
#Crei uma nova chain para fazer o log dos pacotes

iptables -A LOGGING -m string --string "games" --algo kmp --to 65535 -j LOG --log-prefix "Blocked: " --log-level 7
#Adicionei uma regra para fazer o log dos pacotes que correspondem ao critério

iptables -A LOGGING -m string --string "games" --algo kmp --to 65535 -j DROP
#Adicionei uma regra para bloquear os pacotes que correspondem ao critério

iptables -A LOGGING -j DROP
#Configurei a política padrão para a chain LOGGING

iptables -A FORWARD -p tcp --dport 80 -m state --state NEW -j LOGGING
iptables -A FORWARD -p tcp --dport 443 -m state --state NEW -j LOGGING
#Adicionei uma regra para redirecionar o tráfego HTTP e HTTPS para a chain LOGGING

nslookup www.jogosonline.com.br
#Obter o endereço IP associado ao domínio 

iptables -A FORWARD -d 127.0.0.53 -s 192.0.2.123 -j ACCEPT
iptables -A FORWARD -d 127.0.0.53 -j DROP
#Essas regras permitem explicitamente o acesso ao endereço IP do site www.jogosonline.com.br apenas a partir do endereço IP do seu chefe. Todas as outras tentativas de acesso a esse endereço IP serão bloqueadas

iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 5/second -j ACCEPT
#Para permitir que o firewall receba pacotes ICMP echo-request (ping) e limitar a taxa de recebimento a 5 pacotes por segundo, usei o módulo limit do iptables

iptables -A FORWARD -s 10.1.1.0/24 -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -s 10.1.1.0/24 -p tcp --dport 53 -j ACCEPT
#Para permitir que tanto a rede interna quanto a DMZ realizem consultas ao DNS externo e recebam os resultados, primeiro eu permiti consultas DNS de saída (rede interna)

iptables -A FORWARD -s 192.168.1.0/24 -p udp --dport 53 -j ACCEPT
iptables -A FORWARD -s 192.168.1.0/24 -p tcp --dport 53 -j ACCEPT
#Depois permiti consultas DNS de saída (DMZ)

iptables -A FORWARD -d 10.1.1.0/24 -p udp --sport 53 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -d 10.1.1.0/24 -p tcp --sport 53 -m state --state RELATED,ESTABLISHED -j ACCEPT
#Permiti respostas DNS de entrada (rede interna)

iptables -A FORWARD -d 192.168.1.0/24 -p udp --sport 53 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -d 192.168.1.0/24 -p tcp --sport 53 -m state --state RELATED,ESTABLISHED -j ACCEPT
#Por fim, permiti respostas DNS de entrada (DMZ)

iptables -A FORWARD -d 192.168.1.100 -p tcp --dport 80 -j ACCEPT
#Para permitir o tráfego TCP destinado à máquina 192.168.1.100 na porta 80 (HTTP), vindo de qualquer rede (interna ou externa), adicionei a seguinte regra

iptables -t nat -A PREROUTING -d 200.20.5.1 -p tcp --dport 80 -j DNAT --to-destination 192.168.1.100:80
iptables -t nat -A POSTROUTING -d 192.168.1.100 -p tcp --dport 80 -j SNAT --to-source 200.20.5.1
#Para redirecionar pacotes TCP destinados ao IP 200.20.5.1 na porta 80 para a máquina 192.168.1.100 localizada na DMZ, usei a funcionalidade de redirecionamento de porta (port forwarding)

iptables -t nat -A PREROUTING -i eth2 -p tcp --dport 80 -j DNAT --to-destination 192.168.1.100:80 
#Para permitir que a máquina 192.168.1.100 responda corretamente aos pacotes TCP recebidos na porta 80, é necessário realizar o redirecionamento de porta (port forwarding) e também garantir que o tráfego de retorno seja direcionado corretamente. Para isso adicionei regra de redirecionamento (PREROUTING)

iptables -t nat -A POSTROUTING -d 192.168.1.100 -p tcp --dport 80 -j SNAT --to-source 192.168.1.1
#E a regra  de tradução de endereço de origem (POSTROUTING)



