import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material

import "../js_functions/FunctionUtils.js" as Utils

Item {
	id: root

	required property color targetColor

	height: 24

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

		spacing: 0

		Text {
			id: symText

			Layout.alignment: Qt.AlignVCenter

			verticalAlignment: Text.AlignVCenter
			font.pixelSize: 12
			font.bold: true

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
			font.pixelSize: 11

			color: textColor

			// background: Item{}
		}
	}

	RowLayout {
		id: contentLayout

		anchors.fill: parent
		DetailBlock {
			Layout.fillHeight: true
			Layout.preferredWidth: 112

			RowLayout {
				anchors {
					fill: parent
					rightMargin: internal.innerSpacing
					leftMargin: internal.innerSpacing
				}
				spacing: 2

				SymbolWithValue {
					Layout.fillHeight: true
					Layout.alignment: Qt.AlignVCenter
					symbolText: "R"
					valueText: internal.convertColorChannelValue(internal.red).toString()
				}

				Splitter {
					Layout.fillHeight: true
				}

				SymbolWithValue {
					Layout.fillHeight: true
					Layout.alignment: Qt.AlignVCenter
					symbolText: "G"
					valueText: internal.convertColorChannelValue(internal.green).toString()
				}

				Splitter {
					Layout.fillHeight: true
				}

				SymbolWithValue {
					Layout.fillHeight: true
					Layout.alignment: Qt.AlignVCenter
					symbolText: "B"
					valueText: internal.convertColorChannelValue(internal.blue).toString()
				}
			}
		}

		Item {
			Layout.fillWidth: true
		}

		DetailBlock {
			Layout.fillHeight: true
			Layout.preferredWidth: 60

			RowLayout {
				anchors {
					fill: parent
					rightMargin: internal.innerSpacing
					leftMargin: internal.innerSpacing
				}
				spacing: 2

				Rectangle {
					Layout.preferredHeight: parent.height - internal.innerSpacing * 2
					Layout.preferredWidth: height
					radius: 2
					color: root.targetColor
				}

				SymbolWithValue {
					Layout.fillHeight: true
					symbolText: "#"
					valueText: Utils.hexaFromRGBA(internal.red, internal.green, internal.blue)
				}
			}
		}
	}

	QtObject {
		id: internal

		readonly property color boderColor: "#9D9D9D"
		readonly property int innerSpacing: 4

		function convertColorChannelValue(color) {
			return (color / 100) * 255
		}

		property int red: root.targetColor.r
		property int green: root.targetColor.g
		property int blue: root.targetColor.b
	}
}
