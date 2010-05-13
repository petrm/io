Logging

Ws := HttpServer clone do(
    logger := Logging getLogger("Ws")
    setPort(8090)
    setHost("0.0.0.0")
    renderResponse := method(request, response,
        response body = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" .. app render
        logHost := request fields at("HOST")
        commonLog := Sequence with("#{logHost} - - #{Date} ")
        commonLog appendSeq("\"#{request requestMethod} #{request path} ")
        commonLog appendSeq("#{request version}\" #{response statusCode} ")
        commonLog appendSeq("#{response body size}")
        logger info(commonLog interpolate)
    )
)
