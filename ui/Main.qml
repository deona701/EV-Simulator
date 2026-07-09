import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import ev_simulator
import QtQuick.Shapes 1.15

Window {
    // Core Color Palette
    property color bgPrimary: "#0a0b0e"
    property color accentNormal: "#00ffff"
    property color accentSport: "#e43131"
    property color accentEco: "#04FF00"
    property color textNeutral: "#ffffff"

    // Active Color (Switches based on mode)
    property color currentAccent: {
        if (vehicle.driveMode === VehicleSimulator.Eco) return accentEco;
        if (vehicle.driveMode === VehicleSimulator.Sport) return accentSport;
        return accentNormal;
    }

    id: root
    width: 1920
    height: 720
    visible: true
    title: "EV Simulator"
    color: bgPrimary

    VehicleSimulator {
        id: vehicle
    }

    Row {
        anchors.fill: parent
        anchors.margins: 25
        spacing: 25

        // LEFT ZONE (Speed & Motion) - 30% of the screen
        Rectangle {
            width: (parent.width - 50) * 0.3
            height: parent.height
            color: "transparent"

            Column {
                anchors.fill: parent
                spacing: 25
                topPadding: 20

                // SPEED CARD
                SpeedCard {}

                // BATTERY CARD
                BatteryCard {}
            }
        }

        // CENTER ZONE (Road & Environment) - 40%
        Rectangle {
            width: (parent.width - 50) * 0.4
            height: parent.height
            color: bgPrimary

            CenterScreen {
                anchors.fill: parent
            }
        }

        // RIGHT ZONE (Power & Battery) - 30%
        Rectangle {
            width: (parent.width - 50) * 0.3
            height: parent.height
            color: bgPrimary

            Column {
                anchors.fill: parent
                spacing: 25
                topPadding: 20

                // VOLUME SLIDER
                VolumeSlider {}

                Row {
                    width: parent.width * 0.85
                    height: parent.height * 0.25
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 25

                    // TEMPERATURE
                    Temperature {}

                    // SEATS
                    Seats {}
                }

                // SETTINGS
                Settings {}
            }
        }
    }

    // HIDDEN KEYBOARD INTERACTIONS
    Item {
        focus: true
        /* Press spacebar to accelerate, let go to brake. N for Normal mode, E for Eco mode, S for Sport mode.
        O to toggle One-Pedal Mode. */
        Keys.onPressed: (event) => {
            if (event.key === Qt.Key_Space) vehicle.setGasPressed(true);
            if (event.key === Qt.Key_E) vehicle.driveMode = VehicleSimulator.Eco;
            if (event.key === Qt.Key_N) vehicle.driveMode = VehicleSimulator.Normal;
            if (event.key === Qt.Key_S) vehicle.driveMode = VehicleSimulator.Sport;

            if (event.key === Qt.Key_O) vehicle.onePedalMode = !vehicle.onePedalMode;
        }

        Keys.onReleased: (event) => { if (event.key === Qt.Key_Space) vehicle.setGasPressed(false); }
    }
}