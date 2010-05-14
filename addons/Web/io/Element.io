Logging

Element := Object clone do(
    tag := ""
    lt := "&lt;"
    gt := "&gt;"
    logger := Logging getLogger("Web::Element")

    iso639 := list("ab", "aa", "af", "sq", "am", "ar", "hy", "as", "ay", "az", "ba", "eu", "bn", "dz", "bh", "bi", "br", "bg", "my", "be", "km", "ca", "zh", "zh", "co", "hr", "cs", "da", "nl", "en", "eo", "et", "fo", "fa", "fj", "fi", "fr", "fy", "gl", "gd", "gv", "ka", "de", "el", "kl", "gn", "gu", "ha", "he", "iw", "hi", "hu", "is", "id", "in", "ia", "ie", "iu", "ik", "ga", "it", "ja", "jv", "kn", "ks", "kk", "rw", "ky", "rn", "ko", "ku", "lo", "la", "lv", "li", "ln", "lt", "mk", "mg", "ms", "ml", "mt", "mi", "mr", "mo", "mn", "na", "ne", "no", "oc", "or", "om", "ps", "pl", "pt", "pa", "qu", "rm", "ro", "ru", "sm", "sg", "sa", "sr", "sh", "st", "tn", "sn", "sd", "si", "ss", "sk", "sl", "so", "es", "su", "sw", "sv", "tl", "tg", "ta", "tt", "te", "th", "bo", "ti", "to", "ts", "tr", "tk", "tw", "ug", "uk", "ur", "uz", "vi", "vo", "cy", "wo", "xh", "yi", "ji", "yo", "zu")
    
    init := method(
        self attributes := Map clone
        self children := list clone
    )

    with := method(
        s := self clone
        call message arguments foreach(arg,
            child := call sender doMessage(arg)
            if(child protos contains(List),
                s children = child,
                s children append(child)
            )
        )
        return s
    )

    id := method(value,
        attributes atPut("id", value)
        return self
    )

    class := method(value,
        attributes atPut("class", value)
        return self
    )

    dir := method(value,
        if(list("ltr", "rtl") contains(value),
            attributes atPut("dir", value)
        )
        return self
    )

    language := method(value,
        // validate if selected language exists
        if(iso639 contains(value),
            attributes atPut("lang", value)
            attributes atPut("xml:lang", value)
        )
        return self
    )

    style := method(value,
        attributes atPut("style", value)
        return self
    )

    title := method(value,
        attributes atPut("title", value)
        return self
    )

    br := method(value,
        children append(Br clone)
        return self
    )

    onclick := method(value,
        attributes atPut("onclick", value)
        return self
    )

    ondblclick := method(value,
        attributes atPut("ondblclick", value)
        return self
    )

    onmousedown := method(value,
        attributes atPut("onmousedown", value)
        return self
    )

    onmousemove := method(value,
        attributes atPut("onmousemove", value)
        return self
    )

    onmouseout := method(value,
        attributes atPut("onmouseout", value)
        return self
    )

    onmouseover := method(value,
        attributes atPut("onmouseover", value)
        return self
    )

    onmouseup := method(value,
        attributes atPut("onmouseup", value)
        return self
    )

    onkeydown := method(value,
        attributes atPut("onkeydown", value)
        return self
    )

    onkeypress := method(value,
        attributes atPut("onkeypress", value)
        return self
    )

    onkeyup := method(value,
        attributes atPut("onkeyup", value)
        return self
    )
  
    render := method(out,
        if(out == nil, out = "")
        attrString := ""
        attributes foreach(key, value,
            attrString = attrString .. (" #{key}=\"#{value}\"" interpolate)
        )
        if(children size > 0) then(
            out = out .. ("<#{tag}#{attrString}>" interpolate)
            children foreach(i, child,
                if(child hasSlot("render"),
                    out = child render(out),
                    out = out .. child
                )
                //e := try(out = child render(out))
                //e catch(Exception, out := out .. child)
            )
            out = out .. ("</#{tag}>\n" interpolate)
        ) else(
            out = out .. ("<#{tag}#{attrString} />\n" interpolate)
        )
        return out asUTF8
    )
)
