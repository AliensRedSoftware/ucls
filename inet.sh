#stubby - crypto DNS traffic
readonly stubby=true
#privoxy - change HTTP request
readonly privoxy=true
readonly tor=true

# package
sudo apt install irqbalance
sudo apt install ethtool
#---------------------------------->Очистка сети
echo "[Очистка сети] => Процесс..."
sudo modprobe br_netfilter
sudo modprobe tcp_bbr
sudo modprobe iptable_nat
sudo modprobe ip_conntrack
sudo modprobe ip_conntrack_ftp
sudo modprobe ip_nat_ftp

# wipe
sudo sh -c "echo '1024' > /proc/sys/vm/min_free_kbytes"
sudo sh -c "echo '1' > /proc/sys/vm/oom_kill_allocating_task"
sudo sh -c "echo '1' > /proc/sys/vm/overcommit_memory"
sudo sh -c "echo '0' > /proc/sys/vm/oom_dump_tasks"
sudo ip route flush cache

#cfg
sudo sh -c "echo $(uuidgen) > /proc/sys/kernel/hostname"
sudo sh -c "echo $(uuidgen) > /etc/hostname"
sudo sh -c "echo '1' > /proc/sys/net/ipv4/ip_dynaddr"
sudo sh -c "echo '1' > /proc/sys/net/ipv4/ip_no_pmtu_disc"
sudo sh -c "echo '1' > /proc/sys/net/ipv4/tcp_timestamps"
sudo sh -c "echo '1' > /proc/sys/net/ipv4/tcp_dsack"
sudo sh -c "echo '5' > /proc/sys/net/ipv4/tcp_keepalive_intvl"
sudo sh -c "echo '30' > /proc/sys/net/ipv4/tcp_keepalive_time"

# Ignore all (incoming + outgoing) ICMP ECHO requests (i.e. disable PING).
# Usually not a good idea, as some protocols and users need/want this.
sudo sh -c "echo '0' > /proc/sys/net/ipv4/icmp_echo_ignore_all"

# Disable bootp_relay. Should not be needed, usually.
sudo sh -c "echo '0' > /proc/sys/net/ipv4/conf/all/bootp_relay"
sudo sysctl -w net.core.netdev_budget=600
sudo sysctl -w net.ipv4.conf.all.route_localnet=1
sudo sysctl -w net.ipv4.conf.all.proxy_arp=1
sudo sysctl -w net.ipv4.ip_forward=1

#Network Security

# Protect from IP Spoofing
sudo sysctl -w net.ipv4.conf.all.rp_filter=1
sudo sysctl -w net.ipv4.conf.default.rp_filter=1

# Ignore ICMP broadcast requests
sudo sysctl -w net.ipv4.icmp_echo_ignore_broadcasts=1

# Protect from bad icmp error messages
sudo sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1

# Disable source packet routing
sudo sysctl -w net.ipv4.conf.all.accept_source_route=0
sudo sysctl -w net.ipv6.conf.all.accept_source_route=0
sudo sysctl -w net.ipv4.conf.default.accept_source_route=0
sudo sysctl -w net.ipv6.conf.default.accept_source_route=0

# Turn on exec shield
sudo sysctl -w kernel.exec-shield=1
sudo sysctl -w kernel.randomize_va_space=1

# Block SYN attacks
sudo sysctl -w net.ipv4.tcp_syncookies=1
sudo sysctl -w net.ipv4.tcp_max_syn_backlog=8192
sudo sysctl -w net.ipv4.tcp_synack_retries=2
sudo sysctl -w net.ipv4.tcp_syn_retries=5

# Ignore send redirects
sudo sysctl -w net.ipv4.conf.all.send_redirects=0
sudo sysctl -w net.ipv4.conf.default.send_redirects=0

# Ignore ICMP redirects
sudo sysctl -w net.ipv4.conf.all.accept_redirects=0
sudo sysctl -w net.ipv6.conf.all.accept_redirects=0
sudo sysctl -w net.ipv4.conf.default.accept_redirects=0
sudo sysctl -w net.ipv6.conf.default.accept_redirects=0
sudo sysctl -w net.ipv4.conf.all.secure_redirects=0
sudo sysctl -w net.ipv4.conf.default.secure_redirects=0

