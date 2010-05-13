Button := Element clone do(
    tag := "body"

    disabled := method(value,
        if(value == "disabled",
            attributes atPut("disabled", value)
        )
        return self
    )

    name := method(value,
        attributes atPut("name", value)
        return self
    )

    type := method(value,
        if(list("button", "reset", "submit") contains(value),
            attributes atPut("type", value)
            return self
        )
    )

    value := method(value,
        attributes atPut("value", value)
        return self
    )
)
