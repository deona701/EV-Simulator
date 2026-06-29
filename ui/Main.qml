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
            width: parent.width * 0.3
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
            width: parent.width * 0.4
            height: parent.height
            color: "#11111a" // Temporary dark blue tint
        }

        // RIGHT ZONE (Power & Battery) - 30%
        Rectangle {
            width: parent.width * 0.3
            height: parent.height
            color: "#111a11" // Temporary dark green tint
        }
    }

    // HIDDEN INTERACTION: Press spacebar to accelerate, let go to brake
    Item {
        focus: true
        Keys.onPressed: (event) => { if (event.key === Qt.Key_Space) vehicle.setGasPressed(true); }
        Keys.onReleased: (event) => { if (event.key === Qt.Key_Space) vehicle.setGasPressed(false); }
    }
}