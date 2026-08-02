import QtQuick

Rectangle {
    id: buttonsRoot

    signal viewSelected(string viewName)

    width: parent.width
    height: parent.height * 0.24
    anchors.horizontalCenter: parent.horizontalCenter
    radius: 10
    color: bgPrimary
    border.color: currentAccent
    border.width: 2

    Row {
        width: parent.width
        height: parent.height

        // NAVIGATION
        Rectangle {
            width: (parent.width - 4) / 3
            height: parent.height
            color: "transparent"

            Text {
                text: "NAV"
                color: currentAccent
                font.pixelSize: 18
                font.bold: true
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: buttonsRoot.viewSelected("MAP")
            }
        }

        // DIVIDER
        Rectangle {
            width: 2
            height: parent.height
            color: currentAccent
        }

        // CAR
        Rectangle {
            width: (parent.width - 4) / 3
            height: parent.height
            color: "transparent"

            Text {
                text: "CAR"
                color: currentAccent
                font.pixelSize: 18
                font.bold: true
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: buttonsRoot.viewSelected("CAR")
            }
        }

        // DIVIDER
        Rectangle {
            width: 2
            height: parent.height
            color: currentAccent
        }

        // MEDIA
        Rectangle {
            width: (parent.width - 4) / 3
            height: parent.height
            color: "transparent"

            Text {
                text: "MEDIA"
                color: currentAccent
                font.pixelSize: 18
                font.bold: true
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: buttonsRoot.viewSelected("MEDIA")
            }
        }
    }
}