import QtQuick
import QtQml
import QtQuick.Controls
import Qt5Compat.GraphicalEffects
import QtQuick.Window

Item {
    id: root

    property bool openPopup: false

    height: internal.outerRadius
    width: internal.outerRadius

    onOpenPopupChanged: function() {
        if (openPopup) {
            popup.open();
        } else {
            popup.close();
        }
    }

    Rectangle {
        id: outter

        anchors.fill: parent

        radius: internal.outerRadius

        border.width: 1
        border.color: "#000000"

        color: "transparent"

        visible: root.openPopup
    }

    Rectangle {
        id: inner

        anchors.centerIn: parent

        height: internal.innerRadius
        width: internal.innerRadius

        radius: internal.innerRadius

        color: "red"

        MouseArea {
            id: mouse

            anchors.fill: parent
            onClicked: {
                root.openPopup = !root.openPopup;
            }
        }
    }

    Loader {
        id: colorPickerLoader

        sourceComponent: ColorPickerPopup {
            anchorItem: root
        }
    }

    QtObject {
        id: internal

        readonly property int outerRadius: 24
        readonly property int innerRadius: 20
    }
}


