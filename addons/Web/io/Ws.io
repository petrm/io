Logging
//Regex

WsRequestHandler := Object clone do(
    logger := Logging getLogger("Ws::handler")
    logger format = "#{text}"
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
                response headers atPut("Content-Type", Ws staticContent at(pSuffix))
            )
            e catch(Exception,
                logger error(e error)
                response = Ws error404(response)
            )
        //serve html
        ) elseif(Ws urls keys contains(request path)) then(
            response statusCode := 200
            response responseMessage := "OK"
            response headers atPut("Content-Type", "text/html; charset=utf-8")
            if(request httpMethod == "GET") then(
                response = Ws urls at(request path) get(request, response)
            ) elseif(request httpMethod == "POST") then(
                response = Ws urls at(request path) post(request, response)
            )
        ) else(
            response = Ws error404(response)
        )
        request println
        response asyncCometStart
        commonLog := Sequence with("#{request headers at(\"host\")} - - [#{Date}] ")
        commonLog appendSeq("\"#{request httpMethod} #{request path} ")
        commonLog appendSeq("HTTP/1.1\" ")
        //commonLog appendSeq("#{request version}\"")
        commonLog appendSeq("#{response statusCode} ")
        commonLog appendSeq("#{response data size} ")
        commonLog appendSeq("\"#{request headers at(\"referer\")}\" ")
        commonLog appendSeq("#{request headers at(\"user-agent\")}")
        logger info(commonLog interpolate)
    )
)


Ws := EvHttpServer clone do(
    logger := Logging getLogger("Ws")
    logger info("Starting HTTP server")
    staticPath := System launchPath .. "/static/"
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
        loop(yield)
    )
) setHost("0.0.0.0") setPort(8090) setRequestHandlerProto(WsRequestHandler)

