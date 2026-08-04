import QtQuick
import QtQuick.Layouts

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

        StackLayout {
            anchors.fill: parent
            anchors.margins: 2

            currentIndex: {
                switch (root.activeView) {
                case "MAP":     return 0
                case "CAR":     return 1
                case "MEDIA":   return 2
                default:        return 0
                }
            }

            CenterScreenMAP { }
            CenterScreenCAR { }
            CenterScreenMEDIA { }
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