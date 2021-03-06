# ---------------------------------------------------------------------------
#
#   Author  : github.com/luncliff (luncliff@gmail.com)
#
# ---------------------------------------------------------------------------

if(NOT UNIX)
    message(FATAL_ERROR "Expect UNIX platform. Current platform is ${CMAKE_SYSTEM}")
endif()

target_sources(${PROJECT_NAME}
PRIVATE
    posix/concrt.cpp
    net/resolver.cpp

    linux/net.cpp
    linux/suspend.cpp
)

target_compile_options(${PROJECT_NAME}
PUBLIC
    -std=c++2a
    -stdlib=libc++
    -fcoroutines-ts -fPIC
PRIVATE
    -Wall -Wno-unknown-pragmas -Wno-unused-private-field
    -fvisibility=hidden -fno-rtti
    -ferror-limit=5
)

if(${CMAKE_BUILD_TYPE} MATCHES Debug)
    # code coverage option lead to compiler crash
    # list(APPEND CMAKE_CXX_FLAGS "--coverage")
    target_compile_options(${PROJECT_NAME}
    PRIVATE
        -g -O0
    )
else()
    target_compile_options(${PROJECT_NAME}
    PRIVATE
        -O3
    )
endif()

target_link_libraries(${PROJECT_NAME}
PUBLIC
    pthread rt
    c++ # c++abi c++experimental
    stdc++
)
