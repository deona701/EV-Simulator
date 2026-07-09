import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import ev_simulator
import QtQuick.Shapes 1.15

Rectangle {
    width: (parent.width - parent.spacing) / 2
    height: parent.height
    radius: 30
    color: bgPrimary
    border.color: currentAccent
    border.width: 2
}