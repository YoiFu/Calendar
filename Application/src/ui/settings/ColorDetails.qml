import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Window

Item {
	id: root

	height: 16

	component Splitter: Rectangle {
		width: 1
		color: internal.boderColor
	}

	component DetailBlock: Rectangle {
		radius: 4
		color: "transparent"
		border.width: 1
		border.color: internal.boderColor
	}

	component SymbolWithValue: RowLayout {
		property alias symbolText: symText.text
		property alias valueText: valueText.text
		readonly property color textColor: "#FFFFFF"

		Text {
			id: symText

			Layout.alignment: Qt.AlignVCenter

			verticalAlignment: Text.AlignVCenter
			font.pixelSize: 10
			color: textColor
		}

		Item {
			Layout.fillWidth: true
		}

		Text {
			id: valueText

			Layout.alignment: Qt.AlignVCenter

			verticalAlignment: Text.AlignVCenter
			horizontalAlignment: Text.AlignRight
			font.pixelSize: 9
			color: textColor
		}
	}

	RowLayout {
		id: contentLayout

		anchors.fill: parent
		DetailBlock {
			Layout.fillHeight: true
			Layout.preferredWidth: 102

			RowLayout {
				anchors {
					fill: parent
				}
				spacing: 0

				SymbolWithValue {
					Layout.fillHeight: true
					Layout.alignment: Qt.AlignVCenter
					symbolText: "R"
					valueText: "255"
				}

				Splitter {
					Layout.fillHeight: true
				}

				SymbolWithValue {
					Layout.fillHeight: true
					Layout.alignment: Qt.AlignVCenter
					symbolText: "G"
					valueText: "255"
				}

				Splitter {
					Layout.fillHeight: true
				}

				SymbolWithValue {
					Layout.fillHeight: true
					Layout.alignment: Qt.AlignVCenter
					symbolText: "B"
					valueText: "255"
				}
			}
		}

		Item {
			Layout.fillWidth: true
		}

		DetailBlock {
			Layout.fillHeight: true
			Layout.preferredWidth: 55

			RowLayout {
				anchors {
					fill: parent
				}
				spacing: 2

				Rectangle {
					Layout.fillHeight: true
					Layout.preferredWidth: height
					radius: 2
					color: "red"
				}

				SymbolWithValue {
					Layout.fillHeight: true
					symbolText: "#"
					valueText: "FFFFF"
				}
			}
		}
	}

	QtObject {
		id: internal

		readonly property color boderColor: "#9D9D9D"
		readonly property int innerSpacing: 4
	}
}
