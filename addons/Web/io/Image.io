Image := Element clone do(
    tag := "img"

    alt := method(value,
        attributes atPut("alt", value)
        return self
    )

    src := method(value,
        attributes atPut("src", value)
        return self
    )

    height := method(value,
        attributes atPut("height", value)
        return self
    )

    ismap := method(value,
        attributes atPut("ismap", value)
        return self
    )

    longdesc := method(value,
        attributes atPut("longdesc", value)
        return self
    )

    usemap := method(value,
        attributes atPut("usemap", value)
        return self
    )
    
    width := method(value,
        attributes atPut("width", value)
        return self
    )
)
