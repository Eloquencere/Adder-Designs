class generator;
    rand packet master_pkt = new;
    packet pkt_to_driver;
    mailbox generator_mailbox; // local instance of mailbox
    
    function new(mailbox glue_mailbox);
        generator_mailbox = glue_mailbox;
    endfunction
    
    int total_packets, packet_count;
    event generation_ended;
    
    task dispatch;
        repeat(total_packets)
        begin
            master_pkt.randomize();
            pkt_to_driver = new master_pkt;
            generator_mailbox.put(pkt_to_driver);
            
            $display("%t: a = %d, b = %d, cin = %d, packet no. = %d", $time, pkt_to_driver.a, pkt_to_driver.b, pkt_to_driver.cin, packet_count);
            packet_count++;
        end
        $display("Generator generated %d packets", packet_count);
        -> generation_ended;
    endtask
endclass
