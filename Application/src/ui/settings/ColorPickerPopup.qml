import QtQuick
import QtQml
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.Window

Popup {
	id: root

	property QtObject paletteModel: null
	property color targetColor
	property int preferredEdge: Qt.LeftEdge
	property Item anchorItem: null
	readonly property int popUpWidth: content.contentWidth

    signal colorChanged(var chosenColor)

	modal: true

	padding: 0

    contentItem: ColorPickerContent {
        id: content

        paletteModel: root.paletteModel
        targetColor: root.targetColor

        onColorChanged: function (chosenColor) {
            root.colorChanged(chosenColor)
        }
    }

	QtObject {
		id: internal

		readonly property int height: 12
		readonly property int width: 10
		readonly property color popupColor: "#4B5945"

		readonly property var windowContentItem: root.anchorItem
												 && root.anchorItem.Window.window
												 ? root.anchorItem.Window.contentItem : null
	}
}
