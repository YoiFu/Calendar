import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Item {
    id: root

    signal hide
    signal shrink
    signal close

    implicitWidth: childrenRect.width
    implicitHeight: childrenRect.height

    component FButton: Rectangle {
        id: btn

        property alias source: icon.source
        signal clicked

        height: 16
        width: 16
        radius: width

        Image {
            id: icon

            height: 8
            width: 8
            fillMode: Image.PreserveAspectCrop
            anchors.centerIn: parent

            visible: mouseArea.containsMouse
        }

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            hoverEnabled: true

            onClicked: btn.clicked()
        }
    }

    RowLayout {
        spacing: 4

        FButton {
            color: "#D9D9D9"
            source: "../assets/Hide.svg"
            onClicked: {
                root.hide()
            }
        }
        FButton {
            color: "#65DF80"
            source: "../assets/Shrink.svg"
            onClicked: {
                root.shrink()
            }
        }
        FButton {
            color: "#F27474"
            source: "../assets/Close.svg"
            onClicked: {
                root.close()
            }
        }
    }
}
