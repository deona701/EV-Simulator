import QtQuick

Rectangle {
    id: seatsCard
    property int totalBars: 15
    property int currentVolume: 5
    width: parent.width * 0.85
    height: parent.height * 0.32
    anchors.horizontalCenter: parent.horizontalCenter
    radius: 10
    color: bgPrimary
    border.color: currentAccent
    border.width: 2

    Row {
        anchors.centerIn: parent
        height: parent.height * 0.6
        spacing: 5

        Repeater {
            model: seatsCard.totalBars

            Rectangle {
                anchors.bottom: parent.bottom
                width: 10
                height: 6 + (index * 6)
                color: currentAccent
                opacity: index < seatsCard.currentVolume ? 1.0 : 0.2
            }
        }
    }

    MouseArea {
        anchors.fill: parent

        function updateVolume(mouse) {
            var calculated = Math.round((mouse.x / width) * seatsCard.totalBars)
            seatsCard.currentVolume = Math.max(0, Math.min(seatsCard.totalBars, calculated))
        }

        onClicked: (mouse) => updateVolume(mouse)
        onPositionChanged: (mouse) => {
            if (pressed) updateVolume(mouse)
        }
    }
}