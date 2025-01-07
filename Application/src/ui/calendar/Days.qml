import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import CPalette 1.0

Item {
    id: root

    property QtObject temporalObject: nullptr
    property color dayInWeekColor: CPalette.layer2
    property color nonDayInWeekColor: CPalette.layer3
    property color currentDay: CPalette.layer4

    width: 310
    height: 198

    RowLayout {
        id: daysInWeek

        anchors.horizontalCenter: parent.horizontalCenter

        width: root.width
        height: 30
        spacing: 0

        Repeater {
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: internal.dayOfWeek

            delegate: Item {
                id: textWrapper
                required property int index

                width: daysInWeek.width / internal.dayOfWeek
                height: parent.height

                Text {
                    anchors.centerIn: parent

                    text: temporalObject.getDayName(textWrapper.index)
                    font.pixelSize: 14
                    font.bold: true
                    horizontalAlignment: Qt.AlignHCenter
                    elide: Text.ElideMiddle

                    color: CPalette.layer1
                }
            }
        }
    }

    GridLayout {
        id: days

        anchors {
            horizontalCenter: root.horizontalCenter
            top: daysInWeek.bottom
            topMargin: 28
        }

        width: root.width
        height: root.height - daysInWeek.height

        property bool realMonth: temporalObject.realCurrentMonth

        anchors.fill: parent

        columns: 7
        columnSpacing: 0
        rows: 6
        rowSpacing: 0

        layoutDirection: GridView.FlowLeftToRight

        Repeater {
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            model: temporalObject.daysInCalendar

            delegate: Item {
                id: dayDelegate

                required property var modelData
                property color dayColor: (modelData.day === temporalObject.today && days.realMonth) ? CPalette.layer4 : root.dayInWeekColor

                function correctColor(dayInCurrentMonth) {
                    if (dayInCurrentMonth) {
                        return dayDelegate.dayColor;
                    }
                    return root.nonDayInWeekColor;
                }

                width: days.width / internal.dayOfWeek
                height: width - 8

                anchors.leftMargin: (daysInWeek.width - internal.numberOfRow * 34)/ internal.numberOfColumn

                Rectangle {
                    id: singleDay

                    property bool isTrueDay: modelData.day === temporalObject.today && modelData.rightMonth && days.realMonth

                    anchors.centerIn: parent

                    width: parent.width - 10
                    height: width
                    radius: width

                    border.color: !isTrueDay ? CPalette.layer1 : CPalette.background2
                    border.width: 0

                    MouseArea {
                        id: dayBackground

                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            if (singleDay.border.width === 1) {
                                singleDay.border.width = 0;
                                day.color = dayDelegate.correctColor(modelData.rightMonth)
                            } else {
                                singleDay.border.width = 1;
                                day.color = CPalette.layer1;
                            }
                        }
                    }

                    states: [
                        State {
                            when: singleDay.isTrueDay && !dayBackground.containsMouse
                            PropertyChanges {
                                target: singleDay
                                color: CPalette.layer1
                            }
                        },
                        State {
                            when: singleDay.isTrueDay && dayBackground.containsMouse
                            PropertyChanges {
                                target: singleDay
                                color: CPalette.layerHover1
                            }
                        },
                        State {
                            when: !singleDay.isTrueDay && dayBackground.containsMouse
                            PropertyChanges {
                                target: singleDay
                                color: {
                                    return Qt.rgba(
                                                CPalette.layer1.r,
                                                CPalette.layer1.g,
                                                CPalette.layer1.b,
                                                0.5
                                                );
                                }
                            }
                        },
                        State {
                            when: !singleDay.isTrueDay && !dayBackground.containsMouse
                            PropertyChanges {
                                target: singleDay
                                color: "transparent"
                            }
                        }
                    ]
                }

                Text {
                    id: day

                    text: modelData.day

                    anchors.centerIn: parent
                    font.pixelSize: 14
                    color: dayDelegate.correctColor(modelData.rightMonth)
                }
            }
        }
    }

    QtObject {
        id: internal

        readonly property int numberOfColumn: 6
        readonly property int numberOfRow: 7
        readonly property int dayOfWeek: 7
    }
}
