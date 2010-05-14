Logging
//Regex

WsRequestHandler := Object clone do(
    logger := Logging getLogger("Ws::handler")
    handleRequest := method(request, response,
        //serve static content
        pSuffix := request path split("/") last split(".") last
        if(request path == "/kill") then(
            Ws stop
        ) elseif(pSuffix != nil and Ws staticContent hasKey(pSuffix)) then(
            e := try(
                f := File openForReading(Ws staticPath .. request path split("/") last)
                response data = f contents
                f close
                response statusCode := 200
                response responseMessage := "OK"
                response headers atPut("Content-Type", "image/png")
            )
            e catch(Exception,
                logger error(e error)
                response = Ws error404(response)
            )
        //serve html
        ) elseif(Ws urls keys contains(request path)) then(
            response data =  Doctype xhtml .. Ws urls at(request path) render
            response statusCode := 200
            response responseMessage := "OK"
            response headers atPut("Content-Type", "text/html; charset=utf-8")
        ) else(
            response = Ws error404(response)
        )
        response asyncSend
        logHost := request headers at("host")
        commonLog := Sequence with("#{logHost} - - #{Date} ")
        commonLog appendSeq("\"#{request httpMethod} #{request path} ")
        //commonLog appendSeq("#{request version}\"")
        commonLog appendSeq("#{response statusCode} ")
        commonLog appendSeq("#{response data size}")
        logger info(commonLog interpolate)
    )
)


Ws := EvHttpServer clone do(
    logger := Logging getLogger("Ws")
    logger info("Starting HTTP server")
    staticPath := System launchScript split("/")
    staticPath removeLast
    staticPath = staticPath join("/") .. "/static/"
    logger info("Default static path: " .. staticPath)
    staticContent := Map with("png", "image/png",
                              "jpg", "image/jpeg",
                              "css", "text/css",
                              "js", "application/x-javascript")
    urls := Map clone

    error404 := method(response,
        response data = Doctype xhtml .. "404 Not Found"
        response statusCode := 404
        response responseMessage := "Not Found"
        response headers atPut("Content-Type", "text/html; charset=utf-8")
        return response
    )

    run := method(
        super(run)
        Coroutine currentCoroutine pause
        //loop(yield)
    )
) setHost("0.0.0.0") setPort(8090) setRequestHandlerProto(WsRequestHandler)

