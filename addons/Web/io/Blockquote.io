Blockquote := Element clone do(
    tag := "blockquote"

    cite := method(value,
        attributes atPut("cite", value)
        return self
    )
)
