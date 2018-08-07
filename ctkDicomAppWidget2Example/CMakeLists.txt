# @file	CMakeLists.txt
# @brief	A CMakeLists.txt which can automatically generate project
# @author	WUZHUOBIN
# @version	0.0.0
# @since	Aug.06.2018
# @date 	Aug.06.2018
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#			Copyright (c) WUZHUOBIN 											    #
#			All rights reserved.												    #
#			See Copyright.txt													    #
#			This software is distributed WITHOUT ANY WARRANTY; without even		    #
#			the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR	    #
#			PURPOSE.  See the above copyright notice for more information.		    #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
cmake_minimum_required(VERSION 3.1) 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
get_filename_component(
	FOLDER_NAME 
	${CMAKE_CURRENT_SOURCE_DIR} 
	NAME
)
project(${FOLDER_NAME})
message(
	STATUS 
	"CONFIGURING ${PROJECT_NAME}..."
)
# multi-processor build
if(${MSVC})
	set(
		CMAKE_CXX_FLAGS 
		"${CMAKE_CXX_FLAGS} /MP"
	)
	set(
		CMAKE_C_FLAGS
		"${CMAKE_C_FLAGS} /MP"
	)
endif()
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # POLICY  # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# # # # # # # # # # # # # # # # # CHANGE BELOW  # # # # # # # # # # # # # # # # 

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # SUB_DIRECTORY # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # OPTIONS # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# Allow the developer to build example.
option(BUILD_EXAMPLE "Build Example" OFF)
if(BUILD_EXAMPLE AND EXISTS ${PROJECT_SOURCE_DIR}/${PROJECT_NAME}Example)
	add_subdirectory(${PROJECT_SOURCE_DIR}/${PROJECT_NAME}Example)
endif()
# Allow the developer to do testing or not.
option(BUILD_TESTING "Build Testing" OFF)
# Allow the developer to build documentation.
option(BUILD_DOCUMENTATION "Bulid Documentation" OFF)
# Allow the developer to select if Dynamic or Static libraries are built
option(BUILD_SHARED_LIBS "Build Shared Libraries" OFF)
if(BUILD_SHARED_LIBS)
# User wants to build Dynamic Libraries, so change the LIB_TYPE variable to CMake keyword 'SHARED'
	set(LIB_TYPE SHARED)
else()
# Set the LIB_TYPE variable to STATIC
	set(LIB_TYPE STATIC)
