# DCMTK
find_package(DCMTK REQUIRED)
include_directories(${DCMTK_INCLUDE_DIRS})
# LIBRARIES
list(
    APPEND
    PROJECT_LIBRARY
    ${DCMTK_LIBRARIES}
)