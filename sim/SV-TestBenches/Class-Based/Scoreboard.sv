class scoreboard;
    mailbox scoreboard_mailbox;
    
    function new(mailbox glue_mailbox);
        scoreboard_mailbox = glue_mailbox;
    endfunction
    
    int unsigned actual_sum;
    int packets_evaluated;
    task evaluate;
        forever
        begin
            packet pkt_from_monitor;
            scoreboard_mailbox.get(pkt_from_monitor);
            actual_sum = (pkt_from_monitor.a) + (pkt_from_monitor.b) + (pkt_from_monitor.cin);
            
            $display("Scoreboard Received, packet no. %d", packets_evaluated);
            
            if({(pkt_from_monitor.cout), (pkt_from_monitor.sum)} == actual_sum)
                $display("The sum is correct");
            else
                $display("DUT is not working, expected sum = %d", actual_sum);
            
            packets_evaluated++;
        end
    endtask
endclass
