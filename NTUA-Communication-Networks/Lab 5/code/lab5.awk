BEGIN {
	sum_delay = 0;
	bufferspace = 100000;
	total_pkts_sent = 0;
	total_pkts_recv = 0;
	total_pkts_dropped = 0;
	# Do we need to fix the decimal mark?
	if (sprintf(sqrt(2)) ~ /,/) dmfix = 1;
	first_time = 1000;
	last_time =  0;
	packet_size = 0;
	komboi=24;
	for (i=1; i<=N;i++){
		ipacket[i]=0;
		ilast_time[i]=0;
	}
}
{#Apply dm fix if needed
	if (dmfix) sub(/\./, ",", $0);
}

#First Time
/^-/&&/cbr/ {
	if (first_time>$2){
		first_time = $2
	}
}

#Received Packets/Delay/Last Time
/^r/&&/cbr/ {
	total_pkts_recv++;
	sum_delay += $2 - sendtimes[$12%bufferspace];
	last_time = $2;
	itime[$3]=$2;
	packet_size = $6;
}

/^h/&&/cbr/ {
	total_pkts_sent++;
	ipacket[$3]++;
	ilast_time[$3]=$2;
}
/^d/&&/cbr/ {
	total_pkts_dropped++;
}

END {
euler = 2.718281828;
time_delay=25.6;
total_time=last_time-first_time;
average_delay=sum_delay/total_pkts_recv;
total_data = 8*packet_size*total_pkts_recv;
real_rate = total_data/total_time;
theoritical_rate= 10000000;
real_efficiency=real_rate/theoritical_rate;
p=1000000*packet_size*8/theoritical_rate;
theoritical_efficiency=p/(p+2*time_delay*euler);

printf("===================================================\n");
printf("PACKET SIZE: \t\t\t%d bytes\n", packet_size);
printf("SIZE OF LAN: \t\t\t%d nodes\n", komboi);
printf("===================================================\n");
printf("Total Packets sent: \t\t%d\n", total_pkts_sent);
printf("Total Packets received: \t%d\n", total_pkts_recv);
printf("Total Packets dropped: \t\t%d\n", total_pkts_dropped);
printf("Average Delay: \t\t\t%f sec\n", average_delay);
printf("Last packet received at: \t%f sec\n", last_time);
printf("Total Time: \t\t\t%f sec\n", total_time);
printf("--------------------------------------------------\n");
printf("Real Rate: \t\t\t%f bps\n", real_rate);
printf("Theoritical Rate: \t\t%d bps\n", theoritical_rate);
printf("Theoritical Efficiency: \t%f %%\n", theoritical_efficiency*100);
printf("Real Efficiency: \t\t%f %%\n", real_efficiency*100);
printf("--------------------------------------------------\n");
max_roi=0;
max_rate=0;
for (i=1;i<=komboi;i++){
	irate[i]=ipacket[i]*8*packet_size/(ilast_time[i]-first_time);
	if (irate[i]>=max_roi) {
		max_rate=irate[i];
		max_roi=i;
	}
	#printf("%d. First_Time: %f sec Last Time: %f sec  Packets: %d and rate %f\n ",i, ifirst_time[i],ilast_time[i],ipacket[i],irate[i]);
}
printf("Max flow is: %d with rate of: %f bps\n",max_roi, max_rate);
printf("===================================================\n");
}
