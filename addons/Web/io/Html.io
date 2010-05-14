Html := Element clone do(
    tag := "html"

    init := method(
        super(init)
        attributes atPut("xmlns", "http://www.w3.org/1999/xhtml")
    )

    xmlns := method(value,
        attributes atPut("xmlns", value)
        return self
    )
)
