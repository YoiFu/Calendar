import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: root

    property QtObject model: null

    implicitHeight: internal.delegateHeight
    implicitWidth: internal.delegateWidth

    Image {
        id: deviceImage

        anchors.centerIn: parent
        anchors.topMargin: 45

        x: internal.horizontalPosition(deviceImage) + internal.deviceImageHorizontalOffset
        y: internal.verticalPosition(deviceImage) + internal.deviceImageVerticalOffset
        fillMode: Image.PreserveAspectFit
        cache: false

        source: internal.deviceImageSource
        sourceSize: internal.imageSize

        ColumnLayout {
            id: content

            anchors.centerIn: parent

            Image {
                id: overlayIcon

                Layout.alignment: Qt.AlignCenter
                sourceSize: Qt.size(11,11)
                fillMode: Image.PreserveAspectFit

                source: internal.corsairLogoSource
            }

            Text {
                id: overlayTitle

                Layout.alignment: Qt.AlignCenter
                font: CueFonts.keyMedium
                color: CuePalette.layer8
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap

                text: "Your new XENEON EDGE has been detected."
            }

            Text {
                id: overlayDescription

                Layout.alignment: Qt.AlignCenter
                font: CueFonts.keySmall
                color: CuePalette.layer7
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap

                text: "To ensure proper functionality, proceed to the Setup Wizard. Click “Run Wizard” to start the screen setup process."
            }
        }
    }

    QtObject {
        id: internal

        property string deviceImageSource: "qrc:///dash_accessory_lcd/assets/vertical.png"
        property string corsairLogoSource: "qrc:///dash_accessory_lcd/assets/corsair_logo.svg"
        readonly property real delegateHeight: 270
        readonly property real delegateWidth: 960
        readonly property size imageSize: Qt.size(82, 294)
        readonly property int deviceImageHorizontalOffset: 0
        readonly property int deviceImageVerticalOffset: 0

        function horizontalPosition(item) {
            return (root.width - item.width) / 2;
        }

        function verticalPosition(item) {
            return Math.round((root.height - item.height) / 2);
        }
    }
}