# Disable Explicit Congestion Notification in TCP
sudo sysctl -w net.ipv4.tcp_ecn=0

# window scaling
sudo sysctl -w net.ipv4.tcp_window_scaling=1

# increase linux autotuning tcp buffer limits
sudo sysctl -w net.ipv4.tcp_mem="16384 349520 16777216"
sudo sysctl -w net.ipv4.tcp_rmem="16384 349520 16777216"
sudo sysctl -w net.ipv4.tcp_wmem="16384 349520 16777216"
sudo sysctl -w net.ipv4.udp_mem="16384 349520 16777216"
sudo sysctl -w net.ipv4.udp_rmem_min=16777216
sudo sysctl -w net.ipv4.udp_wmem_min=16777216

# increase TCP max buffer size
sudo sysctl -w net.core.wmem_default=16777216
sudo sysctl -w net.core.rmem_default=16777216
sudo sysctl -w net.core.rmem_max=16777216
sudo sysctl -w net.core.wmem_max=16777216

# Increase number of incoming connections backlog
sudo sysctl -w net.core.netdev_max_backlog=300000
sudo sysctl -w net.core.dev_weight=64

# Increase number of incoming connections
sudo sysctl -w net.core.somaxconn=15000

# Increase the maximum amount of option memory buffers
sudo sysctl -w net.core.optmem_max=65535

# Increase the tcp-time-wait buckets pool size to prevent simple DOS attacks
sudo sysctl -w net.ipv4.tcp_max_tw_buckets=1440000

# try to reuse time-wait connections, but don't recycle them
# (recycle can break clients behind NAT)
sudo sysctl -w net.ipv4.tcp_tw_reuse=1

# Limit number of orphans, each orphan can eat up to 16M (max wmem)
# of unswappable memory
sudo sysctl -w net.ipv4.tcp_max_orphans=16384
sudo sysctl -w net.ipv4.tcp_orphan_retries=0

# don't cache ssthresh from previous connection
sudo sysctl -w net.ipv4.tcp_no_metrics_save=1
sudo sysctl -w net.ipv4.tcp_moderate_rcvbuf=1

# Increase size of RPC datagram queue length
sudo sysctl -w net.unix.max_dgram_qlen=50

# Don't allow the arp table to become bigger than this
sudo sysctl -w net.ipv4.neigh.default.gc_thresh3=2048

# Tell the gc when to become aggressive with arp table cleaning.
# Adjust this based on size of the LAN. 1024 is suitable for most
# /24 networks
sudo sysctl -w net.ipv4.neigh.default.gc_thresh2=1024

# Adjust where the gc will leave arp table alone - set to 32.
sudo sysctl -w net.ipv4.neigh.default.gc_thresh1=32

# Adjust to arp table gc to clean-up more often
sudo sysctl -w net.ipv4.neigh.default.gc_interval=30

# Increase TCP queue length
sudo sysctl -w net.ipv4.neigh.default.proxy_qlen=96
sudo sysctl -w net.ipv4.neigh.default.unres_qlen=6

# Enable Explicit Congestion Notification (RFC 3168), disable it
# if it doesn't work for you
sudo sysctl -w net.ipv4.tcp_reordering=3

# How many times to retry killing an alive TCP connection
sudo sysctl -w net.ipv4.tcp_retries2=6
sudo sysctl -w net.ipv4.tcp_retries1=3

# Avoid falling back to slow start after a connection goes idle
# keeps our cwnd large with the keep alive connections (kernel > 3.6)
sudo sysctl -w net.ipv4.tcp_slow_start_after_idle=0

# Allow the TCP fastopen flag to be used,
# beware some firewalls do not like TFO! (kernel > 3.7)
sudo sysctl -w net.ipv4.tcp_fastopen=3

