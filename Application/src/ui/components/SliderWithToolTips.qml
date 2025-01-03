import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Controls.Material

import CPalette 1.0

Item {
	id: root

    enum SliderType {
        Default,
        Brightness,
        Transparency,
        Size
    }

    property int sliderType: SliderWithToolTips.SliderType.Default
	property int preferredToolTipEdge: Qt.BottomEdge

	property real value: 0.0
	property real from: 0.0
	property real to: 100.0
	property real stepSize: 1.0
	property alias rowSpacing: sliderRow.spacing

	signal moved()

	implicitHeight: sliderRow.implicitHeight

	onMoved: function() {
		root.value = slider.value;
		slider.value = Qt.binding(function() { return root.value; });
	}

	RowLayout {
		id: sliderRow

		anchors.fill: parent

		IconButton {
			id: lessButton

			Layout.preferredWidth: internal.iconWidth
			Layout.preferredHeight: internal.iconHeight

			source: internal.sliderData.lessImage
			enabled: root.value !== root.from

			onReleased: function() {
				internal.decrease();
			}

			onTriggered: function() {
				internal.decrease();
			}

			CustomTooltip {
				text: internal.sliderData.lessText
				visible: lessButton.containMouse

				x: lessButton.x - width / 2
				y: lessButton.y - 40
			}
		}

		Slider {
			id: slider

			Layout.fillWidth: true
			Layout.preferredHeight: internal.preferredHeight

			from: root.from
			to: root.to
			stepSize: root.stepSize
			snapMode: Slider.NoSnap

			value: root.value

			onMoved: function() {
				root.moved();
			}

			// handle: Rectangle {
			// 	id: sliderHander

			// 	color: "black"
			// 	height: 16
			// 	width: 16
			// 	radius: width

			// 	anchors {
			// 		verticalCenter: parent.verticalCenter
			// 	}

			// 	CustomTooltip {
			// 		id: sliderToolTip

			// 		x: sliderHander.x - parent.width / 2
			// 		y: sliderHander.y - 40s

			// 		text: slider.value + "%"
			// 		visible: slider.pressed || slider.hovered
			// 	}

			// 	MouseArea {
			// 		id: handleSliderArea

			// 		anchors.fill: parent
			// 		hoverEnabled: true
			// 	}
			// }

			background: Rectangle {
				id: sliderBackground

				anchors.centerIn: parent

				width: slider.width
				height: internal.backgroundSliderHeight
				radius: height/2

				color: "#C0C0C0"
			}
		}


		IconButton {
			id: moreButton

			Layout.preferredWidth: internal.iconWidth
			Layout.preferredHeight: internal.iconHeight

			source: internal.sliderData.moreImage
			enabled: root.value !== root.from

			onReleased: function() {
				internal.increase();
			}

			onTriggered: function() {
				internal.increase();
			}

			CustomTooltip {
				text: internal.sliderData.moreText
				visible: moreButton.containMouse

				x: moreButton.x - moreButton.width / 2
				y: moreButton.y - 40
			}
		}
	}

	states: [
		State {
			name: "Brightness"
            when: root.sliderType === SliderWithToolTips.SliderType.Brightness
			PropertyChanges {
				target: internal
				sliderData: {
					"lessImage": "../assets/Brightness-increase.svg",
					"moreImage": "../assets/Brightness-decrease.svg",
					"lessText": qsTr("Dimmer"),
					"moreText": qsTr("Brighter")
				};
			}
		},
		State {
			name: "Opacity"
            when: root.sliderType === SliderWithToolTips.SliderType.Transparency
			PropertyChanges {
				target: internal
				sliderData: {
					"lessImage": "../assets/Transparent.svg",
					"moreImage": "../assets/Solid.svg",
					"lessText": qsTr("More transparent"),
					"moreText": qsTr("Less transparent")
				}
			}
		},
		State {
			name: "Zoom"
            when: root.sliderType === SliderWithToolTips.SliderType.Size
			PropertyChanges {
				target: internal
				sliderData: {
					"lessImage": "../assets/Less.svg",
					"moreImage": "../assets/More.svg",
					"lessText": qsTr("Smaller"),
					"moreText": qsTr("Bigger")
				}
			}
		},
		State {
			name: "Default"
            when: root.sliderType === SliderWithToolTips.SliderType.Default
			PropertyChanges {
				target: internal
				sliderData: {
					"lessImage": "../assets/Less.svg",
					"moreImage": "../assets/More.svg",
					"lessText": qsTr("Less"),
					"moreText": qsTr("More")
				}
			}
		}
	]

	QtObject {
		id: internal

		property var sliderData: ({})
		property real dynamicValue: 0.0

		readonly property int preferredHeight: 24
		readonly property int iconWidth: 24
		readonly property int iconHeight: 24
		readonly property int backgroundSliderHeight: 4

		function increase() {
			if (root.value < 100) {
				root.value = root.value + 1;
			}
		}
		function decrease() {
			if (root.value > 0) {
				root.value = root.value - 1;
			}
		}
	}
}
