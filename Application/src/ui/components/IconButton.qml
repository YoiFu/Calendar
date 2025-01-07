import QtQuick
import QtQuick.Controls
import QtQuick.Templates as T

import CPalette 1.0

MaskedImage {
	id: root

	property bool containMouse: mouseArea.containsMouse

	signal clicked
	signal released
	signal triggered

	fillMode: Image.PreserveAspectFit
	sourceSize: internal.defaultIconSize
	color: root.containMouse ? CPalette.layerHover2 : CPalette.layer2

	MouseArea {
		id: mouseArea

		anchors.fill: parent

		hoverEnabled: true
		onClicked: {
			root.clicked();
		}
		onReleased: function() {
			timer.stop();
			root.released();
		}
		onPressAndHold: function() {
			timer.start();
		}
	}

	Timer {
		id: timer

		interval: 10
		running: false
		repeat: true
		onTriggered: {
			root.triggered();
		}
	}

	QtObject {
		id: internal

		readonly property size defaultIconSize: Qt.size(16, 16)
	}
}
