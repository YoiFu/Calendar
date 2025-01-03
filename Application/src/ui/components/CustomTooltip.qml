import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

ToolTip {
	id: root

	padding: 0

	background: Rectangle {
		id: tooltipBackground

		height: 30
		width: childrenRect.width + internal.padding * 2
		color: "white"
		border.color: "black"
		border.width: 1
		opacity: 0.9
		radius: 6

		Text {
			anchors {
				left: parent.left
				leftMargin: internal.padding
				verticalCenter: parent.verticalCenter
			}

			text: root.text
			wrapMode: Text.WordWrap
			color: "black"
		}
	}

	QtObject {
		id: internal

		property int padding: 4
	}
}
