HalosMixin := Object clone do(
    halos := true
    
    haloContainer := method(
        return Div with(
            Div with("halos") style("border-bottom: 1px solid; width: 100%;
            height: 15px; background-color: #f0f0f0; font-family: sans-serif;
            font-size: 12px;"),
            Div with(children) onmouseover("alert(this.innerHTML);")
        ) style("border: 1px solid;")
    )
)
