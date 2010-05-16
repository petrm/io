EventsMixin := Object clone do(
    onclick := method(value,
        attributes atPut("onclick", value)
        return self
    )

    ondblclick := method(value,
        attributes atPut("ondblclick", value)
        return self
    )

    onmousedown := method(value,
        attributes atPut("onmousedown", value)
        return self
    )

    onmousemove := method(value,
        attributes atPut("onmousemove", value)
        return self
    )

    onmouseout := method(value,
        attributes atPut("onmouseout", value)
        return self
    )

    onmouseover := method(value,
        attributes atPut("onmouseover", value)
        return self
    )

    onmouseup := method(value,
        attributes atPut("onmouseup", value)
        return self
    )

    onkeydown := method(value,
        attributes atPut("onkeydown", value)
        return self
    )

    onkeypress := method(value,
        attributes atPut("onkeypress", value)
        return self
    )

    onkeyup := method(value,
        attributes atPut("onkeyup", value)
        return self
    )
)
