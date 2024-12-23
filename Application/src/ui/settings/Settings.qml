import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

Rectangle {
	id: root

	radius: 4

	implicitHeight: 270
	implicitWidth: 200

	component SettingsTextWithComponent: RowLayout {
		id: template

		property alias sourceComponent: loader.sourceComponent
		property alias text: txt.text

		height: 10
		spacing: 0

		Text {
			id: txt

			Layout.preferredHeight: parent.height
			verticalAlignment: Text.AlignVCenter
		}

		Item {
			Layout.fillWidth: true
		}

		Loader {
			id: loader
		}
	}

	ColumnLayout {
		id: layout

		anchors {
			fill: parent
			topMargin: internal.verticalMargin
			bottomMargin: internal.verticalMargin
			rightMargin: internal.horizontalMargin
			leftMargin: internal.horizontalMargin
		}

		spacing: 8

		SettingsTextWithComponent {
			text: "Text Color"
			sourceComponent: ColorPicker{}
		}

		SettingsTextWithComponent {
			text: "Background Color"
			sourceComponent: ColorPicker{}
		}

		SettingsTextWithComponent {
			text: "Accent Color"
			sourceComponent: ColorPicker{}
		}

		SettingsTextWithComponent {
			text: "Background"
			sourceComponent: ColorPicker{}
		}

		SettingsTextWithComponent {
			text: "Custom Background"
			sourceComponent: Switch {
				id: mySwitch

				property color checkedColor: "#79D7BE"
				property color uncheckedColor: "#E5E5E5"

				anchors.centerIn: parent

				indicator: Rectangle {
					width: 30
					height: 16

					radius: height/2
					color: mySwitch.checked ? mySwitch.checkedColor : mySwitch.uncheckedColor

					Rectangle {
						x: mySwitch.checked ? parent.width - width - 2 : 1
						width: mySwitch.checked ? parent.height - 4 : parent.height - 2
						height: width
						radius: width
						anchors.verticalCenter: parent.verticalCenter
						color: "#FFFFFF"

						Behavior on x {
							NumberAnimation { duration: 200 }
						}
					}
				}
			}
		}

		Item {
			Layout.fillHeight: true
		}
	}

	QtObject {
		id: internal

		readonly property int verticalMargin: 8
		readonly property int horizontalMargin: 8
	}
}
