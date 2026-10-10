# ------------------------------------------------------------------------------
# PackageSelection.cmake - pick the package files for a partial superbuild
#
#   olp_select_packages(FILES <var> TARGETS <var> [ONLY <name>...])
#
#   FILES    in/out  List of package files (packages/*.cmake). Reduced to the
#                    selected files if ONLY is given.
#   TARGETS  out     The ExternalProject targets that the (selected) files define.
#   ONLY     Names to build: package names (file name without ".cmake") or target
#            names. They are matched exactly first, then case-insensitively.
#            The names may be separated by ';' or ','. The selection contains
#            the named packages and everything they depend on, transitively.
#            An unknown name or a dependency that no package defines is a
#            FATAL_ERROR. Without ONLY nothing is filtered.
#
# How it works: every package file is scanned as text (comments removed) for
#   ExternalProject_Add(<target> ...)           -> which targets a file defines
#   add_dependencies(<target> <dependency>...)  -> which targets it depends on
# Dependencies are read per file, so the granularity of a selection is the file:
# a file with several targets (azure-sdk-cpp.cmake) is included as a whole.
# Limits of the text scan: both commands must be written as above (exact spelling
# of the command names, a literal target name). Names containing ${...} or $<...>
# cannot be resolved and are reported as a warning.
#
# Dry run, without configuring anything (from the top-level source directory):
#   cmake -DBUILD_ONLY="luasql;duckdb" -P cmake/PackageSelection.cmake
# ------------------------------------------------------------------------------
cmake_policy(VERSION 3.15)

