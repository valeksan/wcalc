import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../components" as Components
import "../controls" as Awesome

Item {
    id: page
    Rectangle {
        id: controlPanel
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 150+9
        color: appColors.pageBackgroundColor
        Rectangle {
            id: result
            height: 50
            color: "#f1f3ff"
            border.color: Qt.darker(color, 1.2)
            border.width: 1
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 2
            anchors.leftMargin: 2
            width: parent.width-4
            Text {
                id: resultInfo
                height: 50
                width: parent.width-10
                x: 5
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
                text: "#"
            }
        }
        ColumnLayout {
            anchors.top: result.bottom
            anchors.topMargin: 2
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.right: parent.right
            anchors.rightMargin: 2
            Layout.fillHeight: true
            Layout.fillWidth: true
            spacing: 2
            RowLayout {
                spacing: 2
                Layout.fillWidth: true
                Components.NumBox {
                    id: width_calc_property
                    Layout.fillWidth: true
                    height: 50
                    value: 0
                    prefix: "Ширина: "
                    suffix: " м"
                    editable: true
                    precision: 2
                    minimumValue: 0.00
                    maximumValue: 1000000.00
                    step: 0.01
                    buttonsAlignType: 0
                    onFinishEdit: {
                        //console.log(number)
                        value = number
                    }
                }
                Text {
                    text: "X"
                    width: 30
                    Layout.alignment: Qt.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                }
                Components.NumBox {
                    id: height_calc_property
                    Layout.fillWidth: true
                    height: 50
                    value: 0
                    prefix: "Высота: "
                    suffix: " м"
                    editable: true
                    precision: 2
                    minimumValue: 0.00
                    maximumValue: 1000000.00
                    step: 0.01
                    buttonsAlignType: 0
                    onFinishEdit: {
                        //console.log(number)
                        value = number
                    }
                }
            }
            RowLayout {
                spacing: 2
                Item {
                    Layout.fillWidth: true
                    height: 50
                    Components.NumBox {
                        id: width_calc_x
                        anchors.fill: parent
                        value: 1
                        prefix: "Количество: x"
                        suffix: " шт"
                        editable: true
                        precision: 0
                        minimumValue: 1
                        maximumValue: 1000000
                        step: 1
                        buttonsAlignType: 0
                        onFinishEdit: {
                            //console.log(number)
                            value = number
                        }
                    }
                }
                Text {
                    text: "="
                    width: 30
                    Layout.alignment: Qt.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                }
                Item {
                    Layout.fillWidth: true
                    height: 50
                    Rectangle {
                        id: previewPanel
                        height: 50
                        color: "#f1f3ff"
                        border.color: Qt.darker(color, 1.2)
                        border.width: 1
                        anchors.fill: parent
                        Text {
                            id: previewText
                            height: 50
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 14
                            text: "..."
                        }
                    }
                }
            }
        }
    }
    Rectangle {
        id: windowsAddPanel
        property bool hideControls: false
        height: 50
        anchors.top: hideControls ? parent.top : controlPanel.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        color: appColors.headerBackgroundColor
        border.color: Qt.darker(color, 1.3)
        RowLayout {
            anchors.fill: parent
            spacing: 2
            Item {
                height: 50
                Layout.fillWidth: true
                Row {
                    spacing: 5
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    Text {
                        id: titleWindowsList
                        text: qsTr("Окна")
                        font.pixelSize: 16
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                    }
                    Text {
                        id: iconTitle
                        text: awesome.loaded ? (!windowsAddPanel.hideControls ? awesome.icons.fa_angle_down : awesome.icons.fa_angle_up) : ""
                        font.pixelSize: 16
                        font.bold: true
                        height: parent.height
                        renderType: Text.NativeRendering
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        windowsAddPanel.hideControls = !windowsAddPanel.hideControls;
                    }
                }
            }
            Item {
                height: 50
                Layout.fillWidth: true
                Layout.maximumWidth: 150
                visible: !windowsAddPanel.hideControls
                Components.ButtonB {
                    id: btAddWindow
                    anchors.fill: parent
                    anchors.margins: 4
                    color: Qt.darker(windowsAddPanel.color, 1.1)
                    colorOff: Qt.darker(windowsAddPanel.color, 1.1)
                    colorOn: Qt.lighter(color, 1.1)
                    text: "+"
                    onClicked: {
                        console.log("+")
                    }
                    onPressed: {
                        state = "on"
                    }
                    onReleased: {
                        state = "off"
                    }
                }
            }
        }
    }
    Rectangle {
        id: windowsListPanel
        anchors.top: windowsAddPanel.bottom
        anchors.topMargin: 2
        anchors.left: parent.left
        anchors.leftMargin: 2
        anchors.right: parent.right
        anchors.rightMargin: 2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 2
        clip: true

        ListModel {
            id: modelWindowSizes
        }

        ScrollView {
            id: items
            anchors.fill: parent
            ListView {
                width: parent.width
                model: 20
                delegate: delegateWindowSizeListItem
                spacing: 2
            }
        }

        Component {
            id: delegateWindowSizeListItemTest
            ItemDelegate {
                text: "Item " + (index + 1)
                width: parent.width
            }
        }

        Component {
            id: delegateWindowSizeListItem
            ItemDelegate {
                property bool isEdit: false

                text: "Item " + (index + 1)

                width: parent.width
                height: 50
                Row {
                    anchors.fill: parent
                    Rectangle {
                        height: parent.height
                        width: parent.width
                        color: "#f1f1f1"
                    }
                }
            }
        }
    }
}
