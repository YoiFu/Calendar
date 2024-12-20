import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

GridLayout {

    flow: GridLayout.LeftToRight

    Repeater {
        model: null
    }

    QtObject {
        id: internal

        readonly property color colorModel: [
            "red",
            "blue",
            "green",
            "yellow",
            "purple",
            "violet",
            // Qt.rgba()
        ]
    }
}
