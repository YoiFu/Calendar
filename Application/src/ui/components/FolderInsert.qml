import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material
import Qt5Compat.GraphicalEffects

import CPalette 1.0

Item {
	id: root

	property alias sourcePath: pathContainer.text

	signal openFolder

	height: 28

	RowLayout {
		anchors.fill: parent

		spacing: 8

        TextField {
			id: pathContainer

			Layout.fillHeight: true
			Layout.fillWidth: true

			background: Rectangle {
				anchors.fill: parent

				color: CPalette.layer6
				border.color: "black"
				border.width: 1
				radius: 6
            }
		}

		Rectangle {
			id: folderButton

			Layout.fillHeight: true
			Layout.preferredWidth: height

			color: !buttonArea.containsMouse ? CPalette.layer1 : CPalette.layerHover1

			radius: 4

			Image {
				id: folderIcon

				anchors.centerIn: parent

				height: parent.height - 8
				width: height

				fillMode: Image.PreserveAspectFit
				source: "../assets/File.svg"

				ColorOverlay {
					id: overlayImage

					anchors.fill: parent
					source: folderIcon
					color: CPalette.layer6
				}
			}

			MouseArea {
				id: buttonArea

				anchors.fill: parent
				hoverEnabled: true

				onClicked: {
					root.openFolder();
				}
			}
		}
	}
}

