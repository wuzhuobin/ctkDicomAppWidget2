# @file	    FindITK.cmake
# @brief	CMake script for find ITK.
# @author	WUZHUOBIN
# @version	1.0
# @since	Aug.23.2018
# @date 	Aug.23.2018
# @log
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#			Copyright (c) WUZHUOBIN 											    #
#			All rights reserved.												    #
#			See Copyright.txt													    #
#			This software is distributed WITHOUT ANY WARRANTY; without even		    #
#			the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR	    #
#			PURPOSE.  See the above copyright notice for more information.		    #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
IF(NOT ITK_FOUND)
	# ITK
	find_package(ITK REQUIRED)
	# LIBRARIES
	list(
	    APPEND
	    PROJECT_LIBRARY
	    ${ITK_LIBRARIES}
	)
ENDIF()
include(${ITK_USE_FILE})
