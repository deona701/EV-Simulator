import QtQuick
import QtQuick3D
import "../assets-car"

// CAR
Item {
    anchors.fill: parent

    Text {
        text: "CAR"
        color: currentAccent
        font.pixelSize: 18
        font.bold: true
        anchors.centerIn: parent
    }

    View3D {
        anchors.fill: parent

        PerspectiveCamera {
            position: Qt.vector3d(0, 300, 400)
            eulerRotation.x: -30
        }

        DirectionalLight {
            eulerRotation.x: -30
            eulerRotation.y: -60
        }

        TeslaModelS {
            id: carModel
            scale: Qt.vector3d(1, 1, 1)

            NumberAnimation {
                id: spinAnimation
                target: carModel
                property: "eulerRotation.y"
                duration: 15000
                from: carModel.eulerRotation.y
                to: carModel.eulerRotation.y + 360
                loops: Animation.Infinite
                running: true
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        property real lastX: 0

        onPressed: (mouse) => {
            spinAnimation.stop()
            lastX = mouse.x
        }
        onPositionChanged: (mouse) => {
            var delta = mouse.x - lastX
            carModel.eulerRotation.y += delta * 0.5
            lastX = mouse.x
        }
        onReleased: { spinAnimation.start() }
    }
}