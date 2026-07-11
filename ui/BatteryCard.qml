import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import ev_simulator
import QtQuick.Shapes 1.15

Rectangle {
    id: batteryBox
    width: 400
    height: 250
    color: bgPrimary
    border.color: currentAccent
    border.width: 2
    radius: 10

    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        //Battery
        Text {
            text: "Battery"
            color: currentAccent
            font.pixelSize: 28
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Grid {
            columns: 2
            rows: 2
            width: parent.width
            height: parent.height - 50
            columnSpacing: 40
            rowSpacing: 20

            //Battery Capacity
            Column {
                Text { text: "Battery Capacity"; color: currentAccent; font.pixelSize: 14 }
                Text { text: Math.round(vehicle.soc); color: currentAccent; font.pixelSize: 34; font.bold: true }
            }

            //Range Capacity
            Column {
                Text { text: "Range Capacity"; color: currentAccent; font.pixelSize: 14 }
                Text {
                    text: Math.round(vehicle.estimatedRange)
                    color: currentAccent
                    font.pixelSize: 34
                    font.bold: true
                }
            }

            //Battery Temperature
            Column {
                Text { text: "Battery Temperature:"; color: currentAccent; font.pixelSize: 14 }
                Text {
                    text: Math.round(vehicle.batteryTemperature) + "C°"
                    color: currentAccent
                    font.pixelSize: 34
                    font.bold: true
                }
            }

            //Total Range
            Column {
                Text { text: "Total Range"; color: currentAccent; font.pixelSize: 14 }
                Text { text: Math.round(100 * vehicle.energyEfficiency); font.pixelSize: 34; color: currentAccent; font.bold: true }
            }
        }
    }
}