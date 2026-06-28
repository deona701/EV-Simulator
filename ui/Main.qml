import QtQuick
import QtQuick.Window
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

    // HIDDEN INTERACTION: Press spacebar to accelerate, let go to brake
    Item {
        focus: true
        Keys.onPressed: (event) => { if (event.key === Qt.Key_Space) vehicle.setGasPressed(true); }
        Keys.onReleased: (event) => { if (event.key === Qt.Key_Space) vehicle.setGasPressed(false); }
    }
}