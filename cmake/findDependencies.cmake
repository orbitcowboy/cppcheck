if (BUILD_GUI)
    list(APPEND qt_components Core Gui Widgets PrintSupport LinguistTools Help)
    if (WITH_QCHART)
        list(APPEND qt_components Charts)
    endif()
    if (BUILD_TESTS)
        list(APPEND qt_components Test)
    endif()
    find_package(Qt5 COMPONENTS ${qt_components} REQUIRED)
endif()

if (HAVE_RULES)
    find_path(PCRE_INCLUDE pcre.h)
    find_library(PCRE_LIBRARY pcre)
    if (NOT PCRE_LIBRARY OR NOT PCRE_INCLUDE)
        message(FATAL_ERROR "pcre dependency for RULES has not been found")
    endif()
endif()

if (USE_Z3)
    find_package(Z3 QUIET)
    if (NOT Z3_FOUND)
        find_library(Z3_LIBRARIES z3)
        if (NOT Z3_LIBRARIES)
            message(FATAL_ERROR "z3 dependency has not been found")
        endif()
        find_path(Z3_CXX_INCLUDE_DIRS z3++.h PATH_SUFFIXES "z3")
        if (NOT Z3_CXX_INCLUDE_DIRS)
            message(FATAL_ERROR "z3++.h has not been found")
        endif()
    endif()
endif()

set(CMAKE_INCLUDE_CURRENT_DIR ON)

if (NOT USE_MATCHCOMPILER_OPT MATCHES "Off")
    find_package(PythonInterp 3 QUIET)
    if (NOT PYTHONINTERP_FOUND)
        set(PYTHONINTERP_FOUND "")
        find_package(PythonInterp 2.7 QUIET)
        if (NOT PYTHONINTERP_FOUND)
            message(WARNING "No python interpreter found. Therefore, the match compiler is switched off.")
            set(USE_MATCHCOMPILER_OPT "Off")
        endif()
    endif()
endif()

if (NOT USE_BUNDLED_TINYXML2)
    find_package(tinyxml2 QUIET)
    if (NOT tinyxml2_FOUND)
        find_library(tinyxml2_LIBRARIES tinyxml2)
        if (NOT tinyxml2_LIBRARIES)
            message(FATAL_ERROR "tinyxml2 has not been found")
        else()
            set(tinyxml2_FOUND 1)
        endif()
    endif()
endif()

if (USE_THREADS)
    find_package(Threads REQUIRED)
endif()

if (USE_BOOST)
    find_package(Boost COMPONENTS container QUIET)
endif()
