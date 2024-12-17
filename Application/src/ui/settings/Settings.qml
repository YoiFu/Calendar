import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root

    radius: 4

    implicitHeight: 270
    implicitWidth: 200

    component SettingsTextWithComponent: RowLayout {
        id: template

        property alias sourceComponent: loader.sourceComponent
        property alias text: txt.text

        height: 10
        spacing: 0

        Text {
            id: txt

            Layout.preferredHeight: parent.height
            verticalAlignment: Text.AlignVCenter
        }

        Item {
            Layout.fillWidth: true
        }

        Loader {
            id: loader
        }
    }

    ColumnLayout {
        id: layout

        anchors {
            fill: parent
            topMargin: internal.verticalMargin
            bottomMargin: internal.verticalMargin
            rightMargin: internal.horizontalMargin
            leftMargin: internal.horizontalMargin
        }

        spacing: 8

        SettingsTextWithComponent {
            text: "Text Color"
            sourceComponent: ColorPicker{}
        }

        SettingsTextWithComponent {
            text: "Background Color"
            sourceComponent: ColorPicker{}
        }

        SettingsTextWithComponent {
            text: "Accent Color"
            sourceComponent: ColorPicker{}
        }

        SettingsTextWithComponent {
            text: "Background"
            sourceComponent: ColorPicker{}
        }

        Item {
            Layout.fillHeight: true
        }
    }

    QtObject {
        id: internal

        readonly property int verticalMargin: 8
        readonly property int horizontalMargin: 8
    }
}
