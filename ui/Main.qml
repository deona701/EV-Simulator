import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import ev_simulator

Window {
    id: root
    width: 1920
    height: 720
    visible: true
    title: "EV Cyber-Neon Custom Cockpit"
    color: "#0a0b0e" // Deep cyber black

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
                color: "#0a0b0e"
                border.color: "#00ffff"
                border.width: 2

                Text {
                    text: Math.round(vehicle.speed)
                    color: "#00ffff"
                    font.pixelSize: 34
                    font.bold: true
                    anchors.centerIn: parent
                }
            }

            // BATTERY CARD
            Rectangle {
                width: parent.width * 0.85
                height: parent.height * 0.38
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 30
                color: "#0a0b0e"
                border.color: "#00ffff"
                border.width: 2
                }
            }
        }


        // CENTER ZONE (Road & Environment) - 40%
        Rectangle {
            width: (parent.width - 50) * 0.4
            height: parent.height
            color: "#0a0b0e"

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
                color: "#0a0b0e"
                border.color: "#00ffff"
                border.width: 2
            }

            // BUTTONS
            Rectangle {
                width: parent.width * 0.95
                height: parent.height * 0.28
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 30
                color: "#0a0b0e"
                border.color: "#00ffff"
                border.width: 2
                }
            }
        }

        // RIGHT ZONE (Power & Battery) - 30%
        Rectangle {
            width: (parent.width - 50) * 0.3
            height: parent.height
            color: "#0a0b0e"

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
                color: "#0a0b0e"
                border.color: "#00ffff"
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
                    color: "#0a0b0e"
                    border.color: "#00ffff"
                    border.width: 2
                }

                // SEATS
                Rectangle {
                    width: (parent.width - parent.spacing) / 2
                    height: parent.height
                    radius: 30
                    color: "#0a0b0e"
                    border.color: "#00ffff"
                    border.width: 2
                }
            }

            // SETTINGS
            Rectangle {
                width: parent.width * 0.85
                height: parent.height * 0.25
                anchors.horizontalCenter: parent.horizontalCenter
                radius: 30
                color: "#0a0b0e"
                border.color: "#00ffff"
                border.width: 2
            }
        }
    }
}

    // HIDDEN INTERACTION: Press spacebar to accelerate, let go to brake
    Item {
        focus: true
        Keys.onPressed: (event) => { if (event.key === Qt.Key_Space) vehicle.setGasPressed(true); }
        Keys.onReleased: (event) => { if (event.key === Qt.Key_Space) vehicle.setGasPressed(false); }
    }
}