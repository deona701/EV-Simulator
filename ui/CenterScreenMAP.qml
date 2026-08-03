import QtQuick
import QtLocation
import QtPositioning
import QtQuick.Effects

// NAVIGATION
Rectangle {
    anchors.fill: parent
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