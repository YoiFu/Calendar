import QtQuick
import QtQuick.Controls
import Qt5Compat.GraphicalEffects

Item {
	id: root

	property alias source: img.source
	property alias sourceSize: img.sourceSize
	property alias flipHorizontal: img.mirror
	property alias flipVertical: img.mirrorVertically
	property alias cache: img.cache
	property alias fillMode: img.fillMode
	property alias color: layer.color

	Item {
		id: wrapper

		anchors.centerIn: parent

		height: img.height + internal.extraField
		width: img.width + internal.extraField

		Image {
			id: img

			anchors.centerIn: parent

			height: root.height
			width: root.width

			ColorOverlay {
				id: layer

				anchors.fill: img

				source: img
			}
		}
	}

	QtObject {
		id: internal

		readonly property int extraField: 4
	}
}
