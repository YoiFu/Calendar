import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Window

Item {
    id: root

    Rectangle {
        id: content

        height: 270
        width: 200

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
        }
    }

    Item {
        id: wrapper


        height: internal.height
        width: internal.width

        anchors {
            horizontalCenter: parent.horizontalCenter
            left: content.right
        }

        Canvas {
            id: triangle

            property list<point> points: {
                var arr = [
                    {x: wrapper.x, y: wrapper.y},
                    {x: wrapper.x + internal.width, y: wrapper.y + internal.height/2},
                    {x: wrapper.x, y: wrapper.y + internal.height}
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

        readonly property int height: 12
        readonly property int width: 10
        readonly property color popupColor: "#4B5945"
    }
}
