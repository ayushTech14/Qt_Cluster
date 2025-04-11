cmake_minimum_required(VERSION 3.16)

project(Qt_Cluster VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find the Qt Quick module
find_package(Qt6 REQUIRED COMPONENTS Quick)

# Set up Qt project settings
qt_standard_project_setup(REQUIRES 6.5)

# Add executable for the app
qt_add_executable(appQt_Cluster
    main.cpp
)

# Add QML module and link the resources (Main.qml and resource.qrc)
qt_add_qml_module(appQt_Cluster
    URI Qt_Cluster
    VERSION 1.0
    QML_FILES
        Main.qml
    RESOURCES
        resource.qrc
        SOURCES tcpclient.h tcpclient.cpp
)

# Configure for macOS and Windows
set_target_properties(appQt_Cluster PROPERTIES
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# Link Qt Quick library
target_link_libraries(appQt_Cluster
    PRIVATE Qt6::Quick
)

# Installation settings
include(GNUInstallDirs)
install(TARGETS appQt_Cluster
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
