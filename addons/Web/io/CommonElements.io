CommonElements := Object clone

Acronym := Element clone do(
    tag := "acronym"
    appendProto(EventsMixin)
)

Address := Element clone do(
    tag := "address"
    appendProto(EventsMixin)
)

Anchor := Element clone do(
    tag := "a"
    
    appendProto(EventsMixin)

    action := method(value,
        attributes atPut("href", value)
        return self
    )
)

Base := Element clone do(
    tag := "base"

    href := method(value,
        attributes atPut("href", value)
        return self
    )

    target := method(value,
        attributes atPut("target", value)
        return self
    )
)

Body := Element clone do(
    tag := "body"
    
    onload := method(value,
        attributes atPut("onload", value)
        return self
    )

    onunload := method(value,
        attributes atPut("onunload", value)
        return self
    )
)

Em := Element clone do(
    tag := "em"
    appendProto(EventsMixin)
)

Strong := Element clone do(
    tag := "strong"
    appendProto(EventsMixin)
)

Dfn := Element clone do(
    tag := "dfn"
    appendProto(EventsMixin)
)

Code := Element clone do(
    tag := "code"
    appendProto(EventsMixin)
)

Kbd := Element clone do(
    tag := "kbd"
    appendProto(EventsMixin)
)

Var := Element clone do(
    tag := "var"
    appendProto(EventsMixin)
)

I := Element clone do(
    tag := "i"
    appendProto(EventsMixin)
)

B := Element clone do(
    tag := "b"
    appendProto(EventsMixin)
)

Big := Element clone do(
    tag := "big"
    appendProto(EventsMixin)
)

Blockquote := Element clone do(
    tag := "blockquote"
    appendProto(EventsMixin)
)

Cite := Element clone do(
    tag := "cite"
    appendProto(EventsMixin)
)

Small := Element clone do(
    tag := "small"
    appendProto(EventsMixin)
)

Sub := Element clone do(
    tag := "sub"
    appendProto(EventsMixin)
)

Sup := Element clone do(
    tag := "sup"
    appendProto(EventsMixin)
)

Del := Element clone do(
    tag := "del"
    appendProto(EventsMixin)

    cite := method(value,
        attributes atPut("cite", value)
        return self
    )

    datetime := method(value,
        attributes atPut("datetime", value)
        return self
    )
)

Ins := Element clone do(
    tag := "ins"
    appendProto(EventsMixin)

    cite := method(value,
        attributes atPut("cite", value)
        return self
    )

    datetime := method(value,
        attributes atPut("datetime", value)
        return self
    )
)

Br := Element clone do(
    tag := "br"
)

Comment := Element clone do(
    tag := ""

    render := method(out,
        out = out .. "<!--" .. self children .. "-->"
        return out
    )
)

Paragraph := Element clone do(
    tag := "p"
    appendProto(EventsMixin)
)

Title := Element clone do(
    tag := "title"
)

Ul := Element clone do(
    tag := "ul"
    appendProto(EventsMixin)
)

Li := Element clone do(
    tag := "li"
    appendProto(EventsMixin)
)

Div := Element clone do(
    tag := "div"
    appendProto(EventsMixin)
)

Samp := Element clone do(
    tag := "samp"
    appendProto(EventsMixin)
)

Span := Element clone do(
    tag := "span"
    appendProto(EventsMixin)
)
