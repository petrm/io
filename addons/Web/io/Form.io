Form := Element clone do(
    tag := "form"

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
                "text/plain") contains value,
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
