import QtQuick
import QtQml
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import QtQuick.Window

import CPalette 1.0

Item {
	id: root

	property QtObject paletteModel: nul

	Text {
		id: txt

		text: qsTr("Custom Color:")

		color: CPalette.layer6
	}
}
