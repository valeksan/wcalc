import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "../components" as Components

Item {
    id: page

    function fixFontSize(height, minHeight, fontStandartSize) {
        return ((height < minHeight) ? height*fontStandartSize/minHeight*1.0 : fontStandartSize);
    }

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
    function findWindow(w_par, h_par) {
        var i;
        var resultIndex = -1;
        for(i=0; i<modelWindowSizes.count; i++) {
            if(modelWindowSizes.get(i).width === w_par && modelWindowSizes.get(i).height === h_par) {
                resultIndex = i;
                break;
            }
        }
        return resultIndex;
    }
    function addWindow(w_par, h_par, c_par, precision) {
        var fixValueWidth = fixValue(w_par, precision);
        var fixValueHeight = fixValue(h_par, precision);
        var wIndex = -1;
        if(fixValueWidth > 0.0 && fixValueHeight > 0.0) {
            wIndex = findWindow(fixValueWidth, fixValueHeight);
            if(wIndex !== -1) {
                var prevCount = modelWindowSizes.get(wIndex).count;
                modelWindowSizes.setProperty(wIndex, "count", prevCount + c_par);
            } else {
                modelWindowSizes.append( {"width":fixValueWidth,"height":fixValueHeight,"count":c_par} );
            }
        }
    }
    function getLastWidth() {
        var count = modelWindowSizes.count;
        var width = count > 0 ? modelWindowSizes.get(count-1).width : 0;
        return width;
    }
    function getLastHeght() {
        var count = modelWindowSizes.count;
        var height = count > 0 ? modelWindowSizes.get(count-1).height : 0;
        return height;
    }

    Rectangle {
        id: controlPanel
        property int minHeight: 0.3*app.height
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        //height: 150+9
        height: minHeight < 100 ? 100 : minHeight
        color: appColors.pageBackgroundColor
        visible: !windowsAddPanel.hideControls
        Rectangle {
            id: result
            height: (parent.height-8)/3
            color: "#f1f3ff"
            border.color: Qt.darker(color, 1.2)
            border.width: 1
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 2
            anchors.leftMargin: 2
            width: parent.width-4
            Components.ScalebleLoader {
                x: 5
                height: parent.height
                width: parent.width-10
                minimumHeight: 50
                content: Text {
                    id: resultInfo
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 14
                    //text: modelWindowSizes.count > 0 ? ("S' = " + sumS(3) + (height < 50 ? "\t" : "\n") + "Цена: " + sumPrices(3)) : ""
                    text: modelWindowSizes.count > 0 ? ("S' = " + sumS(3) + "\n" + "Цена: " + sumPrices(3)) : ""
                }
            }
        }
        ColumnLayout {
            anchors.top: result.bottom
            anchors.topMargin: 2
            anchors.left: parent.left
            anchors.leftMargin: 2
            anchors.right: parent.right
            anchors.rightMargin: 2
            spacing: 2
            height: controlPanel.height-result.height-4
            RowLayout {
                spacing: 2
                Layout.fillWidth: true
                Components.NumBox {
                    id: width_calc_property
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    height: (controlPanel.height-8)/3
                    value: getLastWidth()
                    prefix: app.width < 250 ? "W: " : "Ширина: "
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
                    font.pixelSize: fixFontSize(height, 50, 14) // height < 50 ? height*14/50.0 : 14
                    fontInEditMode.pixelSize: fixFontSize(height, 50, 14)
                }
//                Text {
//                    text: "X"
//                    width: 30
//                    Layout.alignment: Qt.AlignVCenter
//                    horizontalAlignment: Text.AlignHCenter
//                    font.pixelSize: 16
//                    height: parent.height
//                }
                Components.NumBox {
                    id: height_calc_property
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    height: (controlPanel.height-8)/3
                    value: getLastHeght()
                    prefix: app.width < 250 ? "H: " : "Высота: "
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
                    font.pixelSize: fixFontSize(height, 50, 14)
                    fontInEditMode.pixelSize: fixFontSize(height, 50, 14)
                }
            }
            RowLayout {
                spacing: 2
                Layout.fillWidth: true
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    height: (controlPanel.height-8)/3
                    Components.NumBox {
                        id: count_calc_property
                        anchors.fill: parent
                        value: 1
                        prefix: app.width < 250 ? "x" : "Количество: x"
                        suffix: " шт"
                        visiblePrefixInEdit: false
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
                        font.pixelSize: fixFontSize(height, 50, 14)
                        fontInEditMode.pixelSize: fixFontSize(height, 50, 14)
                    }
                }
//                Text {
//                    text: ">"
//                    width: 30
//                    Layout.alignment: Qt.AlignVCenter
//                    horizontalAlignment: Text.AlignHCenter
//                    font.pixelSize: 16
//                    height: parent.height
//                }
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    height: (controlPanel.height-8)/3
                    Rectangle {
                        id: previewPanel
                        color: "#f1f3ff"
                        border.color: Qt.darker(color, 1.2)
                        border.width: 1
                        anchors.fill: parent
                        Components.ScalebleLoader {
                            anchors.fill: parent
                            minimumHeight: 50
                            content: Text {
                                id: previewText
                                property double s_ab: getS(width_calc_property.value, height_calc_property.value, count_calc_property.value, height_calc_property.precision)
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                                font.pixelSize: 14
                                text:  (s_ab > 0.0 ? "S' = " + s_ab + "\nЦена: " + getPrice(s_ab, height_calc_property.precision) : "")
                            }
                        }
                    }
                }
            }
        }
    }
    Rectangle {
        id: windowsAddPanel
        property bool hideControls: false
        property int minHeight: 0.1*app.minDim
        height: minHeight < 25 ? 25 : (minHeight > 50 ? 50 : minHeight)
        anchors.top: hideControls ? parent.top : controlPanel.bottom
        anchors.topMargin: 2
        anchors.left: parent.left
        anchors.right: parent.right
        color: appColors.headerBackgroundColor
        border.color: Qt.darker(color, 1.3)
        RowLayout {
            anchors.fill: parent
            spacing: 2
            Item {
                id: leftControls
                height: parent.height
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.minimumWidth: 40
                Components.ScalebleLoader {
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    content: Row {
                        spacing: 5
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
                            font.family: awesome.family
                        }
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
                height: parent.height
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumWidth: Math.max(height,60)
                Layout.minimumWidth: 30
                //Layout.minimumHeight: height
                visible: !windowsAddPanel.hideControls
                Components.ScalebleLoader {
                    anchors.fill: parent
                    anchors.margins: 4
                    content: Components.ButtonState {
                        id: btAddWindow
                        color: Qt.darker(windowsAddPanel.color, 1.1)
                        colorOff: Qt.darker(windowsAddPanel.color, 1.1)
                        colorOn: Qt.lighter(color, 1.1)
                        text: "+"
                        onClicked: {
                            //console.log("+")
                            addWindow(width_calc_property.value, height_calc_property.value, count_calc_property.value, height_calc_property.precision);
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

            Component.onCompleted: {
                append({ "width": 0.5, "height": 0.76, "count": 1 });
                append({ "width": 0.35, "height": 0.55, "count": 2 });
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
