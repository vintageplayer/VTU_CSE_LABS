#Author : Aditya Agarwal
# Program to `Simulate a three nodes point-to-point network with duplex links between them.

#Create a Simulation object
set ns [new Simulator]

#Set up trace file handlers
set f [open out.tr w]
set nf [open out.nam w]

$ns trace-all $f
$ns namtrace-all $nf

#Procedure to be called once simulation is completed
proc finish {} {
	global f nf ns
	$ns flush-trace
	close $f
	close $nf
	exec nam out.nam &
	exit 0
}

#Declare nodes present in the network
set n0 [ $ns node ]
set n1 [ $ns node ]
set n2 [ $ns node ]

#Declare classes to be assigned to nodes
$ns color 1 "Red"
$ns color 2 "Blue"
# $ns color 3 "Green"
$n2 color "Green"
$n2 shape "hexagon"

#Allocate labels to nodes
$n0 label "TCP Source"
$n1 label "UDP Source"
$n2 label "TCP/UDP Sink"

#Create links between the nodes
$ns duplex-link $n0 $n2 0.10Mb 5ms DropTail
$ns duplex-link $n1 $n2 0.10Mb 5ms DropTail

#Specify topology of the nodes
$ns duplex-link-op $n0 $n2 orient down
$ns duplex-link-op $n1 $n2 orient right


#Declare the agents for all nodes
set tcp0 [ new Agent/TCP ]
set udp0 [ new Agent/UDP ]
set sink0 [ new Agent/TCPSink ]
set null0 [ new Agent/Null ]

#Attach agents to the nodes
$ns attach-agent $n0 $tcp0
$ns attach-agent $n1 $udp0
$ns attach-agent $n2 $sink0
$ns attach-agent $n2 $null0

#Assign classes to the agents
$tcp0 set class_ 1
$udp0 set class_ 2

#Create applications
set FTP [ new Application/FTP ]
set CBR [ new Application/Traffic/CBR ]

#Attach Application Agents to their protocols
$FTP attach-agent $tcp0
$CBR attach-agent $udp0

#Connect the agents
$ns connect $tcp0 $sink0
$ns connect $udp0 $null0

#Define network/link/application parameters
$ns queue-limit $n0 $n2 10
$ns queue-limit $n1 $n2 10
$ns set packetSize_ 1000
$ns set interval_ 0.001
$FTP set maxPkts_ 1000
$CBR set maxPkts_ 1000

#Scheduel Events
$ns at 0.5 "$FTP start"
$ns at 1.0 "$CBR start"
$ns at 4.0 "$CBR stop"
$ns at 4.5 "$FTP stop"
$ns at 5.0 "finish"

$ns run