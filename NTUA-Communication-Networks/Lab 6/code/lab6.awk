BEGIN { 
	pack1 = 0; 
	pack2 = 0; 
}

/^r/&&/tcp/ { 
	if($4 == 5 && $6==540 && $8 == 1) { 
		pack1++; 
		time1 = $2; 
	}
	if($4 == 9 && $6==540 && $8 == 2) {
		pack2++;
		time2 = $2;
	}
}

END { 
	printf("Total Packets received (flow 1): %d packets\n", pack1); 
	printf("Last packet for flow 1 received: %f sec\n", time1); 
	printf("Total packets received (flow 2): %d packets\n", pack2); 
	printf("Last packet for flow 2 received: %f sec\n", time2); 
}





