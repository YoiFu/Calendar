import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Window

Rectangle {
    id: root

	height: 16

    gradient: Gradient {
		orientation: Gradient.Horizontal
        GradientStop { position: 0.0; color: "#000000" }
        GradientStop { position: 1.0; color: root.color }
    }
    radius: 8

    Rectangle {
        id: buttonSlider

        anchors.verticalCenter: parent.verticalCenter
        x: root.width - buttonSlider.width - internal.spacing

        height: root.height - internal.spacing
        width: height
        radius: width

        color: "transparent"

        border.width: 1
        border.color: "#C0C0C0"

        MouseArea {
            id: sliderMouseArea

            anchors.fill: parent
            drag.target: buttonSlider
            drag.axis: Drag.XAxis
            drag.minimumX: internal.spacing
            drag.maximumX: root.width - buttonSlider.width - internal.spacing
        }
    }

    QtObject {
        id: internal

        readonly property int spacing: 2
    }
}
