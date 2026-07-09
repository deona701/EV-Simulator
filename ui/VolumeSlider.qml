import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import ev_simulator
import QtQuick.Shapes 1.15

Rectangle {
    width: parent.width * 0.85
    height: parent.height * 0.32
    anchors.horizontalCenter: parent.horizontalCenter
    radius: 30
    color: bgPrimary
    border.color: currentAccent
    border.width: 2
}