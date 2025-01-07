import QtQuick
import QtQml
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.Window

Item {
	id: root

	property QtObject paletteModel: null
	property bool openPopup: false
	property color cellColor

	height: internal.outerRadius
	width: internal.outerRadius

    signal colorChanged(var chosenColor)

	onOpenPopupChanged: function() {
		if (openPopup) {
			colorPickerLoader.open();
		}
	}

	Rectangle {
		id: outter

		anchors.fill: parent

		radius: internal.outerRadius

		border.width: 1
		border.color: "#000000"

		color: "transparent"

		visible: root.openPopup
	}

	Rectangle {
		id: inner

		anchors.centerIn: parent

		height: internal.innerRadius
		width: internal.innerRadius

		radius: internal.innerRadius

		color: root.cellColor

		MouseArea {
			id: mouse

			anchors.fill: parent
			onClicked: {
				root.openPopup = !root.openPopup;
			}
		}
	}

	ColorPickerPopup {
		id: colorPickerLoader

		anchorItem: root

		x: root.x - popUpWidth
		y: root.y + internal.outerRadius/2

		onVisibleChanged: function (){
			if (!visible) {
				root.openPopup = false;
			}
		}

		paletteModel: root.paletteModel
		targetColor: root.cellColor
        onColorChanged: function (chosenColor) {
            root.colorChanged(chosenColor)
        }
	}

	QtObject {
		id: internal

		readonly property int outerRadius: 24
		readonly property int innerRadius: 20
	}
}


