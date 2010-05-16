Component := Element clone do(
    static := nil
    cache := nil
    appendProto(HalosMixin)
    
    init := method(
        super(init)
        static = false
    )
    
    render := method(out,
        if(out == nil, out = "")
        if(halos == true) then(
            out = haloContainer render(out)
        ) else(
            if((static == false) or (cache == nil)) then(
                children foreach(i, child,
                    if(child hasSlot("render"),
                        out = child render(out),
                        out = out .. child
                    )
                )
                cache = out asUTF8
                out = out asUTF8
            ) else (
                out = cache
            )
        )
        return out
    )
)
