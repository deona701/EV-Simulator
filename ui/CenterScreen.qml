import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import ev_simulator
import QtQuick.Shapes 1.15
import QtLocation
import QtPositioning
import QtQuick.Effects

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
        Rectangle {
            anchors.fill: parent
            visible: root.activeView === "MAP"
            color: bgPrimary
            radius: 10
            border.color: currentAccent
            border.width: 2

            Plugin {
                id: mapPlugin
                name: "osm"

                PluginParameter {
                    name: "osm.mapping.custom.host"
                    value: "https://a.basemaps.cartocdn.com/dark_all/"
                }

                PluginParameter {
                    name: "osm.useragent"
                    value: "EV_Simulator"
                }

                PluginParameter {
                    name: "osm.mapping.providersrepository.disabled"
                    value: true
                }
            }

            Rectangle {
                id: mapMask
                anchors.fill: parent
                anchors.margins: 2
                radius: 8
                color: black
                visible: false
                layer.enabled: true
            }

            Map {
                id: navMap
                anchors.fill: parent
                anchors.margins: 2
                plugin: mapPlugin
                activeMapType: navMap.supportedMapTypes[navMap.supportedMapTypes.length - 1]
                zoomLevel: 14
                center: QtPositioning.coordinate(40.7128, -74.0060)

                layer.enabled: true
                layer.effect: MultiEffect {
                    maskEnabled: true
                    maskSource: mapMask
                }
            }
        }

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

        // MEDIA
        Item {
            anchors.fill: parent
            visible: root.activeView === "MEDIA"

            Text {
                text: "MEDIA"
                color: currentAccent
                font.pixelSize: 18
                font.bold: true
                anchors.centerIn: parent
            }
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