Script := Element clone do(
    tag := "script"

    with := method(
        s := self clone
        if(call message arguments size == 0,
            s children append(""),
            call message arguments foreach(arg,
                s children append(call sender doMessage(arg))
            )
        )
        s attributes atPut("type", "text/javascript")
        return s
    )

    charset := method(value,
        attributes atPut("charset", value)
        return self
    )

    defer := method(value,
        attributes atPut("defer", value)
        return self
    )

    src := method(value,
        attributes atPut("src", value)
        return self
    )

    file := method(value,
        e := try(
            f := File openForReading(value)
            children append(f contents)
            f close
        )
        e catch(Exception,
            logger error(e error)  
        )
        return self
    )

    path := method(value,
        attributes atPut("src", value)
        return self
    )

    xmlspace := method(value,
        attributes atPut("xml:space", value)
        return self
    )
)
