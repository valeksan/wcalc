import QtQuick 2.7
import QtQuick.Controls 2.1

Rectangle {
    property alias button: btn
    property string iconSrc: ""
    property alias font: labelButton.font
    property alias textColor: labelButton.color
    property alias text: labelButton.text
    height: hiddenAttr ? 0 : 40
    visible: height > 0
    width: 100
    Row {
        height: parent.height-4
        width: parent.height
        spacing: 5
        anchors {
            verticalCenter: parent.verticalCenter
        }
        Item {
            width: parent.height
            height: parent.height
            Image {
                id: icon_button
                width: parent.width/2
                height: parent.width/2
                source: iconSrc
                mipmap: true
                anchors.centerIn: parent                
            }
        }
        Label {
            id: labelButton            
            height: parent.height            
            verticalAlignment: "AlignVCenter"            
        }
    }
    MouseArea {
        id: btn
        anchors.fill: parent
    }
}
