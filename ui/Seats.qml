import QtQuick

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
}