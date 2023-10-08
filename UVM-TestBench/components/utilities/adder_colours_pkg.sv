package adder_colours_pkg;
    typedef enum {WHITE, BLUE, YELLOW, RED} colour_t;
    string fg_format[colour_t] = 
    '{
        WHITE: "\033[37m",
        BLUE:"\033[94m",
        YELLOW:"\033[33m",
        RED:"\033[31m"
    };
    
    function string colourise(bit mode, colour_t colour, string text);
        if(!mode)
            colour = WHITE;
        return $sformatf("%s%s\033[0m", fg_format[colour], text);
    endfunction
endpackage
