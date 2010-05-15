Meta := Element clone do(
    tag := "meta"
    
    content := method(value,
        attributes atPut("content", value)
        return self
    )

    equiv := method(value,
        if(list("content-type", "content-style-type", "expires", "refresh",
            "set-cookie") contains(value),
            attributes atPut("http-equiv", value)
        )
        return self
    )

    name := method(value,
        if(list("author", "copyright", "description", "distribution",
            "generator", "keywords", "progid", "rating", "resource-type",
            "revisit-after", "robots") contains(value),
            attributes atPut("name", value)
        )
        return self
    )

    scheme := method(value,
        attributes atPut("scheme", value)
        return self
    )
)
