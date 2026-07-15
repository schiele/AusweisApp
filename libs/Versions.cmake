function(SET_HASH _var)
	if(NOT ${_var}_HASH_${${_var}})
		message(FATAL_ERROR "Hash value not defined for ${_var}: ${${_var}}")
	endif()
	set(${_var}_HASH ${${_var}_HASH_${${_var}}} PARENT_SCOPE)
endfunction()

######################################## Qt
if(NOT DEFINED QT)
	set(QT 6.10.2)
	set(QT_PATCHES ON)
endif()

if(NOT QT_HASH)
	set(QT_HASH_6.10.2 c3df0f0e421130cc52ed81cb712358804471ce9bd2a41d97828f9f5b1bf7fed2)

	SET_HASH(QT)
endif()



######################################## OpenSSL
if(NOT DEFINED OPENSSL)
	set(OPENSSL 3.6.3)
	set(OPENSSL_PATCHES ON)
endif()

if(NOT OPENSSL_HASH)
	set(OPENSSL_HASH_1.1.1w cf3098950cb4d853ad95c0841f1f9c6d3dc102dccfcacd521d93925208b76ac8)
	set(OPENSSL_HASH_3.0.21 617e29af8e421f46649484a4937e48c685e47f46488167c982f88bc4ec1d522f)
	set(OPENSSL_HASH_3.5.7 a8c0d28a529ca480f9f36cf5792e2cd21984552a3c8e4aa11a24aa31aeac98e8)
	set(OPENSSL_HASH_3.6.3 243a86649cf6f23eeb6a2ff2456e09e5d77dd9018a54d3d96b0c6bdd6ba6c7f1)
	set(OPENSSL_HASH_4.0.1 2db3f3a0d6ea4b59e1f094ace2c8cd536dffb87cdc39084c5afa1e6f7f37dd09)

	SET_HASH(OPENSSL)
endif()



######################################## llhttp
if(NOT DEFINED LLHTTP)
	set(LLHTTP 9.4.2)
	set(LLHTTP_PATCHES ON)
endif()

if(NOT LLHTTP_HASH)
	set(LLHTTP_HASH_9.4.2 ba717a2f99f340a0ee9796aaf2b1acca057e1e37682ffd2bc4def4d3b6bc4005)

	SET_HASH(LLHTTP)
endif()
