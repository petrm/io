HalosMixin := Object clone do(
    halos := false
    
    haloContainer := method(
        return Div with(
            Div with(
                Img with("seaside-codebrowser.png") alt("seaside-codebrowser.png"),
                Img with("seaside-inspector.png") alt("seaside-inspector.png"),
                Img with("seaside-styleeditor.png") alt("seaside-styleeditor.png")
            ) style("border-bottom: 1px solid; width: 100%;
            height: 15px; background-color: #f0f0f0; font-family: sans-serif;
            font-size: 12px; text-align: left;"),
            Div with(children)
        ) style("border: 1px solid;")
    )
)
