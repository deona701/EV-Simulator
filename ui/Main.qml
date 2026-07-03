import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import ev_simulator
import QtQuick.Shapes 1.15

Window {
    // Core Color Palette
    property color bgPrimary: "#0a0b0e"
    property color accentNormal: "#00ffff"
    property color accentSport: "#e43131"
    property color accentEco: "#04FF00"
    property color textNeutral: "#ffffff"

    // Active Color (Switches based on mode)
    property color currentAccent: {
        if (vehicle.driveMode === VehicleSimulator.Eco) return accentEco;
        if (vehicle.driveMode === VehicleSimulator.Sport) return accentSport;
        return accentNormal;
    }

    id: root
    width: 1920
    height: 720
    visible: true
    title: "EV Simulator"
    color: bgPrimary

    VehicleSimulator {
        id: vehicle
    }

    Row {
        anchors.fill: parent
        anchors.margins: 25
        spacing: 25

        // LEFT ZONE (Speed & Motion) - 30% of the screen
        Rectangle {
            width: (parent.width - 50) * 0.3
            height: parent.height
            color: "transparent"

            Column {
                anchors.fill: parent
                spacing: 25
                topPadding: 20

            // SPEED CARD
            Rectangle {
                width: parent.width * 0.85
                height: parent.height * 0.52
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 30
                color: bgPrimary
                border.color: currentAccent
                border.width: 2

            // Speedometer Circle Shape
            Rectangle {
                width: 300
                height: 300
                radius: 150
                anchors.centerIn: parent

                color: "transparent"
                border.color: currentAccent
                border.width: 4

                // Speedometer Ticks
                Repeater {
                    model: 12

                    Rectangle {
                    width: 2
                    height: 150
                    color: "transparent"
                    anchors.bottom: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    transformOrigin: Item.Bottom
                    rotation: -110 + (index * 20)

                    Rectangle {
                        width: 2
                        height: 10
                        color: currentAccent
                        anchors.top: parent.top                        }
                    }
                }
            }
                // Speedometer Needle
                Rectangle {
                    width: 4
                    height: 120
                    color: currentAccent
                    anchors.bottom: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    transformOrigin: Item.Bottom
                    rotation: vehicle.speed - 110

                    Behavior on rotation {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.OutQuad
                        }
                    }
                }

                // Speedometer Speed Value
                Text {
                    text: Math.round(vehicle.speed)
                    color: currentAccent
                    font.pixelSize: 34
                    font.bold: true

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 45
                }
            }

            // BATTERY CARD
            Rectangle {
                width: parent.width * 0.85
                height: parent.height * 0.38
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 30
                color: bgPrimary
                border.color: currentAccent
                border.width: 2
                }
            }
        }


        // CENTER ZONE (Road & Environment) - 40%
        Rectangle {
            width: (parent.width - 50) * 0.4
            height: parent.height
            color: bgPrimary

            Column {
                anchors.fill: parent
                spacing: 25
                topPadding: 20

            // MAIN SCREEN
            Rectangle {
                width: parent.width * 1
                height: parent.height * 0.62
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 30
                color: bgPrimary
                border.color: currentAccent
                border.width: 2
            }

            // BUTTONS
            Rectangle {
                width: parent.width * 0.95
                height: parent.height * 0.28
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 30
                color: bgPrimary
                border.color: currentAccent
                border.width: 2
                }
            }
        }

        // RIGHT ZONE (Power & Battery) - 30%
        Rectangle {
            width: (parent.width - 50) * 0.3
            height: parent.height
            color: bgPrimary

            Column {
                anchors.fill: parent
                spacing: 25
                topPadding: 20

            // VOLUME SLIDER
            Rectangle {
                width: parent.width * 0.85
                height: parent.height * 0.32
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 30
                color: bgPrimary
                border.color: currentAccent
                border.width: 2
            }

            Row {
                width: parent.width * 0.85
                height: parent.height * 0.25
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 25

                // TEMPERATURE
                Rectangle {
                    width: (parent.width - parent.spacing) / 2
                    height: parent.height
                    radius: 30
                    color: bgPrimary
                    border.color: currentAccent
                    border.width: 2
                }

                // SEATS
                Rectangle {
                    width: (parent.width - parent.spacing) / 2
                    height: parent.height
                    radius: 30
                    color: bgPrimary
                    border.color: currentAccent
                    border.width: 2
                }
            }

            // SETTINGS
            Rectangle {
                width: parent.width * 0.85
                height: parent.height * 0.25
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 30
                color: bgPrimary
                border.color: currentAccent
                border.width: 2
            }
        }
    }
}

    // HIDDEN KEYBOARD INTERACTIONS
    Item {
        focus: true
        // Press spacebar to accelerate, let go to brake. N for Normal mode, E for Eco mode, S for Sport mode.
        Keys.onPressed: (event) => {
            if (event.key === Qt.Key_Space) vehicle.setGasPressed(true);
            if (event.key === Qt.Key_E) vehicle.driveMode = VehicleSimulator.Eco;
            if (event.key === Qt.Key_N) vehicle.driveMode = VehicleSimulator.Normal;
            if (event.key === Qt.Key_S) vehicle.driveMode = VehicleSimulator.Sport;
        }

        Keys.onReleased: (event) => { if (event.key === Qt.Key_Space) vehicle.setGasPressed(false); }
    }
}