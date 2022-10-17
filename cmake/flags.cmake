set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD 14)

set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)

if (CMAKE_CXX_COMPILER_ID MATCHES GNU)
	set(GENERAL_FLAGS "-pthread")
	set(WARNING_FLAGS "-Wall -Wextra -Wcast-align -Wcast-qual -Wlogical-op -Wstrict-overflow=2 -Wundef -Wformat=2 -Wpointer-arith -Werror")
	set(OPTIMIZATION_FLAGS "-Ofast -s")

	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${GENERAL_FLAGS} ${WARNING_FLAGS} ${OPTIMIZATION_FLAGS}")
	set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} ${GENERAL_FLAGS} ${WARNING_FLAGS} ${OPTIMIZATION_FLAGS}")

	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GENERAL_FLAGS} ${WARNING_FLAGS} ${OPTIMIZATION_FLAGS}")
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} ${GENERAL_FLAGS} ${WARNING_FLAGS} ${OPTIMIZATION_FLAGS}")

	if (WIN32)
		set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static")
	else()
		if (STATIC_BINARY)
			set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static")
		else()
			set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static-libgcc -static-libstdc++")
		endif()
	endif()
elseif (CMAKE_CXX_COMPILER_ID MATCHES MSVC)
	set(GENERAL_FLAGS "/MP")
	set(WARNING_FLAGS "/Wall /WX /sdl")
	set(SECURITY_FLAGS "/GS /guard:cf")
	set(OPTIMIZATION_FLAGS "/O2 /Oi /Ob2 /Ot /DNDEBUG /GL")

	set(CMAKE_C_FLAGS_DEBUG "${GENERAL_FLAGS} ${WARNING_FLAGS} ${SECURITY_FLAGS} /Od /Ob0 /Zi /MTd /fsanitize=address")
	set(CMAKE_CXX_FLAGS_DEBUG "${GENERAL_FLAGS} ${WARNING_FLAGS} ${SECURITY_FLAGS} /Od /Ob0 /Zi /MTd /fsanitize=address")

	set(CMAKE_C_FLAGS_RELEASE "${GENERAL_FLAGS} ${WARNING_FLAGS} ${SECURITY_FLAGS} ${OPTIMIZATION_FLAGS} /MT")
	set(CMAKE_CXX_FLAGS_RELEASE "${GENERAL_FLAGS} ${WARNING_FLAGS} ${SECURITY_FLAGS} ${OPTIMIZATION_FLAGS} /MT")

	set(CMAKE_C_FLAGS_RELWITHDEBINFO "${GENERAL_FLAGS} ${WARNING_FLAGS} ${SECURITY_FLAGS} /Ob1 /Ot /Zi /MT")
	set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "${GENERAL_FLAGS} ${WARNING_FLAGS} ${SECURITY_FLAGS} /Ob1 /Ot /Zi /MT")
elseif (CMAKE_CXX_COMPILER_ID MATCHES Clang)
	set(GENERAL_FLAGS "-pthread")
	set(WARNING_FLAGS "-Wall -Wextra -Wno-undefined-internal -Wunreachable-code-aggressive -Wmissing-prototypes -Wmissing-variable-declarations -Werror")
	set(OPTIMIZATION_FLAGS "-Ofast -funroll-loops -fmerge-all-constants")

	set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${GENERAL_FLAGS} ${WARNING_FLAGS} ${OPTIMIZATION_FLAGS}")
	set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} ${GENERAL_FLAGS} ${WARNING_FLAGS} ${OPTIMIZATION_FLAGS}")

	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${GENERAL_FLAGS} ${WARNING_FLAGS} ${OPTIMIZATION_FLAGS}")
	set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} ${GENERAL_FLAGS} ${WARNING_FLAGS} ${OPTIMIZATION_FLAGS}")
endif()
