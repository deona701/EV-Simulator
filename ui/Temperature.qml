import QtQuick

Rectangle {
    id: tempCard
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
            width: 20
            height: 20
            radius: 6
            color: "transparent"
            border.color: currentAccent
            border.width: 1

            Text {
                text: "-"
                color: currentAccent
                anchors.centerIn: parent
                font.bold: true
                font.pixelSize: 18
            }

            MouseArea {
                anchors.fill: parent
                onClicked: if (tempCard.targetTemp > 16)
                    tempCard.targetTemp -= 1.0
            }
        }

        // Temperature
        Text {

        }

        // Increase Button
        Rectangle {
            width: 20
            height: 20
            radius: 6
            color: "transparent"
            border.color: currentAccent
            border.width: 1

            Text {
                text: "+"
                color: currentAccent
                anchors.centerIn: parent
                font.bold: true
                font.pixelSize: 18
            }

            MouseArea {
                anchors.fill: parent
                onClicked: if (tempCard.targetTemp > 16)
                    tempCard.targetTemp += 1.0
            }
        }
    }
}