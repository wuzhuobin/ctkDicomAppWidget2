# Qt5Core 
IF(NOT QT_QTCORE_FOUND)
    find_package(Qt5Core REQUIRED)
    # LIBRARIES
    list(
        APPEND
        PROJECT_LIBRARY
        Qt5::Core
    )
ENDIF()

# Qt5Widgets
IF(NOT QT_QTWIDGETS_FOUND)
    find_package(Qt5Widgets REQUIRED)
    # LIBRARIES
    list(
        APPEND
        PROJECT_LIBRARY
        Qt5::Widgets
    )
ENDIF()

# Qt5OpenGL
IF(NOT QT_QTOPENGL)
    find_package(Qt5OpenGL REQUIRED)
    # LIBRARIES
    list(
        APPEND
        PROJECT_LIBRARY
        Qt5::OpenGL
    )
ENDIF()

# Qt5Sql
IF(NOT QT_QTSQL)
    find_package(Qt5Sql REQUIRED)
    # LIBRARIES
    list(
        APPEND
        PROJECT_LIBRARY
        Qt5::Sql
    )
ENDIF()

# Qt5Xml
IF(NOT QT_QTXML)
    find_package(Qt5Xml REQUIRED)
    # LIBRARIES
    list(
        APPEND
        PROJECT_LIBRARY
        Qt5::Xml
    )
ENDIF()

# Instruct CMake to run moc automatically when needed
set(CMAKE_AUTOMOC ON)
# Create code from a list of Qt designer ui files
# set(CMAKE_AUTOUIC ON)
# *.UI files
file(
    GLOB
    PROJECT_UI
    ${PROJECT_SOURCE_DIR}/*.ui
)
qt5_wrap_ui(
    PROJECT_UI_INC
    ${PROJECT_UI}
)
list(
    APPEND
    PROJECT_SRC
    ${PROJECT_UI}
    ${PROJECT_UI_INC}
)
# *.qrc files
file(
    GLOB
    PROJECT_QRC
    *.qrc
)
list(
    APPEND
    PROJECT_QRC
    ${CMAKE_PROJECT_QRC}
)
qt5_add_resources(
    PROJECT_QRC_SRC
    ${PROJECT_QRC}
)
list(
    APPEND
    PROJECT_SRC
    ${PROJECT_QRC}
    ${PROJECT_QRC_SRC}
)
# *.moc files
# moc_*.cpp files
# file(
#     GLOB
#     PROJECT_MOC
#     ${PROJECT_BINARY_DIR}/*.moc
# )
# file(
#     GLOB
#     PROJECT_MOC_SRC
#     ${PROJECT_BINARY_DIR}/moc_*.cpp
# )
# list(
#     APPEND
#     PROJECT_SRC
#     ${PROJECT_MOC}
#     ${PROJECT_MOC_SRC}
# )