import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import ev_simulator
import QtQuick.Shapes 1.15
import QtLocation
import QtPositioning
import QtQuick.Effects
import QtMultimedia

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
                    name: "osm.mapping.cache.disk.size"
                    value: 0
                }

                PluginParameter {
                    name: "osm.mapping.custom.host"
                    value: "https://a.basemaps.cartocdn.com/dark_all/%z/%x/%y@2x.png"
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
                color: "black"
                visible: false
                layer.enabled: true
            }

            Map {
                id: navMap
                color: bgPrimary
                anchors.fill: parent
                anchors.margins: 2
                plugin: mapPlugin
                zoomLevel: 14
                center: QtPositioning.coordinate(40.7128, -74.0060)

                activeMapType: supportedMapTypes.length > 0 ? supportedMapTypes[supportedMapTypes.length - 1] : null

                layer.enabled: true
                layer.effect: MultiEffect {
                    maskEnabled: true
                    maskSource: mapMask
                }

                DragHandler {
                    id: drag
                    target: null
                    onTranslationChanged: (delta) => navMap.pan(-delta.x, -delta.y)
                }

                WheelHandler {
                    acceptedDevices: PointerDevice.Mouse | PointerDevice.TouchPad

                    onWheel: function(event) {
                        if (event.angleDelta.y > 0) {
                            navMap.zoomLevel += 0.5
                        }
                        else {
                            navMap.zoomLevel -= 0.5
                        }
                    }
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
            id: mediaView
            anchors.fill: parent
            visible: root.activeView === "MEDIA"

            property int currentTrack: 0
            property var playlist: [
                Qt.resolvedUrl("../assets-music/Resurgo-Aim-To-Head-Official.mp3"),
                Qt.resolvedUrl("../assets-music/Sport-Cyberpunk-Racing-by-Infraction.mp3"),
                Qt.resolvedUrl("../assets-music/DOMBOI-BEATS-PROVIDER.mp3"),
                Qt.resolvedUrl("../assets-music/BOUNCE-BACK-MOSHEIX.mp3")
            ]

            function togglePlayPause() {
                if (mediaPlayer.playbackState === MediaPlayer.PlayingState) {
                    mediaPlayer.pause()
                } else {
                    mediaPlayer.play()
                }
            }

            function nextTrack() {
                currentTrack = (currentTrack + 1 + playlist.length) % playlist.length
                mediaPlayer.play()
            }

            function prevTrack() {
                currentTrack = (currentTrack - 1 + playlist.length) % playlist.length
                mediaPlayer.play()
            }

            function loopTrack() {
                mediaPlayer.loops = (mediaPlayer.loops === MediaPlayer.Infinite) ? 1 : MediaPlayer.Infinite
            }


            MediaPlayer {
                id: mediaPlayer
                audioOutput: AudioOutput { volume: 0.8 }

                source: mediaView.playlist[mediaView.currentTrack]
            }

            Rectangle {
                anchors.fill: parent
                radius: 10
                color: "transparent"

                Column {
                    anchors.fill: parent
                    anchors.margins: 10
                    spacing: 15

                    // Top Section
                    Rectangle {
                        id: topSection
                        width: parent.width
                        height: parent.height * 0.40
                        border.color: currentAccent
                        color: "transparent"

                        Row {
                            anchors.fill: parent

                            // Song Cover
                            Rectangle {
                                height: parent.height
                                width: parent.width * 0.40
                                border.color: currentAccent
                                color: currentAccent
                            }

                            // Name, Time, Play, Next, Loop
                            Rectangle {
                                height: parent.height
                                width: parent.width * 0.60
                                border.color: currentAccent
                                color: "transparent"

                                Column {
                                    anchors.centerIn: parent
                                    spacing: 20

                                    Row {
                                        spacing: 20
                                        anchors.horizontalCenter: parent.horizontalCenter

                                        Text {
                                            font.pixelSize: 24
                                            color: currentAccent
                                            text: mediaPlayer.playbackState === MediaPlayer.PlayingState ? "PAUSE" : "PLAY";

                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: {
                                                    mediaView.togglePlayPause()
                                                }
                                            }
                                        }

                                        Text {
                                            font.pixelSize: 24
                                            color: currentAccent
                                            text: "PREV"

                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: {
                                                    mediaView.prevTrack()
                                                }
                                            }
                                        }

                                        Text {
                                            font.pixelSize: 24
                                            color: currentAccent
                                            text: "NEXT"

                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: {
                                                    mediaView.nextTrack()
                                                }
                                            }
                                        }

                                        Text {
                                            font.pixelSize: 24
                                            color: currentAccent
                                            text: "LOOP"

                                            MouseArea {
                                                anchors.fill: parent
                                                onClicked: {
                                                    mediaView.loopTrack()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }

                    // Bottom Section
                    Rectangle {
                        id: bottomSection
                        width: parent.width
                        height: parent.height * 0.55
                        border.color: currentAccent
                        color: "transparent"

                        // Make the other songs appear here, with their names and a play button.
                    }
                }
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