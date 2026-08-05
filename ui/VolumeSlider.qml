import QtQuick

Rectangle {
    id: volumeCard
    property int totalBars: 15
    property int currentVolume: 5
    readonly property real normalizedVolume: currentVolume / totalBars
    signal volumeChanged(real newVolume)

    width: parent.width * 0.85
    height: parent.height * 0.32
    anchors.horizontalCenter: parent.horizontalCenter
    radius: 10
    color: bgPrimary
    border.color: currentAccent
    border.width: 2

    Row {
        id: barsRow
        anchors.centerIn: parent
        height: parent.height * 0.6
        spacing: 5

        Repeater {
            model: volumeCard.totalBars

            Rectangle {
                anchors.bottom: parent.bottom
                width: 10
                height: 6 + (index * 6)
                color: currentAccent
                opacity: index < volumeCard.currentVolume ? 1.0 : 0.2
            }
        }
    }

    MouseArea {
        anchors.fill: barsRow

        function updateVolume(mouse) {
            var calculated = Math.round((mouse.x / barsRow.width) * volumeCard.totalBars)
            volumeCard.currentVolume = Math.max(0, Math.min(volumeCard.totalBars, calculated))
        }

        onClicked: (mouse) => updateVolume(mouse)
        onPositionChanged: (mouse) => {
            if (pressed) updateVolume(mouse)
        }
    }
}