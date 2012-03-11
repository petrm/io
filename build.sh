#!/bin/bash
TRACE=${TRACE:-0}
VERBOSE=${VERBOSE:-0}
STATIC=${STATIC:-0}
PREFIX=${PREFIX:-"$HOME/io/"}

CC=${CC:-"gcc"}
## -Werror -Wextra -O2
CFLAGS=${CFLAGS:-"-g -O0 -Wall -fPIC -I./include -I./include/simd_cph"}
LDFLAGS=${LDFLAGS:-"-L./lib -Wl,-rpath,'$ORIGIN/../lib'"}
##-ldl -lm -lcurses

if [ $TRACE -eq 1 ]; then
    set -v
fi
if [ $VERBOSE -eq 1 ]; then
    set -x
fi

OS=$(uname -s)
if [ $OS = "Linux" ]; then
    LIB_SUFFIX=.so
elif [ $OS = "Darwin" ]; then
    LIB_SUFFIX=.dylib
    CFLAGS="$CFLAGS -DSANE_POPEN"
elif [ $OS = "Mingw" ]; then
    LIB_SUFFIX=.dll
fi

if [ X"$1" = X"build" ]; then
    echo "Starting io build process"
    mkdir -v ./build
    mkdir -v -p ./build/bin
    mkdir -v -p ./build/lib/io
    mkdir -v -p ./build/include/simd_cph
    mkdir -v -p ./build/src
    cd ./build
    cp -R ../src/* ./src/
    cp ./src/basekit/source/*.h ./include/
    cp ./src/basekit/source/simd_cph/*.h ./include/simd_cph/
    cp ./src/coroutine/source/*.h ./include/
    cp ./src/garbagecollector/source/*.h ./include/
    cp ./src/iovm/source/*.h ./include/
    echo -e "#DEFINE INSTALL_PREFIX \"$PREFIX\"\n" > ./include/IoInstallPrefix.h


    echo "Building libbasekit"
    BASEKIT_LDFLAGS="$LDFLAGS -shared -ldl -lm -shared -Wl,-soname,libbasekit.so -Wl,-export-dynamic"
    for f in ./src/basekit/source/*.c
    do
        $CC -c $CFLAGS $f -o "${f%.*}.o"
    done
    $CC $BASEKIT_LDFLAGS -o ./lib/libbasekit.so \
    $(ls ./src/basekit/source/*.o)
    ar rcs ./lib/libbasekit.a $(ls ./src/basekit/source/*.o)


    echo "Building libcoroutine"
    COROUTINE_LDFLAGS="$LDFLAGS -shared -Wl,-soname,libcoroutine.so -Wl,-export-dynamic"
    for f in ./src/coroutine/source/*.c
    do
        gcc -c $CFLAGS $f -o "${f%.*}.o"
    done
    gcc -c $CFLAGS ./src/coroutine/source/asm.S \
        -o ./src/coroutine/source/asm.o
    gcc $COROUTINE_LDFLAGS -o ./lib/libcoroutine.so \
        $(ls ./src/coroutine/source/*.o)
    ar rcs ./lib/libcoroutine.a $(ls ./src/coroutine/source/*.o)
#-shared -dynamiclib

    echo "Building libgarbagecollector"
    GARBAGE_LDFLAGS="$LDFLAGS -shared -ldl -lbasekit -Wl,-soname,libgarbagecollector.so"
    for f in ./src/garbagecollector/source/*.c
    do
        gcc -c $CFLAGS $f -o "${f%.*}.o"
    done
    gcc -Wl,-export-dynamic $GARBAGE_LDFLAGS -o ./lib/libgarbagecollector.so \
        $(ls ./src/garbagecollector/source/*.o)
    ar rcs ./lib/libgarbagecollector.a $(ls ./src/garbagecollector/source/*.o)

    echo "Building iovm"
    IO_SRCS="./src/iovm/io/A0_List.io
         ./src/iovm/io/A1_OperatorTable.io
         ./src/iovm/io/A2_Object.io
         ./src/iovm/io/A3_List.io
         ./src/iovm/io/A4_Exception.io
         ./src/iovm/io/Actor.io
         ./src/iovm/io/AddonLoader.io
         ./src/iovm/io/B_Sequence.io
         ./src/iovm/io/Block.io
         ./src/iovm/io/CFunction.io
         ./src/iovm/io/Date.io
         ./src/iovm/io/Debugger.io
         ./src/iovm/io/Directory.io
         ./src/iovm/io/DynLib.io
         ./src/iovm/io/Error.io
         ./src/iovm/io/File.io
         ./src/iovm/io/List_schwartzian.io
         ./src/iovm/io/Map.io
         ./src/iovm/io/Message.io
         ./src/iovm/io/Number.io
         ./src/iovm/io/Profiler.io
         ./src/iovm/io/Sandbox.io
         ./src/iovm/io/Serialize.io
         ./src/iovm/io/System.io
         ./src/iovm/io/UnitTest.io
         ./src/iovm/io/Vector.io
         ./src/iovm/io/Y_Path.io
         ./src/iovm/io/Z_CLI.io
         ./src/iovm/io/Z_Importer.io"

    $CC $CFLAGS -o ./bin/io2c ./src/tools/source/io2c.c
	./bin/io2c VMCode IoState_doString_ $IO_SRCS > ./src/iovm/source/IoVMInit.c
    L_LDFLAGS="$LDFLAGS -ldl -lbasekit -lcoroutine -lgarbagecollector"
    for f in ./src/iovm/source/*.c
    do
        gcc -c $CFLAGS $f -o "${f%.*}.o"
    done
    gcc -shared -Wl,-soname,libiovm.so -Wl,-rpath,'$ORIGIN/../lib' \
        -Wl,-export-dynamic $L_LDFLAGS -o ./lib/libiovm.so \
        $(ls ./src/iovm/source/*.o)
    ar rcs ./lib/libiovm.a $(ls ./src/iovm/source/*.o)
    ar rcs ./lib/libiovm_static.a $(ls ./src/basekit/source/*.o) \
        $(ls ./src/coroutine/source/*.o) \ 
        $(ls ./src/garbagecollector/source/*.o) \
        $(ls ./src/iovm/source/*.o)


    echo "Building io binary"
    IOBIN_LDFLAGS="$LDFLAGS -ldl -lm -lbasekit -lcoroutine -lgarbagecollector -liovm"
    $CC $CFLAGS -c -o ./src/tools/source/main.o \
        ./src/tools/source/main.c

    $CC $IOBIN_LDFLAGS -o ./bin/io ./src/tools/source/main.o

    #static build
    $CC -L./lib -o ./bin/io_static ./src/tools/source/main.o -static -lbasekit \
        -lcoroutine -lgarbagecollector -liovm_static -dynamic -ldl -lm



elif [ X"$1" = X"install" ]; then
    echo "install here"
    mkdir -p -v $PREFIX
    mkdir -p -v $PREFIX/bin
    mkdir -p -v $PREFIX/include
    mkdir -p -v $PREFIX/lib
    cp -R build/bin/* $PREFIX/bin/
    cp -R build/include/* $PREFIX/include/
    cp -R build/lib/* $PREFIX/lib/



elif [ X"$1" = X"help" ]; then
	echo "Io build and installation"
	echo "Usage: $0 [help|build|install|clean]"
	echo -e "help\n\tThis message"
	echo -e "build\n\tBuild Io"
	echo -e "install\n\tInstalls Io (must have built it first)"
	echo -e "clean\n\tRemoves all build files"
    echo -e "Following options are available:\n\tVERBOSE, TRACE, PREFIX"



elif [ X"$1" = X"clean" ]; then
	[ -d build ] && rm -rf build || echo "Nothing to clean."


else
    echo "Try: $0 help"
fi

