import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import ev_simulator
import QtQuick.Shapes 1.15

Rectangle {
    id: root
    property string activeView: "MAP"

    width: parent.width - 50
    height: parent.height
    color: bgPrimary

    Column {
        anchors.fill: parent
        spacing: 25
        topPadding: 20

    // MAIN SCREEN
    Rectangle {
        width: parent.width
        height: parent.height * 0.62
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 10
        color: bgPrimary
        border.color: currentAccent
        border.width: 2

        // NAVIGATION
        Item {

        }

        // CAR
        Item {

        }

        // MEDIA
        Item {

        }
    }

    // BUTTONS
    Rectangle {
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
                        onClicked: root.activeView = "MAP"
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
                        onClicked: root.activeView = "CAR"
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
                        onClicked: root.activeView = "MEDIA"
                    }
                }
            }
        }
    }
}