# This will enusre that immediatly subsequent connections use the new values
sudo sysctl -w net.ipv4.route.flush=1
sudo sysctl -w net.ipv6.route.flush=1

# TCP SYN cookie protection
sudo sysctl -w net.ipv4.tcp_syncookies=1

# IP Fragmentation
sudo sysctl -w net.ipv4.ipfrag_low_thresh=393216
sudo sysctl -w net.ipv4.ipfrag_high_thresh=544288

# TCP rfc1337
sudo sysctl -w net.ipv4.tcp_rfc1337=1

# TCP SACK
sudo sysctl -w net.ipv4.tcp_sack=0

# TCP FIN timeout
sudo sysctl -w net.ipv4.tcp_fin_timeout=15

# vm
sudo sysctl -w vm.swappiness=10
sudo sysctl -w vm.max_map_count=2147483647
sudo sysctl -w vm.dirty_expire_centisecs=500
sudo sysctl -w vm.dirty_ratio=10
sudo sysctl -w vm.dirty_background_ratio=3
sudo sysctl -w vm.nr_hugepages=64

# fs
sudo sysctl -w fs.inotify.max_user_watches=1524288
sudo sysctl -w fs.file-max=20000000
sudo sysctl -w fs.aio-max-nr=18446744073709551615

# Miscellaneous tweaks
sudo sysctl -w net.ipv4.ip_local_port_range="1024 65535"
sudo sysctl -w net.ipv4.tcp_workaround_signed_windows=1
sudo sysctl -w net.ipv4.tcp_dsack=0
sudo sysctl -w net.ipv4.tcp_fack=0
sudo sysctl -w net.ipv4.tcp_low_latency=1
sudo sysctl -w net.ipv4.tcp_mtu_probing=1
sudo sysctl -w net.ipv4.tcp_frto=2
sudo sysctl -w net.ipv4.tcp_frto_response=2
sudo sysctl -w net.netfilter.nf_conntrack_tcp_timeout_time_wait=30

# options
sudo sysctl -w net.ipv4.conf.default.log_martians=1
sudo sysctl -w net.ipv4.tcp_congestion_control=bbr
sudo sysctl -w net.ipv4.tcp_available_congestion_control=bbr
sudo sysctl -w net.core.default_qdisc=fq
sudo sysctl -w net.ipv4.tcp_keepalive_probes=5
sudo sysctl -w net.ipv4.route.flush=1
sudo sysctl -w net.nf_conntrack_max=1000000
sudo sysctl -w net.ipv4.tcp_tw_recycle=1
sudo sysctl -w net.core.netdev_tstamp_prequeue=0
sudo sysctl -w net.core.dev_weight=600
sudo sysctl -w net.ipv4.ip_early_demux=0
sudo sysctl -w net.ipv4.tcp_dma_copybreak=2048

# kernel
sudo sysctl -w kernel.sem="350358400641024"
sudo sysctl -w kernel.shmall=4294967296
sudo sysctl -w kernel.shmmax=68719476736
sudo sysctl -w kernel.msgmnb=65536
sudo sysctl -w kernel.msgmax=65536
sudo sysctl -w kernel.core_uses_pid=1
sudo sysctl -w kernel.sysrq=0

# netfilter
sudo sysctl -w net.netfilter.nf_conntrack_max=524288

# flow limit
sudo sysctl -w net.core.flow_limit_cpu_bitmap=00d
sudo sysctl -w net.core.flow_limit_table_len=8192

# Enable kptr_restrict
sudo sysctl -w kernel.kptr_restrict=1

# IRQ
sudo sh -c "echo '1' > /proc/irq/8/smp_affinity"

# optimizing java applications
sudo sysctl -w kernel.sched_compat_yield=1
sudo sysctl -w kernel.sched_child_runs_first=1

# Tuning: Enabling RFS
sudo sysctl -w net.core.rps_sock_flow_entries=32768

#Apply effect...
sysctl=$(sudo sysctl -a)
sudo sh -c "echo '$sysctl' > /etc/sysctl.conf"
sudo sysctl --system

