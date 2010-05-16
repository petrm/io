Link := Element clone do(
    tag := "link"

    appendProto(EventsMixin)

    rel := method(value,
        attributes atPut("rel", value)
        return self
    )

    mime := method(value,
        attributes atPut("type", value)
        return self
    )

    href := method(value,
        attributes atPut("href", value)
        return self
    )
)
