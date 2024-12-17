import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Window

Rectangle {
    id: root

    height: 14

    gradient: Gradient {
        orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: "#000000" }
        GradientStop { position: 1.0; color: root.color }
    }

    Rectangle {
        id: buttonSlider

        anchors.verticalCenter: parent.verticalCenter
        height: root.height - internal.spacing
        width: height
        radius: width

        color: "transparent"

        border.width: 1
        border.color: "#C0C0C0"

        MouseArea {
            id: sliderMouseArea

            anchors.fill: parent
            drag.active: true
            drag.target: parent
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: root.width - buttonSlider.width - internal.spacing
        }
    }

    QtObject {
        id: internal

        readonly property int spacing: 2
    }
}
