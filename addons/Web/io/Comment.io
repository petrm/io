Comment := Element clone do(
    tag := ""

    render := method(out,
        out = out .. "<!--" .. self children .. "-->"
        return out
    )
)
