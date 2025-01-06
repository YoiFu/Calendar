import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQml.Models

import "../js_functions/FunctionUtils.js" as Utils

Item {
	id: root

	required property color targetColor

	property real hue: 1
	property real saturation: 1

	signal updateHS(var hueSignal, var saturationSignal, var value, var alpha)
	signal updateColor()

	states: [
		State {
			name: "editing"
			PropertyChanges {
				target: root
				hue: hue
				saturation: saturation
			}
		},
		State {
			name: "normal"
		}
	]
	state: "normal"

	Item {
		id: rgbColorCircle

		anchors.fill: parent

		Image {
			height: parent.height + 2
			width: parent.width + 2
			anchors.centerIn: parent
			source: "../assets/RGBAColor.png"
		}

		Rectangle {
			id: colorPicker
			property int r : 8

			x: parent.width/2 * (1 + root.saturation * Math.cos(2 * Math.PI * root.hue - Math.PI)) - 8
			y: parent.width/2 * (1 + root.saturation * Math.sin(-2 * Math.PI * root.hue - Math.PI)) - 8
			height: 22.5
			width: 22.5
			radius: width
			color: internal.updateCircleColor(root.hue, root.saturation)
			border {
				color: "white"
				width: 1
			}
		}

		MouseArea {
			id : colorCircleArea

			function keepCursorIncolorCircleArea(mouse, colorCircleArea, colorCircleArea) {
				root.state = 'editing'
				if (mouse.buttons & Qt.LeftButton) {
					// cartesian to polar coords
					var distance = Math.sqrt(Math.pow(mouse.x-colorCircleArea.width/2,2)+Math.pow(mouse.y-colorCircleArea.height/2,2));
					var theta = Math.atan2(((mouse.y-colorCircleArea.height/2)*(-1)),((mouse.x-colorCircleArea.width/2)));

					// colorCircleArea limit
					if(distance > colorCircleArea.width/2)
						distance = colorCircleArea.width/2;

					// polar to cartesian coords
					var cursor = Qt.vector2d(0, 0);
					cursor.x = Math.max(-colorPicker.r, Math.min(colorCircleArea.width, distance*Math.cos(theta)+colorCircleArea.width/2)-colorPicker.r);
					cursor.y = Math.max(-colorPicker.r, Math.min(colorCircleArea.height, colorCircleArea.height/2-distance*Math.sin(theta)-colorPicker.r));

					hue = Math.ceil((Math.atan2(((cursor.y+colorPicker.r-colorCircleArea.height/2)*(-1)),((cursor.x+colorPicker.r-colorCircleArea.width/2)))/(Math.PI*2)+0.5)*100)/100
					saturation = Math.ceil(Math.sqrt(Math.pow(cursor.x+colorPicker.r-width/2,2)+Math.pow(cursor.y+colorPicker.r-height/2,2))/colorCircleArea.height*2*100)/100;
					root.updateHS(hue, saturation , 1, 1);
				}
			}

			anchors.fill: parent

			onPositionChanged: function (mouse) {
				colorPicker.color = internal.updateCircleColor(root.hue, root.saturation)
				root.targetColor = internal.updateCircleColor(root.hue, root.saturation)
				root.updateColor()
				keepCursorIncolorCircleArea(mouse, colorCircleArea,  colorCircleArea);
			}

			onPressed: function (mouse) {
				colorPicker.color = internal.updateCircleColor(root.hue, root.saturation)
				root.targetColor = internal.updateCircleColor(root.hue, root.saturation)
				root.updateColor()
				keepCursorIncolorCircleArea(mouse, colorCircleArea, colorCircleArea);
			}

			onReleased: {
				root.state = 'normal'
			}
		}
	}

	QtObject {
		id: internal

		function updateCircleColor(hue, saturation) {
			const rgba = Utils.hsvaToRgba(Qt.vector4d(hue, saturation, 1, 1));
			return Qt.rgba(rgba.x, rgba.y, rgba.z, rgba.w);
		}
	}
}
