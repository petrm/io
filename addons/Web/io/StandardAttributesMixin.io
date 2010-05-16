StandardAttributesMixin := Object clone do(
    title := method(value,
        children append(Title clone with(value))
        return self
    )
)
