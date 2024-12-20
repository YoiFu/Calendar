import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Window

Item {
	id: root

	readonly property int contentWidth: internal.contentWidth + internal.triWidth

	height: internal.contentHeight
	width: internal.contentWidth + internal.triWidth

	Rectangle {
		id: content

		height: internal.contentHeight
		width: internal.contentWidth
		radius: 8

		color: internal.popupColor

		anchors {
			verticalCenter: parent.verticalCenter
			left: parent.left
		}

		ColumnLayout {
			id: contentLayout

			anchors {
				horizontalCenter: parent.horizontalCenter
				top: parent.top
				topMargin: 30
			}

			width: 160
			spacing: 0

			ColorCircle {
				id: colorCircle

				Layout.alignment: Qt.AlignHCenter
				Layout.preferredHeight: 120
				Layout.preferredWidth: 120
			}

			ColorAlphaSlider {
				Layout.fillWidth: true
				Layout.topMargin: 10
			}

			ColorDetails {
				Layout.fillWidth: true
				Layout.topMargin: 4
			}

			ColorTemplate {
				Layout.fillWidth: true
				Layout.topMargin: 8
			}
		}
	}

	Item {
		id: wrapper


		height: internal.triHeight
		width: internal.triWidth

		anchors {
			verticalCenter: parent.verticalCenter
			left: content.right
		}

		Canvas {
			id: triangle

			property list<point> points: {
				var arr = [
							{x: triangle.x, y: triangle.y},
							{x: triangle.x + internal.triWidth, y: triangle.y + internal.triHeight/2},
							{x: triangle.x, y: triangle.y + internal.triHeight}
						];

				return arr;
			}

			anchors.fill: parent

			onPaint: {
				var ctx = getContext("2d");
				ctx.lineWidth = 1;
				ctx.beginPath();
				ctx.moveTo(triangle.points[0].x, triangle.points[0].y);
				for (let i = 1; i < points.length; i++) {
					ctx.lineTo(triangle.points[i].x, triangle.points[i].y);
				}
				ctx.closePath();

				ctx.fillStyle = internal.popupColor;
				ctx.fill();
			}
		}
	}

	QtObject {
		id: internal

		readonly property int contentHeight: 270
		readonly property int contentWidth: 200
		readonly property int triHeight: 12
		readonly property int triWidth: 8
		readonly property color popupColor: "#4B5945"
	}
}
