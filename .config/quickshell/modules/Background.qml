import Quickshell
import Quickshell.Wayland

import QtQuick

Variants {
    model: Quickshell.screens

    PanelWindow {
        id: win

        WlrLayershell.exclusionMode: ExclusionMode.Ignore
        WlrLayershell.layer: WlrLayer.Background

        anchors.top: true
        anchors.bottom: true
        anchors.left: true
        anchors.right: true

        Loader {
            active: true
            asynchronous: true

            anchors.fill: parent

            Image {
                id: img

                anchors.fill: parent
                source: "/home/dumbnerd/Pictures/Wallpapers/herb.jpg"
            }
        }
    }
}
