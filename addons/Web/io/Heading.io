Heading := Element clone do(
    tag := "h1"

    appendProto(EventsMixin)

    huge := method(
        tag = "h6"
        return self
    )

    big := method(
        tag = "h5"
        return self
    )

    large := method(
        tag = "h4"
        return self
    )

    normal := method(
        tag = "h3"
        return self
    )

    small := method(
        tag = "h2"
        return self
    )

    tiny := method(
        tag = "h1"
        return self
    )
)
