import QtQuick
import QtQuick.Window
import ev_simulator

Window {
    width: 800
    height: 480
    visible: true
    title: "EV Simulator Core"
    color: "#111111"

    VehicleSimulator {
        id: vehicle
    }

    Column {
        anchors.centerIn: parent
        spacing: 20

        Text {
            text: vehicle.speed.toFixed(0) + " KM/H"
            color: "#00ffff"
            font.pointSize: 48
            font.bold: true
            font.family: "sans-serif"
        }

        Text {
            text: vehicle.soc.toFixed(0) + " %"
            color: "#00ffff"
            font.pointSize: 48
            font.bold: true
            font.family: "sans-serif"
        }
    }
}