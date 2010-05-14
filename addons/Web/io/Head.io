Head := Element clone do(
    tag := "head"
    
    title := method(value,
        children append(Title with(value))
        return self
    )

    author := method(value,
        children append(Meta with name("author") content(value))
        return self
    )

    copyright := method(value,
        children append(Meta with name("copyright") content(value))
        return self
    )

    description := method(value,
        children append(Meta with name("description") content(value))
        return self
    )

    distribution := method(value,
        children append(Meta with name("distribution") content(value))
        return self
    )

    generator := method(value,
        children append(Meta with name("generator") content(value))
        return self
    )

    keywords := method(value,
        children append(Meta with name("keywords") content(value))
        return self
    )

    progid := method(value,
        children append(Meta with name("progid") content(value))
        return self
    )

    rating := method(value,
        children append(Meta with name("rating") content(value))
        return self
    )

    resourceType := method(value,
        children append(Meta with name("resource-type") content(value))
        return self
    )

    revisitAfter := method(value,
        children append(Meta with name("revisit-after") content(value))
        return self
    )

    robots := method(value,
        children append(Meta with name("robots") content(value))
        return self
    )
)
