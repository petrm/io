Html := Element clone do(
    tag := "html"

    xmlns := method(value,
        attributes atPut("xmlns", value)
        return self
    )
)
