# Older Meson releases cannot use --reconfigure on an unconfigured directory.
set(reconfigure)
if(EXISTS "${HKCF_LIBEI_BUILD}/meson-private/coredata.dat")
  set(reconfigure --reconfigure)
endif()
execute_process(
  COMMAND "${CMAKE_COMMAND}" -E env "CC=${HKCF_CC}"
    "${HKCF_MESON}" setup ${reconfigure} "${HKCF_LIBEI_BUILD}" "${HKCF_LIBEI_SOURCE}"
    --buildtype=release --default-library=static -Db_staticpic=true -Db_ndebug=false
    -Dtests=disabled -Ddocumentation=[] -Dliboeffis=disabled
    -Dlibeis=enabled -Dlibei=${HKCF_LIBEI_CLIENT}
  RESULT_VARIABLE result)
if(NOT result EQUAL 0)
  message(FATAL_ERROR "Bundled libei configuration failed (${result})")
endif()
