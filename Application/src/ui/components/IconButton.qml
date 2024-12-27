import QtQuick
import QtQuick.Controls
import QtQuick.Templates as T

import CPalette 1.0

Image {
	id: root

	property alias source: maskedImg.source
	property alias sourceSize: maskedImg.sourceSize

	signal clicked
	signal released
	signal buttonPressed

	T.Button {
		id: button

		anchors.fill: parent

		onClicked: function() {
			root.clicked();
		}
		onReleased: function() {
			root.released();
		}
		onPressed: function() {
			root.buttonPressed();
		}
		focusPolicy: Qt.NoFocus

		MaskedImage {
			id: maskedImg

			anchors.fill: parent

			fillMode: Image.PreserveAspectFit
			sourceSize: internal.defaultIconSize
			color: mouseArea.containsMouse ? CPalette.layerHover2 : CPalette.layer2

			MouseArea {
				id: mouseArea

				anchors.fill: parent

				hoverEnabled: true
			}
		}
	}

	QtObject {
		id: internal

		readonly property size defaultIconSize: Qt.size(16, 16)
	}
}
