cmake_minimum_required(VERSION 3.11)
project("example")

SET(SRCS 
    source/cache.cpp 
    source/hash.cpp
)

add_library(lclib STATIC ${SRCS})
target_include_directories(lclib PUBLIC "include")

add_executable(start.x main.cpp)
target_link_libraries(start.x lclib)

# startcmake -S . -B build
# cmake --build build

SET(TESTS ${CMAKE_SOURCE_DIR/tests})
file(GLOB testfiles "tests/*.dat")
foreach(file ${testfiles})
    add_test(NAME ${file})
        COMMAND bash -c "${CMAKE_SOURCE_DIR}/runtest.sh ${file} ./start.x"    
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
    set_tests_properties(${file} PROPERTIES DEPENDS start.x)
endforeach()
