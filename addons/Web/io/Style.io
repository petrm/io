Style := Element clone do(
    tag := "style"

    mime := method(value,
        attributes atPut("type", value)        
    )

    media := method(value,
        if(list("screen", "tty", "tv", "projection", "handheld", "print",
            "braille", "aural", "all") contains(value),
            attributes atPut("media", value)
        )
        return self
    )
)
