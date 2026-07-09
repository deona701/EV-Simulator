cmake_minimum_required(VERSION 3.16)

project(ev_simulator VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.10)

# Content of downloaded design from Figma to Qt or similar
if (EXISTS "${CMAKE_CURRENT_LIST_DIR}/importedcontent/CMakeLists.txt")
    add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/importedcontent)
endif()

qt_add_executable(appev_simulator
    main.cpp
)
# Tell CMake to strip the "ui/" prefix inside the QML module registry
set_source_files_properties(ui/Main.qml PROPERTIES
    QT_RESOURCE_ALIAS "Main.qml"
)

qt_add_qml_module(appev_simulator
    URI ev_simulator
    VERSION 1.0
    QML_FILES
        ui/Main.qml
    SOURCES
        backend/vehiclesimulator.h
        backend/vehiclesimulator.cpp
        QML_FILES ui/SpeedCard.qml
        QML_FILES ui/BatteryCard.qml
        QML_FILES ui/CenterScreen.qml
        QML_FILES ui/VolumeSlider.qml
        QML_FILES ui/Temperature.qml
        QML_FILES ui/Seats.qml
        QML_FILES ui/Settings.qml
)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
set_target_properties(appev_simulator PROPERTIES
#    MACOSX_BUNDLE_GUI_IDENTIFIER com.example.appev_simulator
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_include_directories(appev_simulator PRIVATE backend)

target_link_libraries(appev_simulator
    PRIVATE Qt6::Quick
)

install(TARGETS appev_simulator
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
