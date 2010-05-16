Logging
CommonElements

Web := Object clone do(
    control := Div with(
        Style with(".bar {margin-left: 15px; margin-right: 15px;}
        .bar a {text-decoration: none;}"),
        Span with(Anchor with("New session") action("")) class("bar"),
        Span with(Anchor with("Toggle halos") action("")) class("bar"),
        Span with(Anchor with("Memory use") action("")) class("bar"),
        Span with(Anchor with("Profile") action("")) class("bar"),
        Span with(Anchor with("Pretty print") action("")) class("bar"),
        Span with(Anchor with("Configure") action("")) class("bar")
    ) style("font-family: sans-serif; font-size: 12px; position: absolute;
    bottom: 0px; height: 15px; width: 100%; background-color: #f0f0f0;")
)
