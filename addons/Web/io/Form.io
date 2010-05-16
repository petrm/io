Form := Element clone do(
    tag := "form"

    appendProto(EventsMixin)

    action := method(value,
        attributes atPut("action", value)
        return self
    )

    action := method(value,
        attributes atPut("action", value)
        return self
    )

    accept := method(value,
        attributes atPut("action", value)
        return self
    )

    charset := method(value,
        attributes atPut("accept-charset", value)
        return self
    )

    enctype := method(value,
        if(list("application/x-www-form-urlencoded",
                "multipart/form-data",
                "text/plain") contains(value),
            attributes atPut("enctype", value)
        )
        return self
    )

    get := method(
        attributes atPut("method", "get")
        return self
    )

    post := method(
        attributes atPut("method", "post")
        return self
    )
)

Input := Element clone do(
    tag := "input"

    appendProto(EventsMixin)

    disabled := method(
        attributes atPut("disabled", "disabled")
        return self
    )

    name := method(value,
        attributes atPut("name", value)
        return self
    )

    readonly := method(
        attributes atPut("readonly", "readonly")
        return self
    )

    size := method(value,
        attributes atPut("size", value)
        return self
    )

    as := method(value,
        if(list("button", "checkbox", "file", "hidden", "image", "password",
            "radio", "reset", "submit", "text") contains(value),
            attributes atPut("type", value))
            // should fail on wrong element
        return self
    )

    value := method(value,
        attributes atPut("value", value)
        return self
    )

    tabindex := method(value,
        attributes atPut("tabindex", value)
        return self
    )

    onblur := method(value,
        attributes atPut("onblur", value)
        return self
    )

    onchange := method(value,
        attributes atPut("onchange", value)
        return self
    )

    onfocus := method(value,
        attributes atPut("onfocus", value)
        return self
    )

    onreset := method(value,
        attributes atPut("onreset", value)
        return self
    )

    onselect := method(value,
        attributes atPut("onselect", value)
        return self
    )

    onsubmit := method(value,
        attributes atPut("onsubmit", value)
        return self
    )
)

InputButton := Input clone do(
    attributes atPut("type", "button")

    with := method(value,
        attributes atPut("value", value)
        return self
    )

)

InputImage := Input clone do(
    src := method(value,
        attributes atPut("src", value)
        return self
    )

    alt := method(value,
        attributes atPut("alt", value)
        return self
    )
)

Checkbox := Input clone do(
    checked := method(
        attributes atPut("checked", "checked")
        return self
    )
)

InputFile := Input clone do(
    accept := method(value,
        attributes atPut("accept", value)
        return self
    )
)

Hidden := Input clone do(
)

Radio := Input clone do(
    checked := method(
        attributes atPut("checked", "checked")
        return self
    )
)

Reset := Input clone do(
)

Submit := Input clone do(
    attributes atPut("type", "submit")

    with := method(value,
        attributes atPut("value", value)
        return self
    )
)

Text := Input clone do(
    maxlength := method(value,
        attributes atPut("maxlength", value)
        return self
    )
)

Password := Input clone do(
    maxlength := method(value,
        attributes atPut("maxlength", value)
        return self
    )
)

Label := Element clone do(
    tag := "label"

    forId := method(value,
        attributes atPut("for", value)
        return self
    )
)
/*
Button := Element clone do(
    tag := "button"

    appendProto(EventsMixin)

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

    button := method(
        attributes atPut("type", "button")
        return self
        )
    )

    reset := method(
        attributes atPut("type", "reset")
        return self
        )
    )

    submit := method(
        attributes atPut("type", "submit")
        return self
        )
    )

    value := method(value,
        attributes atPut("value", value)
        return self
    )
)*/
