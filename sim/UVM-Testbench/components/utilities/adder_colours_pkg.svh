package adder_colours_pkg;
    typedef enum {WHITE, BLUE, YELLOW, RED, GREEN} colour_t;

    // Assigning ANSI colour codes to each colour
    string fg_format[colour_t] = '{
        WHITE : "\033[37m",
        BLUE : "\033[94m",
        YELLOW : "\033[33m",
        RED : "\033[31m",
        GREEN : "\033[32m"
    };

    function automatic string colourise(colour_t colour, string text);
        return $sformatf("%s%s\033[0m", fg_format[colour], text);
    endfunction
endpackage
