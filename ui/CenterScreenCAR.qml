import QtQuick

// CAR
Item {
    anchors.fill: parent
    visible: root.activeView === "CAR"

    Text {
        text: "CAR"
        color: currentAccent
        font.pixelSize: 18
        font.bold: true
        anchors.centerIn: parent
    }
}