# Qt5Core & Qt5Widgets
find_package(Qt5Core REQUIRED)
find_package(Qt5Widgets REQUIRED)
# LIBRARIES
list(
    APPEND
    PROJECT_LIBRARY
    Qt5::Core
    Qt5::Widgets
)
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