cmake_minimum_required(VERSION 3.16)

project(ev_simulator VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_PREFIX_PATH "/home/d701/Qt/6.11.1/gcc_64")
find_package(Qt6 REQUIRED COMPONENTS Quick)

find_package(Qt6 REQUIRED COMPONENTS
    Quick
    Positioning
    Location
    Multimedia
)

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
        ui/SpeedCard.qml
        ui/BatteryCard.qml
        ui/CenterScreen.qml
        ui/VolumeSlider.qml
        ui/Temperature.qml
        ui/Seats.qml
        ui/Settings.qml
    SOURCES
        backend/vehiclesimulator.h
        backend/vehiclesimulator.cpp
        RESOURCES
            assets-music/audioknap-industrial-516087.mp3
            assets-music/mondamusic-synthwave-572999.mp3
            assets-music/monume-cyberpunk-519219.mp3
            assets-music/psychronic-interstellar-dance-520116.mp3
            assets-music/turtlebeats-dark-synthwave-black-neon-251690.mp3
            assets-music/turtlebeats-dark-synthwave-spectral-251688.mp3
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
    Qt6::Positioning
    Qt6::Location
    Qt6::Multimedia
)

install(TARGETS appev_simulator
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