sudo ip -s -s neigh flush all
echo "[Очистка сети] => Успешно:)"
sudo sh -c "echo '*raw' > rule"
sudo sh -c "echo ':PREROUTING ACCEPT' >> rule"
sudo sh -c "echo ':OUTPUT ACCEPT' >> rule"

#ACCESS PORT
for i in `ls ./inet/raw/sport`
do
	sudo sh -c "echo '-A PREROUTING -p udp --sport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A PREROUTING -p tcp --sport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A PREROUTING -p udp --dport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A PREROUTING -p tcp --dport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -p udp --sport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -p tcp --sport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -p udp --dport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -p tcp --dport $i -j ACCEPT' >> rule"
done
sudo sh -c "echo 'COMMIT' >> rule"
sudo sh -c "echo '*filter' >> rule"
sudo sh -c "echo ':INPUT ACCEPT' >> rule"
sudo sh -c "echo ':FORWARD ACCEPT' >> rule"
sudo sh -c "echo ':OUTPUT ACCEPT' >> rule"
#-----------------------------------------------------------------------------

#localhost ACCESS
sudo sh -c "echo '#localhost' >> rule"

#INPUT PORT
for i in `ls ./inet/filter/sport`
do
	sudo sh -c "echo '-A INPUT -s 127.0.0.1 -p udp --dport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A INPUT -s 127.0.0.1 -p tcp --dport $i -j ACCEPT' >> rule"
done

#OUTPUT PORT
for i in `ls ./inet/filter/sport`
do
	sudo sh -c "echo '-A OUTPUT -s 127.0.0.1 -p udp --dport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -s 127.0.0.1 -p tcp --dport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -s 127.0.0.1 -p udp --sport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -s 127.0.0.1 -p tcp --sport $i -j ACCEPT' >> rule"
done
for i in `grep "nameserver" /etc/resolv.conf | cut -d' ' -f2`
do
	for port in `ls ./inet/filter/sport`
	do
		#INPUT PORT
		sudo sh -c "echo '-A INPUT -s $i -p udp --sport $port -j ACCEPT' >> rule"
		sudo sh -c "echo '-A INPUT -s $i -p tcp --sport $port -j ACCEPT' >> rule"
		#OUTPUT PORT
		sudo sh -c "echo '-A OUTPUT -s $i -p udp --sport $port -j ACCEPT' >> rule"
		sudo sh -c "echo '-A OUTPUT -s $i -p tcp --sport $port -j ACCEPT' >> rule"
	done
done

#hostname
for i in `hostname -I`
do
	for port in `ls ./inet/filter/sport`
	do
		#INPUT PORT
		sudo sh -c "echo '-A INPUT -s $i -p udp --sport $port -j ACCEPT' >> rule"
		sudo sh -c "echo '-A INPUT -s $i -p tcp --sport $port -j ACCEPT' >> rule"
		#OUTPUT PORT
		sudo sh -c "echo '-A OUTPUT -s $i -p udp --sport $port -j ACCEPT' >> rule"
		sudo sh -c "echo '-A OUTPUT -s $i -p tcp --sport $port -j ACCEPT' >> rule"
		sudo sh -c "echo '-A OUTPUT -s $i -p udp --dport $port -j ACCEPT' >> rule"
		sudo sh -c "echo '-A OUTPUT -s $i -p tcp --dport $port -j ACCEPT' >> rule"
	done
done

#ip ACCESS
sudo sh -c "echo '#ip' >> rule"
for i in `ls ./inet/filter/ip`
do
	#SPLIT
	ip=$(echo $i | awk -F'$' '$0=$1')
	mask=$(echo $i | awk -F'$' '$0=$2')
	if [[ $mask ]]
	then
		ip="$ip/$mask"
	fi
	#dport
	for port in `ls ./inet/filter/ip/$i/dport`
	do
		#INPUT PORT
		sudo sh -c "echo '-A INPUT -s $ip -p udp --dport $port -j ACCEPT' >> rule"
		sudo sh -c "echo '-A INPUT -s $ip -p tcp --dport $port -j ACCEPT' >> rule"
	done
	#sport
	for port in `ls ./inet/filter/ip/$i/sport`
	do
		#OUTPUT PORT
		sudo sh -c "echo '-A OUTPUT -s $ip -p udp --sport $port -j ACCEPT' >> rule"
		sudo sh -c "echo '-A OUTPUT -s $ip -p tcp --sport $port -j ACCEPT' >> rule"
	done
