set val(stop)                                                                                                                                                                               
set ns [new Simulator] 
set tf [open lab2.tr w] 
$ns trace-all $tf
set nf [open lab2.nam w] 
$ns namtrace-all $nf

set n0 [$ns node] 
set n1 [$ns node] 
set n2 [$ns node] 
set n3 [$ns node] 

# Set color and labels for nodes
$ns color 1 "red" 
$ns color 2 "blue" 
$n0 label "Source/TCP" 
$n1 label "Source/UDP" 
$n2 label "Router" 
$n3 label "Destination" 

# Create duplex links
$ns duplex-link $n0 $n2 100Mb 1ms DropTail
$ns duplex-link $n1 $n2 100Mb 1ms DropTail
$ns duplex-link $n2 $n3 100Mb 1ms DropTail

# Create TCP and UDP agents, FTP and CBR traffic
set tcp0 [new Agent/TCP] 
$ns attach-agent $n0 $tcp0 
set ftp0 [new Application/FTP] 
$ftp0 attach-agent $tcp0  
set sink3 [new Agent/TCPSink] 
$ns attach-agent $n3 $sink3 

set udp1 [new Agent/UDP] 
$ns attach-agent $n1 $udp1 
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1 
set null3 [new Agent/Null] 
$ns attach-agent $n3 $null3 

# Set packet size and interval
$ftp0 set packetSize_ 500Mb
$ftp0 set interval_ 0.001

$cbr1 set packetSize_ 500Mb 
$cbr1 set interval_ 0.001

# Set traffic class (red -> tcp, blue -> udp)
$tcp0 set class_ 1
$udp1 set class_ 2

# Connect agents
$ns connect $tcp0 $sink3 
$ns connect $udp1 $null3 

# Finish procedure
proc finish { } { 
    global ns nf tf
    $ns flush-trace 
    exec nam lab2.nam &
    close $nf
    close $tf
    exit 0 
}

# Schedule events
$ns at 0.1 "$cbr1 start" 
$ns at 0.2 "$ftp0 start" 
$ns at 9.5 "$cbr1 stop"
$ns at 9.5 "$ftp0 stop"
$ns at 10.0 "finish"

# Run simulation
$ns run


