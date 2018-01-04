# @file	TemplateCMakeLists.txt
# @brief	A template CMakeLists.txt which can automatically generate project
# @author	WUZHUOBIN
# @version	1.4.0
# @since	Sep.19.2017
# 
# This template is for generating CMake project easily. Only a few steps.
# 1.	Make a good folder name as the parent, because it is going to be your 
#		CMake Project name. 
# 2.	Place all header files and implementation files to your parent folder. 
#		If there is no header files and implementation files, skip this part. 
# 3.	Create a folder "main" to place your main function. It has to be named 
#		as "name.cpp". If there is no or a library is being created, skip this 
#		part. 
# 4.	Rename "TemplateCMakeLists.txt" to "CMakeLists.txt". 
# 
# Update Log: 
# @date	Sep.19.2017
# version 1.0.0
# The first version. 
#
# @date	Sep.20.2017
# version 1.1.0
# Adding some comments
#
# @date Sep.27.2017
# version 1.2.0
# Adding recursive copying dll. Adding recursive copying lib. Adding some messages.
#
# @date	Sep.28.2017
# version 1.3.0
# Globe in main as well. Removing bugs. Complete install function.
# Adding CMakeListsConfig.cmake.in. Updating using buld in qrc. 
#
# @date Oct.10.2017
# version 1.4.0
# Fix bugs of ${SYSTEM_INCLUDE}, every element in it should has format like  
# $<BUILD_INTERFACE:${...}>
#
# @date Dec.08.2017
# version 1.5.0
# Removing qt5_add_traslation. Try to do this with custom command later instead of 
# in library layer.
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
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
get_filename_component(
	FOLDER_NAME 
	${CMAKE_CURRENT_SOURCE_DIR} 
	NAME
)
project(${FOLDER_NAME})