done

#SPORT ACCESS
sudo sh -c "echo '#sport' >> rule"
for i in `ls ./inet/filter/sport`
do
	#sport
	sudo sh -c "echo '-A INPUT -p udp --sport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A INPUT -p tcp --sport $i -j ACCEPT' >> rule"
	#dport
	sudo sh -c "echo '-A OUTPUT -p udp --sport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -p tcp --sport $i -j ACCEPT' >> rule"
done

#DPORT ACCESS
sudo sh -c "echo '#dport' >> rule"
for i in `ls ./inet/filter/dport`
do
	#sport
	sudo sh -c "echo '-A INPUT -p udp --dport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A INPUT -p tcp --dport $i -j ACCEPT' >> rule"
	#dport
	sudo sh -c "echo '-A OUTPUT -p udp --dport $i -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -p tcp --dport $i -j ACCEPT' >> rule"
done

sudo sh -c "echo 'COMMIT' >> rule"
sudo sh -c "echo '*nat' >> rule"
sudo sh -c "echo ':PREROUTING DROP' >> rule"
sudo sh -c "echo ':INPUT DROP' >> rule"
sudo sh -c "echo ':OUTPUT DROP' >> rule"
sudo sh -c "echo ':POSTROUTING DROP' >> rule"

gsettings set org.gnome.system.proxy mode 'none'

#DNS Crypt
if [[ $stubby == true ]]
then
	sudo apt install stubby
	sudo systemctl enable stubby
	#cfg...	
	echo "[stubby] [CFG] => Process..."
	sudo cp ./stubby/stubby.yml /etc/stubby/stubby.yml
	echo "[stubby] [CFG] => Done :)"
	sudo systemctl restart stubby
fi

#privoxy modify headers (web site)...
#HTTP 8118 PORT
#HTTPS 8118 PORT
if [[ $privoxy == true ]]
then
	sudo apt install privoxy
	sudo systemctl enable privoxy
	#cfg...	
	echo "[privoxy] [CFG] => Process..."
	sudo cp ./privoxy/privoxy /etc/privoxy/config
	echo "[privoxy] [CFG] => Done :)"
	sudo systemctl restart privoxy
fi

