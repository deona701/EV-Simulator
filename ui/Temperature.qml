import QtQuick

Rectangle {
    property real targetTemp

    width: (parent.width - parent.spacing) / 2
    height: parent.height
    radius: 10
    color: bgPrimary
    border.color: currentAccent
    border.width: 2

    Row {
        anchors.centerIn: parent
        spacing: 15

        // Decrease Button
        Rectangle {

        }

        // Temperature
        Text {

        }

        // Increase Button
        Rectangle {

        }
    }
}