class driver;
    mailbox driver_mailbox;
    
    virtual DUT_interface driver_interface;
    
    function new(mailbox glue_mailbox, virtual DUT_interface glue_interface);
        driver_mailbox = glue_mailbox;
        driver_interface = glue_interface;
    endfunction
    
    int signals_driven;
    task drive;
        forever
        begin
            packet pkt_from_generator;
            driver_mailbox.get(pkt_from_generator);
            #5;
            driver_interface.a <= pkt_from_generator.a;
            driver_interface.b <= pkt_from_generator.b;
            driver_interface.cin <= pkt_from_generator.cin;
            
            $display("Driver passed");
            $display("%t: a = %d, b = %d, cin = %d, signals driven = %d", $time, pkt_from_generator.a, pkt_from_generator.b, pkt_from_generator.cin, signals_driven);
            signals_driven++;
        end
    endtask
endclass
