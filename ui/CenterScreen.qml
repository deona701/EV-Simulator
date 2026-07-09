import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import ev_simulator
import QtQuick.Shapes 1.15

Rectangle {
    width: parent.width - 50
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
        width: parent.width * 1
        height: parent.height * 0.28
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 30
        color: bgPrimary
        border.color: currentAccent
        border.width: 2
        }
    }
}