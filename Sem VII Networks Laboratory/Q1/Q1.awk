#! /usr/bin/awk -f
BEGIN {
	cbr_dropped = 0;
	tcp_dropped = 0;
}
{
	if( ($1=="d") && ($5=="tcp")){tcp_dropped++;}
	if( ($1=="d") && ($5=="cbr")){cbr_dropped++;}
}
END {
	printf("Number of TCP packets dropped = %d\n",tcp_dropped);
	printf("Number of CBR packets dropped = %d\n",cbr_dropped);
}