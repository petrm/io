Logging


WsRequestHandler := Object clone do(
    logger := Logging getLogger("Ws::handler")
    handleRequest := method(request, response,
        response data = "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n" .. Doctype xhtml .. app render
		response statusCode := 200
		response responseMessage := "OK"
        response headers atPut("Content-Type", "text/html; charset=utf-8")
		response asyncSend
        logHost := request headers at("host")
        commonLog := Sequence with("#{logHost} - - #{Date} ")
        commonLog appendSeq("\"#{request httpMethod} #{request path} ")
        //commonLog appendSeq("#{request version}\" #{response statusCode} ")
        commonLog appendSeq("#{response data size}")
        logger info(commonLog interpolate)
    )
)


Ws := EvHttpServer clone do(
    logger := Logging getLogger("Ws")
    logger info("Starting HTTP server")
) setHost("0.0.0.0") setPort(8090) setRequestHandlerProto(WsRequestHandler) run
Coroutine currentCoroutine pause
loop(yield)
