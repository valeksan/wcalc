import QtQuick 2.7
import QtQuick.Controls 2.1

Rectangle {
    id: root
    property alias button: btn
    property bool collapsed: true
    property alias font: labelCategory.font
    property alias textColor: labelCategory.color
    property alias text: labelCategory.text
    property alias sourceIconArrowImage: iconArrowCategory.source
    property alias sourceIconArrowText: iconArrowText

    height: 40
    width: 100
    border.color: Qt.darker(color, 1.3)
    Label {
        id: labelCategory
        anchors.verticalCenter: parent.verticalCenter            
        verticalAlignment: "AlignVCenter"
        leftPadding: 10
    }
    Image {
        id: iconArrowCategory
        source: "" //"qrc:/img/leftmenu/arrow_category_hide.png"
        rotation: collapsed ? 0 : 180
        height: 24
        width: 24
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 5
        Text {
            id: iconArrowText
            anchors.fill: parent
            text: ""
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }    
    MouseArea {
        id: btn
        anchors.fill: parent
    }
}
