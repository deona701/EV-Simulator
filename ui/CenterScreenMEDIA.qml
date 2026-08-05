import QtQuick
import QtMultimedia

// MEDIA
Item {
    id: mediaView

    property int currentTrack: 0
    property real volume: 0.5
    property var playlist: [
        { title: "Industrial", url: Qt.resolvedUrl("../assets-music/audioknap-industrial-516087.mp3") },
        { title: "Synthwave", url: Qt.resolvedUrl("../assets-music/mondamusic-synthwave-572999.mp3") },
        { title: "Cyberpunk", url: Qt.resolvedUrl("../assets-music/monume-cyberpunk-519219.mp3") },
        { title: "Interstellar Dance", url: Qt.resolvedUrl("../assets-music/psychronic-interstellar-dance-520116.mp3") },
        { title: "Dark Synthwave (Black Neon)", url: Qt.resolvedUrl("../assets-music/turtlebeats-dark-synthwave-black-neon-251690.mp3") },
        { title: "Dark Synthwave (Spectral)", url: Qt.resolvedUrl("../assets-music/turtlebeats-dark-synthwave-spectral-251688.mp3") }
    ]

    AudioOutput {
        id: audioOutput
        volume: mediaView.volume
    }

    MediaPlayer {
        id: mediaPlayer
        audioOutput: audioOutput

        source: mediaView.playlist[mediaView.currentTrack].url
    }

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

    function formatTime(ms) {
        let seconds = Math.floor(ms / 1000)
        let minutes = Math.floor(seconds / 60)
        seconds = seconds % 60
        return minutes + ":" + (seconds < 10 ? "0" : "") + seconds
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
                        id: songCover
                        height: parent.height
                        width: parent.height
                        border.color: currentAccent
                        color: currentAccent
                    }

                    // Name, Time, Play, Next, Loop
                    Rectangle {
                        height: parent.height
                        width: parent.width - songCover.width
                        border.color: currentAccent
                        color: "transparent"

                        Column {
                            anchors.centerIn: parent
                            spacing: 20

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 22
                                color: currentAccent
                                text: mediaView.playlist[mediaView.currentTrack].title
                                elide: Text.ElideRight
                            }

                            // Progress Bar Track
                            Row {
                                spacing: 15
                                anchors.horizontalCenter: parent.horizontalCenter

                                // Current Time (Left)
                                Text {
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 14
                                    color: currentAccent
                                    text: mediaView.formatTime(mediaPlayer.position)
                                }

                                // Progress Bar

                                Rectangle {
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 220
                                    height: 8
                                    color: bgPrimary
                                    border.color: currentAccent
                                    radius: 4

                                    Rectangle {
                                        height: parent.height
                                        width: mediaPlayer.duration > 0 ? parent.width * (mediaPlayer.position / mediaPlayer.duration) : 0
                                        color: currentAccent
                                        radius: 4
                                    }

                                    MouseArea {
                                        anchors.fill: parent
                                        onClicked: (mouse) => {
                                            if (mediaPlayer.duration > 0) {
                                                let clickRatio = mouse.x / width
                                                mediaPlayer.position = mediaPlayer.duration * clickRatio
                                           }
                                        }
                                    }
                                }

                                // Total Duration (Right)
                                Text {
                                    anchors.verticalCenter: parent.verticalCenter
                                    font.pixelSize: 14
                                    color: currentAccent
                                    text: mediaView.formatTime(mediaPlayer.duration)
                                }
                            }

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
                                    color: mediaPlayer.loops === MediaPlayer.Infinite ? "#555555" : currentAccent
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

                ListView {
                    anchors.fill: parent
                    clip: true
                    model: mediaView.playlist

                    delegate: Rectangle {
                        width: ListView.view.width
                        height: 40
                        color: "transparent"
                        border.color: index === mediaView.currentTrack ? currentAccent : "transparent"

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            font.pixelSize: 24
                            color: currentAccent
                            text: modelData.title
                        }

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 10
                            font.pixelSize: 24
                            color: currentAccent
                            text: "▶︎"

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    mediaView.currentTrack = index
                                    mediaPlayer.play()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}