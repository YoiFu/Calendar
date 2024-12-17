import QtQuick
import QtQml
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.Window

Popup {
    id: root

    property int preferredEdge: Qt.LeftEdge
    property Item anchorItem: null

    Canvas {
        id: triangle

        property list<point> points: {
            var arr = [
                {x: root.x, y: root.y},
                {x: root.x + internal.width, y: root.y + internal.height/2},
                {x: root.x, y: root.y + internal.height}
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

    QtObject {
        id: internal

        readonly property int height: 12
        readonly property int width: 10
        readonly property color popupColor: "#4B5945"

        readonly property var windowContentItem: root.anchorItem
                                                 && root.anchorItem.Window.window ? root.anchorItem.Window.contentItem : null


        function getWindowMappedAnchorPos() {
            if (!windowContentItem) {
                return Qt.point(0, 0);
            }

            return windowContentItem.mapFromItem(root.anchorItem.parent, root.anchorItem.x, root.anchorItem.y);
        }

        function updatePositioning() {
            windowMappedAnchorPos = getWindowMappedAnchorPos();
            positioning = getPositioning();
        }
    }
}
