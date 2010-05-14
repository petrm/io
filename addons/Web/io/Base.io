Base := Element clone do(
    tag := "base"

    href := method(value,
        attributes atPut("href", value)
        return self
    )

    target := method(value,
        attributes atPut("target", value)
        return self
    )

)
