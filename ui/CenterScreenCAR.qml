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
            eulerRotation.y: -70
        }

        TeslaModelS {
            scale: Qt.vector3d(1, 1, 1)
        }
    }
}