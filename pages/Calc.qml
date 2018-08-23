import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../components" as Components
import "../controls" as Awesome

Item {
    id: page

    function fixValue(x, precision) {
        return Math.round(x*Math.pow(10,precision))/Math.pow(10,precision);
    }
    function getS(w_par, h_par, c_par, precision) {
        return fixValue(w_par*h_par*c_par, precision);
    }
    function getPrice(sab_par, precision) {
        return fixValue(sab_par*200, precision);
    }
    function sumS(precision) {
        var i;
        var sum = 0.0;
        for(i=0; i<modelWindowSizes.count; i++) {
            sum += getS(modelWindowSizes.get(i).width, modelWindowSizes.get(i).height, modelWindowSizes.get(i).count, precision);
        }
        return fixValue(sum, precision);
    }
    function sumPrices(precision) {
        var i;
        var sum = 0.0;
        for(i=0; i<modelWindowSizes.count; i++) {
            sum += getPrice(getS(modelWindowSizes.get(i).width, modelWindowSizes.get(i).height, modelWindowSizes.get(i).count, precision), precision);
        }
        return fixValue(sum, precision);
    }

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
                text: modelWindowSizes.count > 0 ? ("S' = " + sumS(3) + "\nЦена: " + sumPrices(3)) : ""
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
                    precision: 3
                    minimumValue: 0
                    maximumValue: 1000000.00
                    step: 0.001
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
                    precision: 3
                    minimumValue: 0
                    maximumValue: 1000000.00
                    step: 0.001
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
                        id: count_calc_property
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
                            property double s_ab: getS(width_calc_property.value, height_calc_property.value, count_calc_property.value, 3)
                            height: 50
                            anchors.fill: parent
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            font.pixelSize: 14
                            text: s_ab > 0.0 ? ("S' = " + s_ab + "\nЦена: " + getPrice(s_ab, 3)) : ""
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
                        //console.log("+")
                        if(width_calc_property.value > 0 && height_calc_property.value > 0)
                            modelWindowSizes.append({"width":width_calc_property.value,"height":height_calc_property.value,"count":count_calc_property.value})
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
            ListElement {
                width: 0.5
                height: 0.76
                count: 1
            }
            ListElement {
                width: 0.3
                height: 0.55
                count: 2
            }
        }

        ScrollView {
            id: items
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            contentWidth: parent.width
            ListView {
                width: parent.width
                model: modelWindowSizes
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
            Item {
                property bool isEdit: false
                width: parent.width
                height: 50
                Row {
                    anchors.fill: parent
                    Rectangle {
                        height: parent.height
                        width: parent.width
                        color: "#f1f1f1"
                        Rectangle {
                            id: rectSizeInfo
                            height: parent.height-4
                            width: 100
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            anchors.leftMargin: 2
                            color: "#f1f3ff"
                            border.color: Qt.darker(color, 1.2)
                            border.width: 1
                            Text {
                                id: textSizeWindow
                                text: model.width + " x " + model.height + ((model.count>1)?(" x" + model.count):"")
                                anchors.fill: parent
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                            }
                        }
                        Text {
                            id: info
                            property double s_ab: getS(model.width, model.height, model.count, 3)
                            text: "S' = " + s_ab + "\nЦена: " + getPrice(s_ab, 3);
                            anchors.left: rectSizeInfo.right
                            anchors.leftMargin: 10
                            height: parent.height
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }
    }
}
