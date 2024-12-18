import QtQuick
import QtQml
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.Window

Popup {
    id: root

    property int preferredEdge: Qt.LeftEdge
    property Item anchorItem: null
    readonly property int popUpWidth: content.contentWidth

    padding: 0

    contentItem: ColorPickerContent {
        id: content
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
