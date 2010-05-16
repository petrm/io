Doctype := Object clone do(
    xmlproc := "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
    xhtml := method(
        return xmlproc .. "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">\n"
    )
    html5 := method(
        return xmlproc .. "<!DOCTYPE html>"
    )
)
