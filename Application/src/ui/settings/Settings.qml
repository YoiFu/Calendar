import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

import ui.components 1.0

Rectangle {
	id: root

    property QtObject model: null

	radius: 4

    implicitWidth: 280

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

			Layout.alignment: Qt.AlignVCenter
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
            sourceComponent: ColorPicker{
                paletteModel: root.model.paletteModel
                cellColor: root.model.textColor
            }
		}

		SettingsTextWithComponent {
			text: "Background Color"
            sourceComponent: ColorPicker{
                paletteModel: root.model.paletteModel
                cellColor: root.model.backgroundColor
            }
		}

		SettingsTextWithComponent {
			text: "Accent Color"
            sourceComponent: ColorPicker{
                paletteModel: root.model.paletteModel
                cellColor: root.model.accentColor
            }
		}

		SettingsTextWithComponent {
			text: "Custom Background"
			sourceComponent: CustomToggle {
                checked: root.model.customBackgroundEnabled
				onToggled: {

				}
			}
		}

		SettingsTextWithComponent {
			text: "Transparency"
			sourceComponent: SliderWithToolTips {
				id: sliderWithToolTips

				height: 28
				width: 160

                sliderType: SliderWithToolTips.SliderType.Transparency
                value: root.model.transparency

				onValueChanged: function() {
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