function(olp_select_packages)
  cmake_parse_arguments(ARG "" "FILES;TARGETS" "ONLY" ${ARGN})
  if(NOT ARG_FILES OR NOT ARG_TARGETS)
    message(FATAL_ERROR "olp_select_packages: FILES and TARGETS must be given")
  endif()
  set(all_files ${${ARG_FILES}})

  # ----------------------------------------------------------------------------
  # 1. Scan all package files
  set(pkg_list "")
  foreach(file IN LISTS all_files)
    get_filename_component(pkg "${file}" NAME_WE)
    list(APPEND pkg_list "${pkg}")
    set(_olp_pkgfile_${pkg} "${file}")
    string(TOLOWER "${pkg}" lc)
    set(_olp_lc_${lc} "${pkg}")

    file(READ "${file}" content)
    # remove comments (only in this scan copy)
    string(REGEX REPLACE "#[^\n]*" "" content "${content}")

    # targets defined by this file
    set(targets "")
    string(REGEX MATCHALL "ExternalProject_Add[ \t]*\\([ \t\r\n]*[^ \t\r\n)]+"
           ep_calls "${content}")
    foreach(call IN LISTS ep_calls)
      string(REGEX REPLACE "^ExternalProject_Add[ \t]*\\([ \t\r\n]*" "" tgt "${call}")
      if(tgt MATCHES "[$]")
        message(WARNING "PackageSelection: cannot resolve the target name '${tgt}' in ${file}")
        continue()
      endif()
      if(DEFINED _olp_targetpkg_${tgt})
        message(WARNING "PackageSelection: target '${tgt}' is defined by '${_olp_targetpkg_${tgt}}' and '${pkg}'")
      endif()
      list(APPEND targets "${tgt}")
      set(_olp_targetpkg_${tgt} "${pkg}")
      string(TOLOWER "${tgt}" lc)
      if(NOT DEFINED _olp_lc_${lc})
        set(_olp_lc_${lc} "${pkg}")
      endif()
    endforeach()
    set(_olp_pkgtargets_${pkg} "${targets}")

    # dependencies declared by this file (all add_dependencies calls in it)
    set(_olp_filedeps_${pkg} "")
    string(REGEX MATCHALL "add_dependencies[ \t]*\\([^)]*\\)" dep_calls "${content}")
    foreach(call IN LISTS dep_calls)
      string(REGEX REPLACE "^add_dependencies[ \t]*\\([ \t\r\n]*" "" args "${call}")
      string(REGEX REPLACE "[ \t\r\n]*\\)$" "" args "${args}")
      string(REGEX REPLACE "[ \t\r\n]+" ";" args "${args}")
      list(POP_FRONT args tgt)           # the first argument is the dependent target
      foreach(dep IN LISTS args)
        if(dep STREQUAL "")
          continue()
        endif()
        if(dep MATCHES "[$]")
          message(WARNING "PackageSelection: cannot resolve the dependency '${dep}' in ${file}")
          continue()
        endif()
        list(APPEND _olp_filedeps_${pkg} "${dep}")
      endforeach()
    endforeach()
  endforeach()

  # ----------------------------------------------------------------------------
  # 2. Select
  set(only ${ARG_ONLY})
  string(REPLACE "," ";" only "${only}")
  if(only)
    set(requested "")
    foreach(name IN LISTS only)
      set(found "")
      string(TOLOWER "${name}" lc)
      if(DEFINED _olp_pkgfile_${name})
        set(found "${name}")
      elseif(DEFINED _olp_targetpkg_${name})
        set(found "${_olp_targetpkg_${name}}")
      elseif(DEFINED _olp_lc_${lc})
        set(found "${_olp_lc_${lc}}")
      endif()
      if(found STREQUAL "")
        list(SORT pkg_list CASE INSENSITIVE)
        string(JOIN "\n  " available ${pkg_list})
        message(FATAL_ERROR "BUILD_ONLY: unknown package '${name}'.\n"
                "Available packages (targets of multi-target packages are accepted as well):\n  ${available}")
      endif()
      list(APPEND requested "${found}")
    endforeach()
    list(REMOVE_DUPLICATES requested)

    # transitive closure over the dependencies
    set(selected "")
    set(queue ${requested})
    list(LENGTH queue qlen)
    while(qlen GREATER 0)
      list(POP_FRONT queue pkg)
      if(NOT pkg IN_LIST selected)
        list(APPEND selected "${pkg}")
        foreach(dep IN LISTS _olp_filedeps_${pkg})
          if(NOT DEFINED _olp_targetpkg_${dep})
            message(FATAL_ERROR "BUILD_ONLY: '${dep}' is a dependency of package '${pkg}', "
                    "but no package file defines a target with that name.")
          endif()
          list(APPEND queue "${_olp_targetpkg_${dep}}")
        endforeach()
      endif()
      list(LENGTH queue qlen)
    endwhile()

    # keep the original order of the files
    set(result "")
    foreach(file IN LISTS all_files)
      get_filename_component(pkg "${file}" NAME_WE)
      if(pkg IN_LIST selected)
        list(APPEND result "${file}")
      endif()
    endforeach()
    set(all_files ${result})

    list(LENGTH selected n_sel)
    list(LENGTH pkg_list n_all)
    set(pulled ${selected})
    list(REMOVE_ITEM pulled ${requested})
    list(SORT pulled CASE INSENSITIVE)
    string(JOIN ", " requested_txt ${requested})
    string(JOIN ", " pulled_txt ${pulled})
    message(STATUS "BUILD_ONLY: ${n_sel} of ${n_all} packages selected")
    message(STATUS "  requested  : ${requested_txt}")
    message(STATUS "  dependencies: ${pulled_txt}")
  endif()

  # ----------------------------------------------------------------------------
  # 3. Results
  set(result_targets "")
  foreach(file IN LISTS all_files)
    get_filename_component(pkg "${file}" NAME_WE)
    list(APPEND result_targets ${_olp_pkgtargets_${pkg}})
  endforeach()
  set(${ARG_FILES} "${all_files}" PARENT_SCOPE)
  set(${ARG_TARGETS} "${result_targets}" PARENT_SCOPE)
endfunction()

# ------------------------------------------------------------------------------
# Dry run: cmake -DBUILD_ONLY="pkg;pkg" [-DPACKAGES_DIR=<dir>] -P PackageSelection.cmake
if(CMAKE_SCRIPT_MODE_FILE)
  get_filename_component(_olp_script "${CMAKE_SCRIPT_MODE_FILE}" REALPATH)
  get_filename_component(_olp_this "${CMAKE_CURRENT_LIST_FILE}" REALPATH)
  if(_olp_script STREQUAL _olp_this)
    if(NOT PACKAGES_DIR)
      set(PACKAGES_DIR "${CMAKE_CURRENT_LIST_DIR}/../packages")
    endif()
    file(GLOB _olp_files "${PACKAGES_DIR}/*.cmake")
    olp_select_packages(FILES _olp_files TARGETS _olp_targets ONLY ${BUILD_ONLY})
    list(LENGTH _olp_files _olp_n)
    message(STATUS "Package files that would be included (${_olp_n}):")
    foreach(_olp_f IN LISTS _olp_files)
      get_filename_component(_olp_p "${_olp_f}" NAME_WE)
      message(STATUS "  ${_olp_p}")
    endforeach()
    message(STATUS "Targets: ${_olp_targets}")
  endif()
endif()
