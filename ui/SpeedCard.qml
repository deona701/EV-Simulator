import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import ev_simulator
import QtQuick.Shapes 1.15

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
                    anchors.top: parent.top
                }
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

    // Vehicle Regen
    Rectangle {
        width: 14
        height: 6
        color: vehicle.regenActive ? accentEco : "#222326"
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 30
    }
}