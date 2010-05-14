Component := Element clone do(
    static := nil
    cache := nil
    appendProto(HalosMixin)
    
    init := method(
        super(init)
        static = false
    )
    
    render := method(out,
        if(halos == true) then(
            out = haloContainer render(out)
            //haloContainer render println
        ) else(
            if((static == false) or (cache == nil)) then(
                children foreach(i, child,
                    if(child hasSlot("render"),
                        out = child render(out),
                        out = out .. child
                    )
                )
                cache == out
            ) else (
                out = cache
            )
        )
        return out
    )
)
