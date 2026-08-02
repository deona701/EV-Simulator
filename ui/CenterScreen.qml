import QtQuick

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

        Loader {
            anchors.fill: parent
            anchors.margins: 2

            source: {
                switch (root.activeView) {
                case "MAP":     return "CenterScreenMAP.qml"
                case "CAR":     return "CenterScreenCAR.qml"
                case "MEDIA":   return "CenterScreenMEDIA.qml"
                default:        return "CenterScreenMAP.qml"
                }
            }
        }
    }

        // BUTTONS
        CenterButtons {
            width: parent.width
            height: parent.height * 0.24
            anchors.horizontalCenter: parent.horizontalCenter

            onViewSelected: function(viewName) {
                root.activeView = viewName
            }
        }
    }
}