#tor router
if [[ $tor == true ]]
then
	# Возвращение ресстарта тора (Служба)
	function rt() {
		sudo systemctl restart tor
		echo 'Ожидание перезагрузка службы tor...'
		sleep 1
		if [[ $(systemctl is-active tor) != 'active' ]]; then
			sleep 1
			echo 'Ожидание перезагрузка службы tor...'
			rt
		else
			sudo chmod 0777 -R /var/run/tor/*
		fi
	}
	# Tor TransPort
	readonly tor_transport=9140

	# Tor DNSPort
	readonly tor_dnsport=9153

	# Tor VirtualAddrNetworkIPv4
	readonly tor_virtualAddress='10.192.0.0/10'

	# destinations you don't want routed through Tor
	readonly NON_TOR='192.168.0.0/23 10.0.0.0/8 127.0.0.1'

	sudo sh -c "echo '#tor routing' >> rule"

	# nat dns requests to Tor
	#sudo sh -c "echo '-A OUTPUT -d 127.0.0.1/32 -p udp --dport 53 -j REDIRECT --to-ports $tor_dnsport' >> rule"

	# nat .onion addresses
	#sudo sh -c "echo '-A OUTPUT -d $tor_virtualAddress -p udp -j REDIRECT --to-ports $tor_transport' >> rule"
	#sudo sh -c "echo '-A OUTPUT -d $tor_virtualAddress -p tcp -j REDIRECT --to-ports $tor_transport' >> rule"

	#localhost
	#sudo sh -c "echo '-A OUTPUT -p tcp -m owner ! --uid-owner polipo -j ACCEPT' >> rule"
	#sudo sh -c "echo '-A OUTPUT -p tcp -j REDIRECT --to-ports 8118' >> rule"
	#sudo sh -c "echo '-A OUTPUT -p tcp --dport 80:81 -j REDIRECT --to-ports 8123' >> rule"
	#sudo sh -c "echo '-A OUTPUT -p tcp --dport 443 -j REDIRECT --to-ports 8123' >> rule"

	#sudo sh -c "echo '-A OUTPUT -p tcp --sport 80:81 -j REDIRECT --to-ports 8123' >> rule"
	#sudo sh -c "echo '-A OUTPUT -p tcp --sport 443 -j REDIRECT --to-ports 8123' >> rule"
	#proxy
	#gsettings set org.gnome.system.proxy.socks host '127.0.0.1'
	#gsettings set org.gnome.system.proxy.socks port 9050
	gsettings set org.gnome.system.proxy.https host '127.0.0.1'
	gsettings set org.gnome.system.proxy.https port 8118
	gsettings set org.gnome.system.proxy.http host '127.0.0.1'
	gsettings set org.gnome.system.proxy.http port 8118
	gsettings set org.gnome.system.proxy mode 'manual'

	#other
	sudo sh -c "echo '-A PREROUTING -p tcp -j DNAT --to 127.0.0.1:$tor_transport' >> rule"

	#cfg
	sudo cp ./tor/torrc /etc/tor/torrc
	# Возвращение ресстарта тора (Служба)
	#rt
fi

#optimize DNS
echo "[OPTIMIZE DNS] => Процесс..."
for dns in `ls ./inet/dns`
do
	dns4="$dns4 $dns"
done
sudo nmcli -g name,type connection show --active | awk -F: '/ethernet|wireless/ { print $1 }' | while read connection
do
	sudo nmcli con mod "$connection" ipv6.ignore-auto-dns yes
	sudo nmcli con mod "$connection" ipv4.ignore-auto-dns yes
	sudo nmcli con mod "$connection" ipv4.dns "$dns4"
	sudo nmcli con down "$connection" && sudo nmcli con up "$connection"
done
echo "[OPTIMIZE DNS] => Успешно :)"
#optimize devices
echo '[OPTIMIZE DEV] => Процесс...'
for dev in `ls /sys/class/net`
do
	if [[ $dev != 'lo' ]]
	then
		echo "[OPTIMIZE DEV MTU] $dev => 9000"
		sudo ip link set dev $dev mtu 9000
	fi
	echo "[OPTIMIZE DEV TXQ] $dev => 10000"
	sudo ifconfig $dev txqueuelen 10000
done
echo '[OPTIMIZE DEV] => Успешно :)'

#shared
for i in `ls ./inet/nat/shared`
do
	#SPLIT
	ip=$(echo $i | awk -F'$' '$0=$1')
	mask=$(echo $i | awk -F'$' '$0=$2')
	if [[ $mask ]]
	then
		ip="$ip/$mask"
	fi
	#EFFECT
	for port in `ls ./inet/nat/shared/$i/dport`
	do
		#INPUT PORT
		sudo sh -c "echo '-A POSTROUTING -s $ip -p udp --dport $port -j MASQUERADE' >> rule"
		sudo sh -c "echo '-A POSTROUTING -s $ip -p tcp --dport $port -j MASQUERADE' >> rule"
		sudo sh -c "echo '-A PREROUTING -s $ip -p udp --dport $port -j ACCEPT' >> rule"
		sudo sh -c "echo '-A PREROUTING -s $ip -p tcp --dport $port -j ACCEPT' >> rule"
		#sudo sh -c "echo '-A OUTPUT -s $ip -p udp -m udp --dport $port -j ACCEPT' >> rule"
		#sudo sh -c "echo '-A OUTPUT -s $ip -p tcp -m tcp --dport $port -j ACCEPT' >> rule"
	done
	#sport
	for port in `ls ./inet/nat/shared/$i/sport`
	do
		#OUTPUT PORT
		sudo sh -c "echo '-A POSTROUTING -s $ip -p udp --sport $port -j MASQUERADE' >> rule"
		sudo sh -c "echo '-A POSTROUTING -s $ip -p tcp --sport $port -j MASQUERADE' >> rule"
		sudo sh -c "echo '-A PREROUTING -s $ip -p udp --sport $port -j ACCEPT' >> rule"
		sudo sh -c "echo '-A PREROUTING -s $ip -p tcp --sport $port -j ACCEPT' >> rule"
		#sudo sh -c "echo '-A OUTPUT -s $ip -p udp -m udp --sport $port -j ACCEPT' >> rule"
		#sudo sh -c "echo '-A OUTPUT -s $ip -p tcp -m tcp --sport $port -j ACCEPT' >> rule"
	done
done

#SPORT ACCESS
sudo sh -c "echo '#sport' >> rule"
for port in `ls ./inet/nat/sport`
do
	#dport
	sudo sh -c "echo '-A PREROUTING -p udp --dport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A PREROUTING -p tcp --dport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A INPUT -p udp --dport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A INPUT -p tcp --dport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -p udp --dport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -p tcp --dport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A POSTROUTING -p udp --dport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A POSTROUTING -p tcp --dport $port -j ACCEPT' >> rule"
	#sport
	sudo sh -c "echo '-A PREROUTING -p udp --sport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A PREROUTING -p tcp --sport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A INPUT -p udp --sport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A INPUT -p tcp --sport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -p udp --sport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -p tcp --sport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A POSTROUTING -p udp --sport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A POSTROUTING -p tcp --sport $port -j ACCEPT' >> rule"
done

#DPORT ACCESS
sudo sh -c "echo '#dport' >> rule"
for port in `ls ./inet/nat/dport`
do
	sudo sh -c "echo '-A PREROUTING -p udp --dport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A PREROUTING -p tcp --dport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A INPUT -p udp --dport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A INPUT -p tcp --dport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -p udp --dport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A OUTPUT -p tcp --dport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A POSTROUTING -p udp --dport $port -j ACCEPT' >> rule"
	sudo sh -c "echo '-A POSTROUTING -p tcp --dport $port -j ACCEPT' >> rule"
done

#ip
for i in `ls ./inet/nat/ip`
do
	#SPLIT
	ip=$(echo $i | awk -F'$' '$0=$1')
	mask=$(echo $i | awk -F'$' '$0=$2')
	if [[ $mask ]]
	then
		ip="$ip/$mask"
	fi
	#EFFECT
	for port in `ls ./inet/nat/ip/$i/dport`
	do
		#INPUT PORT
		sudo sh -c "echo '-A OUTPUT -s $ip -p udp --dport $port -j ACCEPT' >> rule"
		sudo sh -c "echo '-A POSTROUTING -s $ip -p tcp --dport $port -j ACCEPT' >> rule"
	done
	#sport
	for port in `ls ./inet/nat/ip/$i/sport`
	do
		#OUTPUT PORT
		sudo sh -c "echo '-A OUTPUT -s $ip -p udp --sport $port -j ACCEPT' >> rule"
		sudo sh -c "echo '-A POSTROUTING -s $ip -p tcp --sport $port -j ACCEPT' >> rule"
	done
done
sudo sh -c "echo 'COMMIT' >> rule"
sudo sh -c "echo '' >> rule"

echo 'rule успешно добавлен :)'
sudo iptables-restore < rule

#raw
sudo iptables -t raw -P PREROUTING DROP
sudo iptables -t raw -P OUTPUT DROP

#filter
sudo iptables -t filter -P INPUT DROP
sudo iptables -t filter -P FORWARD DROP
sudo iptables -t filter -P OUTPUT DROP