endif()
# Set output location of shared/module libraries. 
set(
	CMAKE_ARCHIVE_OUTPUT_DIRECTORY
	${CMAKE_BINARY_DIR}/lib
)
# Set output location of shared/static libraries. 
set(
	CMAKE_LIBRARY_OUTPUT_DIRECTORY
	${CMAKE_BINARY_DIR}/lib
)
# Set output location of shared libraries and executables. 
set(
	CMAKE_RUNTIME_OUTPUT_DIRECTORY 
	${CMAKE_BINARY_DIR}/bin
)
link_directories(
	${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}
	${CMAKE_LIBRARY_OUTPUT_DIRECTORY}
)
set(
	PROJECT_LIBRARY
	${PROJECT_LIBRARY}
)
set(
	PROJECT_INCLUDE
	${PROJECT_SOURCE_DIR}
	${PROJECT_BINARY_DIR}
)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  
# # # # # # # # # # # # # # # # # CODES # # # # # # # # # # # # # # # # # # # #  
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  
# Finding needed source files.
file(
	GLOB
	PROJECT_SRC
	${PROJECT_SOURCE_DIR}/*.c*
)
# Finding needed header files.
file(
	GLOB
	PROJECT_INC
	${PROJECT_SOURCE_DIR}/*.h*
)
# Finding needed build executable source files.
file(
	GLOB
	PROJECT_MAIN_SRC
	${PROJECT_SOURCE_DIR}/main/*.c*
)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # DEPENDENCY  # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Finding needed Find*.cmake files.
file(
	GLOB
	PROJECT_FIND_CMAKE
	${PROJECT_SOURCE_DIR}/cmake/Find*.cmake
)
# Include every Find*.cmake file in cmake folder. 
foreach(ONE ${PROJECT_FIND_CMAKE})
	include(${ONE})
endforeach()
# For shared libraries export 
include(GenerateExportHeader)
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  
# # # # # # # # # # # # # # # # # LIBRARIES # # # # # # # # # # # # # # # # # #  
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  

# # # # # # # # # # # # # # # # # BUILD LIBRARY # # # # # # # # # # # # # # # #  
# Enable always build static library
# set(LIB_TYPE STATIC)
if(PROJECT_SRC)
	add_library(
		${PROJECT_NAME}
		${LIB_TYPE}
		${PROJECT_SRC}
		${PROJECT_INC}
	)
endif()
# # # # # # # # # # # # # # # # # BUILD EXECUTABLE # # # # # # # # # # # # # # 
if(PROJECT_MAIN_SRC)
	add_executable(
		${PROJECT_NAME}_main
		${PROJECT_MAIN_SRC}
	)
endif()
# # # # # # # # # # # # # # # # # BUILD OTHERS # # # # # # # # # # # # # # # #
# Finding needed Targget*.cmake files.
file(
	GLOB
	PROJECT_TARGET_CMAKE
	${PROJECT_SOURCE_DIR}/cmake/Target*.cmake
)
# Include every Target*.cmake file in cmake folder. 
foreach(ONE ${PROJECT_TARGET_CMAKE})
	include(${ONE})
endforeach()
# # # # # # # # # # # # # # # # # LINKAGE # # # # # # # # # # # # # # # # # # # 
# Adding a prefix for exporting target
foreach(ONE ${PROJECT_INCLUDE})
	list(
		APPEND
		TEMPORARY_PROJECT_INCLUDE 
		$<BUILD_INTERFACE:${ONE}>)
endforeach()
set(PROJECT_INCLUDE ${TEMPORARY_PROJECT_INCLUDE})
if(TARGET ${PROJECT_NAME})
	include(GenerateExportHeader)
	generate_export_header(${PROJECT_NAME})
	target_link_libraries(
	    ${PROJECT_NAME}
		${PROJECT_LIBRARY}
	)
	target_include_directories(
		${PROJECT_NAME}
		PUBLIC
		${PROJECT_INCLUDE}
		$<INSTALL_INTERFACE:include>  
	)
	list(
		APPEND
		PROJECT_LIBRARY 
		${PROJECT_NAME}
	)
endif()
if(TARGET ${PROJECT_NAME}_main)
	target_link_libraries(
		${PROJECT_NAME}_main
		${PROJECT_LIBRARY}
	)
	target_include_directories(
		${PROJECT_NAME}_main
		PUBLIC
		${PROJECT_INCLUDE}
	)
endif()
# # # # # # # # # # # # # # # # # EXPORT # # # # # # # # # # # # # # # # # # # # # 
# installation to be continue.
# comment following for normal source project
if(TARGET ${PROJECT_NAME})
	install(
		TARGETS ${PROJECT_NAME}
		EXPORT ${PROJECT_NAME} 
		RUNTIME DESTINATION bin
		LIBRARY DESTINATION lib
		ARCHIVE DESTINATION lib
		INCLUDES DESTINATION include
	)
	export(
		EXPORT
		${PROJECT_NAME}
		FILE
		${CMAKE_BINARY_DIR}/lib/cmake/${PROJECT_NAME}.cmake
	)
	install(
		FILES 
		${PROJECT_BINARY_DIR}/${PROJECT_NAME}_export.h
		${PROJECT_INC}
		DESTINATION
		include
	)
	install(
		EXPORT ${PROJECT_NAME}
		DESTINATION lib/cmake
	)
endif()
message(
	STATUS 
	"CONFIGURED ${PROJECT_NAME}"
)