solution "Io"
    configurations { "release", "debug", "test" }

    if _ACTION == "clean" then
        os.rmdir("_build")
    end

    function defaultaction(osName, actionName)
        if os.is(osName) then
            _ACTION = _ACTION or actionName
        end
    end
     
    defaultaction("windows", "gmake")
    defaultaction("linux", "gmake")
    defaultaction("macosx", "gmake")

    newaction {
       trigger     = "_build",
       description = "Build the software",
       execute     = function()
            os.chdir("_build")
            f = assert(io.popen("make"))
            --f = assert(io.popen("make SILENT=")
            --f = assert(io.popen("make SILENT= config=" .. os.get()))
            for line in f:lines() do
                print(line)
            end
            f:close()
       end
    }

    newaction {
       trigger     = "test",
       description = "Test the software",
       execute     = function()
            print("testing testing")
       end
    }

    newaction {
       trigger     = "install",
       description = "Install the software",
       execute     = function()
            print("This is currently broken.")
            --os.mkdir("/io/io/lib/io/addons/Iup")
            --os.mkdir("/io/io/lib/io/addons/Iup/_build")
            --os.mkdir("/io/io/lib/io/addons/Iup/_build/dll")
            --os.mkdir("/io/io/lib/io/addons/Iup/io")
            --os.copyfile("_build/dll/IoIup.dll", "/io/io/lib/io/addons/Iup/_build/dll/libIoIup.dll")
            --os.copyfile("depends", "/io/io/lib/io/addons/Iup/depends")
            --os.copyfile("protos", "/io/io/lib/io/addons/Iup/protos")
       end
    }

    configuration { "release" }
        defines { "NDEBUG" }
        flags { "Optimize" }

    configuration { "debug" }
        defines { "DEBUG" }
        flags { "Symbols" }

    configuration { "linux", "gmake" }
        linkoptions "-Wl,-rpath,'$ORIGIN/../lib'"


    project "io2c"
        --uuid "62df2010-1955-11e1-bddb-0800200c9a66"
        location "_build"
        targetdir "_build/bin"
        kind "ConsoleApp"
        language "C"
        objdir "_build/objs"
        files { "src/tools/source/io2c.c" }
        flags { "ExtraWarnings",
                "StaticRuntime",
                "EnableSSE",
                "EnableSSE2"
              }

        io_src="../src/iovm/io/A0_List.io ../src/iovm/io/A1_OperatorTable.io ../src/iovm/io/A2_Object.io ../src/iovm/io/A3_List.io ../src/iovm/io/A4_Exception.io ../src/iovm/io/Actor.io ../src/iovm/io/AddonLoader.io ../src/iovm/io/B_Sequence.io ../src/iovm/io/Block.io ../src/iovm/io/CFunction.io ../src/iovm/io/Date.io ../src/iovm/io/Debugger.io ../src/iovm/io/Directory.io ../src/iovm/io/DynLib.io ../src/iovm/io/Error.io ../src/iovm/io/File.io ../src/iovm/io/List_schwartzian.io ../src/iovm/io/Map.io ../src/iovm/io/Message.io ../src/iovm/io/Number.io ../src/iovm/io/Profiler.io ../src/iovm/io/Sandbox.io ../src/iovm/io/Serialize.io ../src/iovm/io/System.io ../src/iovm/io/UnitTest.io ../src/iovm/io/Vector.io ../src/iovm/io/Y_Path.io ../src/iovm/io/Z_CLI.io ../src/iovm/io/Z_Importer.io"


	    postbuildcommands { "bin/io2c VMCode IoState_doString_ " .. io_src .. " > IoVMInit.c" }
        postbuildcommands { "echo \"#define INSTALL_PREFIX \"./\"\" > ../src/iovm/source/IoInstallPrefix.h" }

-- FIXME: this requires a file name, which we don't have here yet.
--    configuration { "macosx", "gmake" }
--        linkoptions "-Wl,-install_name,'../lib'"

    project "basekit"
        --uuid "62df2010-1955-11e1-bddb-0800200c9a66"
        location "_build"
        targetdir "_build/lib"
        kind "SharedLib"
        language "C"
        objdir "_build/objs"
        includedirs { "src/basekit/source",
                      "src/basekit/source/simd_cph"
                    }
        libdirs { "_build/lib" }
        files { "src/basekit/source/*.c" }
        links { "m" }
        flags { "ExtraWarnings",
                "StaticRuntime",
                "EnableSSE",
                "EnableSSE2"
              }

        configuration { "linux or macosx" }
            links { "dl" }

        configuration { "windows" }
            defines { "CALLSPEC=__dllexport",
                      "WIN32"
                    }
            targetprefix "lib"

        configuration { "macosx", "gmake" }
            linkoptions "-wl,-install_name,'../lib/libbasekit.dylib'"


    project "coroutine"
        --uuid "62df2010-1955-11e1-bddb-0800200c9a66"
        location "_build"
        targetdir "_build/lib"
        kind "SharedLib"
        language "C"
        objdir "_build/objs"
        includedirs { "src/basekit/source", 
                      "src/coroutine/source"
                    }
        libdirs { "_build/lib" }
        files { "src/coroutine/source/*.c",
                "src/coroutine/source/asm.S"
              }
        flags { "ExtraWarnings",
                "StaticRuntime",
                "EnableSSE",
                "EnableSSE2"
              }

        configuration { "windows" }
            defines { "CALLSPEC=__dllexport",
                      "WIN32"
                    }
            targetprefix "lib"

        configuration { "macosx", "gmake" }
            linkoptions "-wl,-install_name,'../lib/libcoroutine.dylib'"


    project "garbagecollector"
        --uuid "62df2010-1955-11e1-bddb-0800200c9a66"
        location "_build"
        targetdir "_build/lib"
        kind "SharedLib"
        language "C"
        objdir "_build/objs"
        includedirs { "src/garbagecollector/source",
                      "src/basekit/source"
                    }
        libdirs { "_build/lib" }
        links { "basekit" }
        files { "src/garbagecollector/source/*.c" }
        flags { "ExtraWarnings",
                "StaticRuntime",
                "EnableSSE",
                "EnableSSE2"
              }

        configuration { "linux or macosx" }
            links { "dl" }

        configuration { "windows" }
            defines { "CALLSPEC=__dllexport",
                      "WIN32"
                    }
            targetprefix "lib"

        configuration { "macosx", "gmake" }
            linkoptions "-wl,-install_name,'../lib/libgarbagecollector.dylib'"


    project "iovm"
        --uuid "62df2010-1955-11e1-bddb-0800200c9a66"
        location "_build"
        targetdir "_build/lib"
        kind "SharedLib"
        language "C"
        objdir "_build/objs"
        includedirs { "src/garbagecollector/source",
                      "src/coroutine/source",
                      "src/basekit/source",
                      "src/iovm/source"
                    }
        libdirs { "_build/lib" }
        links { "basekit", "coroutine", "garbagecollector" }
        files { "src/iovm/source/*.c" }
        flags { "ExtraWarnings",
                "StaticRuntime",
                "EnableSSE",
                "EnableSSE2"
              }

        configuration { "linux or macosx" }
            links { "dl" }

        configuration { "windows" }
            defines { "CALLSPEC=__dllexport",
                      "WIN32"
                    }
            targetprefix "lib"

        configuration { "macosx", "gmake" }
            linkoptions "-wl,-install_name,'../lib/libiovm.dylib'"



    project "io"
        --uuid "62df2010-1955-11e1-bddb-0800200c9a66"

        location "_build"
        targetdir "_build/bin"
        kind "ConsoleApp"
        language "C"
        includedirs { "src/garbagecollector/source",
                      "src/coroutine/source",
                      "src/basekit/source",
                      "src/iovm/source",
                      "_build"
                    }
        objdir "_build/objs"
        files { "src/tools/source/main.c",
                "_build/IoVMInit.c"
              }
        links { "basekit", "coroutine", "garbagecollector", "iovm" }
        flags { "ExtraWarnings",
                "StaticRuntime",
                "EnableSSE",
                "EnableSSE2"
              }

        configuration { "linux or macosx" }
            links { "dl" }
