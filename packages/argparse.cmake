# ------------------------------------------------------------------------------
# argparse
set(ARGPARSE_VER "v0.7.1-6-gee2addf")
ExternalProject_Add(argparse
  PREFIX ${PROJECT_NAME}/argparse
  GIT_REPOSITORY https://github.com/OneLuaPro/argparse.git
  GIT_TAG ${ARGPARSE_VER}
  GIT_PROGRESS FALSE
  CMAKE_ARGS "-DLUA_HINTS=${ONELUAPRO_BUILDROOT}"
  "-DCMAKE_INSTALL_PREFIX=${ONELUAPRO_PREFIX}"
)
ExternalProject_Add_StepDependencies(argparse build lua)

# The explicit order for the argparse manual
set(ARGPARSE_RST_SOURCES
    "index.rst"
    "arguments.rst"
    "options.rst"
    "parsers.rst"
    "callbacks.rst"
    "commands.rst"
    "defaults.rst"
    "messages.rst"
    "mutexes.rst"
    "misc.rst"
    "completions.rst"
)

# Assuming argparse is cloned into: ${CMAKE_BINARY_DIR}/OneLuaPro/argparse/src/argparse
set(ARGPARSE_SRC_DIR "${CMAKE_BINARY_DIR}/OneLuaPro/argparse/src/argparse")
set(ARGPARSE_DOC_OUT "${ONELUAPRO_PREFIX}/share/doc/argparse")
ExternalProject_Add_Step(argparse generate_html_doc
  COMMAND ${CMAKE_COMMAND} -E make_directory "${ARGPARSE_DOC_OUT}"
  COMMAND pandoc ${ARGPARSE_RST_SOURCES}
  -f rst -t html5 -s
  --toc --toc-depth=2
  --css=../assets/oneluapro.css
  --metadata title=argparse
  -o "${ARGPARSE_DOC_OUT}/index.html"
  WORKING_DIRECTORY "${ARGPARSE_SRC_DIR}/docsrc"
  COMMENT "Merging and converting argparse RST documents"
  DEPENDEES install
)

# Help Center registration
set_property(GLOBAL APPEND PROPERTY ONELUAPRO_DOC_LIST 
    "argparse;argparse/index.html;Command Line Parser;🛠️;Development Tools;${ARGPARSE_VER}"
)
