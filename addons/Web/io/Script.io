Script := Element clone do(
    tag := "script"

    type := method(value,
        attributes atPut("type", value)
        return self
    )

    charset := method(value,
        attributes atPut("charset", value)
        return self
    )

    defer := method(value,
        attributes atPut("defer", value)
        return self
    )

    src := method(value,
        attributes atPut("src", value)
        return self
    )

    xmlspace := method(value,
        attributes atPut("xml:space", value)
        return self
    )

)
