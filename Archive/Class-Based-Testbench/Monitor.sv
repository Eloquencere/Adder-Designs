class monitor;
    mailbox monitor_mailbox;
    
    virtual DUT_interface monitor_interface;
    
    function new(mailbox glue_mailbox, virtual DUT_interface glue_interface);
        monitor_mailbox = glue_mailbox;
        monitor_interface = glue_interface;
    endfunction
    
    int signals_received;
    task watch;
        forever 
        begin
            packet pkt_to_scoreboard = new();
            #7;
            pkt_to_scoreboard.a = monitor_interface.a; // write monitor
            pkt_to_scoreboard.b = monitor_interface.b;
            pkt_to_scoreboard.cin = monitor_interface.cin; 
            pkt_to_scoreboard.sum = monitor_interface.sum; // read monitor
            pkt_to_scoreboard.cout = monitor_interface.cout;
            monitor_mailbox.put(pkt_to_scoreboard);
            
            $display("Monitor Received");
            $display("%t: a = %d, b = %d, cin = %d, sum = %d, cout = %d, signals received = %d", $time, pkt_to_scoreboard.a, pkt_to_scoreboard.b, pkt_to_scoreboard.cin, pkt_to_scoreboard.sum, pkt_to_scoreboard.cout, signals_received);
            signals_received++;
        end
    endtask
endclass
