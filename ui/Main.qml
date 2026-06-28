import QtQuick
import QtQuick.Window
import ev_simulator

Window {
    width: 1920
    height: 720
    visible: true
    title: "EV Ultrawide Cockpit"
    color: "#050505" // Deep black

    VehicleSimulator {
        id: vehicle
    }

    Row {
        anchors.fill: parent

        // LEFT ZONE (Speed & Motion) - 30%
        Rectangle {
            width: parent.width * 0.3
            height: parent.height
            color: "#1a1111" // Temporary dark red tint
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
}