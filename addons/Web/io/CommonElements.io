Em := Element clone do(
    tag := "em"
)

Strong := Element clone do(
    tag := "strong"
)

Dfn := Element clone do(
    tag := "dfn"
)

Code := Element clone do(
    tag := "code"
)

Samp := Element clone do(
    tag := "samp"
)

Kbd := Element clone do(
    tag := "kbd"
)

Var := Element clone do(
    tag := "var"
)

Cite := Element clone do(
    tag := "cite"
)

I := Element clone do(
    tag := "i"
)

B := Element clone do(
    tag := "b"
)

Big := Element clone do(
    tag := "big"
)

Small := Element clone do(
    tag := "small"
)

Sub := Element clone do(
    tag := "sub"
)

Sup := Element clone do(
    tag := "sup"
)

Del := Element clone do(
    tag := "del"

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

Break := Element clone do(
    tag := "br"
)

Comment := Element clone do(
    tag := ""

    render := method(out,
        out = out .. "<!--" .. self children .. "-->"
        return out
    )
)

Blockquote := Element clone do(
    tag := "blockquote"

    cite := method(value,
        attributes atPut("cite", value)
        return self
    )
)

Paragraph := Element clone do(
    tag := "p"
)

Title := Element clone do(
    tag := "title"
)

Ul := Element clone do(
    tag := "ul"
)

Li := Element clone do(
    tag := "li"
)

Acronym := Element clone do(
    tag := "acronym"
)

Address := Element clone do(
    tag := "address"
)

Anchor := Element clone do(
    tag := "a"
    
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
)

Div := Element clone do(
    tag := "div"
)

Samp := Element clone do(
    tag := "samp"
)

Span := Element clone do(
    tag := "span"
)
