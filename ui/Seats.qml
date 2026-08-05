import QtQuick
import QtQuick.Effects

Rectangle {
    id: seatsCard
    property int seatState: 0
    readonly property var stateNames: ["Off", "Low", "Medium", "High"]

    width: (parent.width - parent.spacing) / 2
    height: parent.height
    color: bgPrimary
    border.color: currentAccent
    border.width: 2
    radius: 10

    MouseArea {
        anchors.fill: parent
        onClicked: {
            seatsCard.seatState = (seatsCard.seatState + 1) % 4
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: 4

        Image {
            source: "../assets-images/car-seat-svgrepo-com.svg"
            width: 32
            height: 32
            fillMode: Image.PreserveAspectFit
            anchors.horizontalCenter: parent.horizontalCenter

            layer.enabled: true
            layer.effect: MultiEffect {
                    brightness: 1.0
                    colorization: 1.0
                    colorizationColor: currentAccent
                }
            }


        Text {
            text: seatsCard.stateNames[seatsCard.seatState]
            color: currentAccent
            font.pixelSize: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
}