FileHandler := Handler clone do(
    with := method(fname,
        s := self clone
        s file := File open(fname)
        return s
    )

    handle := method(msg,
        file write(msg, "\n")
    )
)
