import QtQuick 2.9
import QtQuick.Layouts 1.3

import "components" as Components

Rectangle {
    id: pageHeader
    color: appColors.headerBackgroundColor
    border.color: Qt.darker(color, 1.3)
    height: headerHeight
    RowLayout {
        id: leftToolBar
        anchors {
            top: parent.top
            topMargin: 5
            bottom: parent.bottom
            bottomMargin: 5
            left: parent.left
            leftMargin: 5
        }
        spacing: 3

        // Кнопка вызова меню
        Item {
            height: headerHeight-10
            Layout.fillHeight: true
            width: height
            Components.MenuBackIcon {
                id: menuBackIcon
                anchors.fill: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if(menuBackIcon.state === "menu") {
                        menuBackIcon.state = "back";
                        app.showLeftMenu = true;
                    } else {
                        menuBackIcon.state = "menu";
                        app.showLeftMenu = false;
                    }
                }
            }
        }

//        Rectangle {
//            height: 48
//            width: 48
//            radius: 5
//            color: (!showLeftMenu) ? appColors.headerBackgroundColor : appColors.collapseMenuCategoryColor
//            Item {
//                height: parent.height-6
//                width: parent.width-6
//                anchors.centerIn: parent
//                Image {
//                    id: img_icon_menu
//                    anchors.fill: parent
//                    source: "qrc:/img/menu.png"
//                }
//                MouseArea {
//                    id: menu_mousearea
//                    anchors.fill: parent
//                    onPressed: {
//                        if(showLeftMenu) {
//                            showLeftMenu = false
//                            //console.log("showLeftMenu = false")
//                        } else {
//                            showLeftMenu = true
//                            //console.log("showLeftMenu = true")
//                        }
//                    }
//                }
//            }
//        }
        Rectangle { width: 5 }
    }
}