message(
	STATUS 
	"Building submodule ${PROJECT_NAME}..."
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
cmake_policy(SET CMP0043 NEW)
cmake_policy(SET CMP0028 NEW)
# # # # # # # # # # # # # # # # # CHANGE BELOW  # # # # # # # # # # # # # # # # 


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # DEPENDENCY  # # # # # # # # # # # # # # # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Adding dependency library you need
# Please remember to set it to SYSTEM_LIBRARIES as well 

# ITK
find_package(ITK REQUIRED)
include(${ITK_USE_FILE})

# VTK
find_package(VTK REQUIRED) 
include(${VTK_USE_FILE})

# QT
find_package(Qt5Core REQUIRED)
find_package(Qt5Widgets REQUIRED)
# # # # # # # # # # # # # # # # # CHANGE BELOW  # # # # # # # # # # # # # # # # 
#find_package(Qt5.... REQUIRED)
find_package(Qt5Sql REQUIRED)
find_package(Qt5Xml REQUIRED)
#find_package(... REQURIED)

# OTHERS
#find_package()
#....

# CTK
find_package(CTK REQUIRED)
include(${CTK_USE_FILE})

# WINDOWS RESOURCE
# set(
# 	WINDOWS_RESOURCE
# 	# PATH
# )



# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  
# # # # # # # # # # # # # # # # # LIBRARIES # # # # # # # # # # # # # # # # # #  
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  

# Allow the developer to select if Dynamic or Static libraries are built
option (BUILD_SHARED_LIBS "Build Shared Libraries" OFF)
# Set the LIB_TYPE variable to STATIC
set (LIB_TYPE STATIC)
if (BUILD_SHARED_LIBS)
	# User wants to build Dynamic Libraries, so change the LIB_TYPE variable to CMake keyword 'SHARED'
	set (LIB_TYPE SHARED)
endif (BUILD_SHARED_LIBS)

set(
	CMAKE_ARCHIVE_OUTPUT_DIRECTORY
	${CMAKE_BINARY_DIR}/lib
)

set(
	CMAKE_LIBRARY_OUTPUT_DIRECTORY
	${CMAKE_BINARY_DIR}/lib
)
set(
	CMAKE_RUNTIME_OUTPUT_DIRECTORY 
	${CMAKE_BINARY_DIR}/bin
)

# copying external dll to executable path
if(${WIN32})
	# copy dll 
	file(
		GLOB_RECURSE
		SYSTEM_DLL
		${PROJECT_SOURCE_DIR}/*.dll
	)
	if(${MSVC})
		file(
			COPY
			${SYSTEM_DLL}
			DESTINATION
			${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/Release
		)

		file(
			COPY
			${SYSTEM_DLL}
			DESTINATION
			${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/Debug
		)
	else()
		file(
			COPY
			${SYSTEM_DLL}
			DESTINATION
			${CMAKE_RUNTIME_OUTPUT_DIRECTORY}
		)
	endif()

	message(
		STATUS
		"Copying Dll...\n"
		"FROM ${SYSTEM_DLL}\n"
		"TO ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}"
	)

endif()

link_directories(
	${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}
	${CMAKE_LIBRARY_OUTPUT_DIRECTORY}
)

set(
	SYSTEM_LIBRARIES
	${VTK_LIBRARIES} 
	${ITK_LIBRARIES}
	Qt5::Core
	Qt5::Widgets
)

# find all external lib in the current folder recursively
if(${WIN32})
	file(
		GLOB_RECURSE
		EXTERNAL_LIBRARIES
		${PROJECT_SOURCE_DIR}/*.lib
	)
	if(${MSVC})
		file(
			COPY
			${EXTERNAL_LIBRARIES}
			DESTINATION
			${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/Release
		)

		file(
			COPY
			${EXTERNAL_LIBRARIES}
			DESTINATION
			${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}/Debug
		)
	else()
		file(
			COPY
			${EXTERNAL_LIBRARIES}
			DESTINATION
			${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}
		)
	endif()
	
	foreach(LIB_NAME ${EXTERNAL_LIBRARIES})
		
		get_filename_component(
			LIB_NAME
			${LIB_NAME}
			NAME
		)

		set(
			SYSTEM_LIBRARIES
			${SYSTEM_LIBRARIES}
			${LIB_NAME}
		)
	endforeach()
endif()

set(
	SYSTEM_INCLUDE
	${PROJECT_SOURCE_DIR}
)

# # # # # # # # # # # # # # # # # CHANGE BELOW  # # # # # # # # # # # # # # # # 
set(
	SYSTEM_LIBRARIES
	${SYSTEM_LIBRARIES}
	#OTHERS
	Qt5::Sql
	Qt5::Xml
	${CTK_LIBRARIES}
	#...
	# opengl32
	# comctl32
	# wsock32
	# odbc32
	# odbccp32
	# legacy_stdio_definitions
)

set(
	SYSTEM_INCLUDE
	${SYSTEM_INCLUDE}
	# ${PROJECT_SOURCE_DIR}/Dist64
	# ${PROJECT_SOURCE_DIR}/FL
	#....
)


# Enable always build static library
# set(LIB_TYPE STATIC)


# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  
# # # # # # # # # # # # # # # # # CODES # # # # # # # # # # # # # # # # # # # #  
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #  


# # # # # # # # # # # # # # # # # BUILD LIBRARY # # # # # # # # # # # # # # # #  
file(GLOB PROJECT_QRC *.qrc)
file(GLOB PROJECT_SRC *.c*)
file(GLOB PROJECT_INC *.h*)
file(GLOB PROJECT_UI *.ui)

# Output UI headers to specified location
qt5_wrap_ui(
	PROJECT_UI_H
	${PROJECT_UI}
)

qt5_wrap_cpp(
    PROJECT_MOC
    ${PROJECT_INC}
)

qt5_add_resources(
	PROJECT_QRC_SRC
	${PROJECT_QRC}
)

# Adding a prefix for exporting target
foreach(ONE_INCLUDE ${SYSTEM_INCLUDE})
	set(TEMPORARY_SYSTEM_INCLUDE ${TEMPORARY_SYSTEM_INCLUDE} $<BUILD_INTERFACE:${ONE_INCLUDE}>)
endforeach()

set(SYSTEM_INCLUDE ${TEMPORARY_SYSTEM_INCLUDE})

# Building library
if( NOT "${PROJECT_SRC}" STREQUAL "")

	add_library(
	    ${PROJECT_NAME}
		${LIB_TYPE}
	    ${PROJECT_SRC}
	    ${PROJECT_INC}
	    ${PROJECT_MOC}
		${PROJECT_UI}
		${PROJECT_UI_H}
		${PROJECT_QRC}
		${PROJECT_QRC_SRC}
	)

	include(GenerateExportHeader)
	generate_export_header(${PROJECT_NAME})

	target_link_libraries(
	    ${PROJECT_NAME}
		${SYSTEM_LIBRARIES}
	)

	message(
		STATUS
		"Linking Libraries\n"
		"${SYSTEM_LIBRARIES}"
	)

	target_include_directories(
		${PROJECT_NAME}
		PUBLIC
		$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}>
		${SYSTEM_INCLUDE}
		$<INSTALL_INTERFACE:include>  
	)

	message(
		STATUS
		"Include directory\n"
		"${SYSTEM_INCLUDE}"
		"$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}>"
	
	)
	

	# installation to be continue.
	# comment following for normal source project

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

	configure_file(
		CMakeListsConfig.cmake.in
		${CMAKE_BINARY_DIR}/lib/cmake/${PROJECT_NAME}-config.cmake
		@ONLY
	)

	install(
		FILES 
		${PROJECT_BINARY_DIR}/${PROJECT_NAME}_export.h
		${PROJECT_INC}
		${PROJECT_UI_H}
		DESTINATION
		include
	)
	
	install(
		EXPORT ${PROJECT_NAME}
		DESTINATION lib/cmake
	)

	install(
		FILES
		${CMAKE_BINARY_DIR}/lib/cmake/${PROJECT_NAME}-config.cmake
		DESTINATION
		lib/cmake
	)
	
endif()

# # # # # # # # # # # # # # # # BUILD EXE # # # # # # # # # # # # # # # # # # #  
file(GLOB MAIN_PROJECT_QRC main/*.qrc)
file(GLOB MAIN_PROJECT_SRC main/*.c*)
file(GLOB MAIN_PROJECT_INC main/*.h*)
file(GLOB MAIN_PROJECT_UI main/*.ui)

# Output UI headers to specified location
qt5_wrap_ui(
	MAIN_PROJECT_UI_H
	${MAIN_PROJECT_UI}
)

qt5_wrap_cpp(
    MAIN_PROJECT_MOC
    ${MAIN_PROJECT_INC}
)

qt5_add_resources(
	MAIN_PROJECT_QRC_SRC
	${MAIN_PROJECT_QRC}
)

if( NOT "${MAIN_PROJECT_SRC}" STREQUAL "")

	if(NOT "${PROJECT_SRC}" STREQUAL "")

		add_executable(
			${PROJECT_NAME}_main
			${MAIN_PROJECT_SRC}
			${MAIN_PROJECT_MOC}
			${MAIN_PROJECT_INC}
			${MAIN_PROJECT_UI}
			${MAIN_PROJECT_UI_H}
			${MAIN_PROJECT_QRC}
			${MAIN_PROJECT_QRC_SRC}
			${WINDOWS_RESOURCE}

		)

		target_link_libraries(
			${PROJECT_NAME}_main
			${PROJECT_NAME}
		)

	else()

		add_executable(
			${PROJECT_NAME}_main
			${MAIN_PROJECT_SRC}
			${MAIN_PROJECT_MOC}
			${MAIN_PROJECT_INC}
			${MAIN_PROJECT_UI}
			${MAIN_PROJECT_UI_H}
			${MAIN_PROJECT_QRC}
			${MAIN_PROJECT_QRC_SRC}
			${PROJECT_QRC}
			${PROJECT_QRC_SRC}
			${WINDOWS_RESOURCE}
		)

		target_link_libraries(
			${PROJECT_NAME}_main
			${SYSTEM_LIBRARIES}
		)

		target_include_directories(
			${PROJECT_NAME}_main
			PUBLIC
			${PROJECT_BINARY_DIR}
			${SYSTEM_INCLUDE}
		)

	endif()

endif()


#Grouping in MSVC
source_group(
	"Generated Files"
	FILES
	${PROJECT_MOC}
	${PROJECT_UI_H}
	${MAIN_PROJECT_MOC}
	${MAIN_PROJECT_UI_H}
	${PROJECT_QRC_SRC}
	${MAIN_PROJECT_QRC_SRC}
)
source_group(
	"Forms Files"
	FILES
	${PROJECT_UI}
	${MAIN_PROJECT_UI}
)
source_group(
	"Header Files" 
	FILES 
	${PROJECT_INC}
	${MAIN_PROJECT_INC}
)
source_group(
	"Source Files" 
	FILES 
	${PROJECT_SRC}
	${MAIN_PROJECT_SRC}
)

MESSAGE(STATUS "Building submodule ${PROJECT_NAME} finished!")


