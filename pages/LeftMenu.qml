import QtQuick 2.7
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.3

import QtQuick.Dialogs 1.2

import "../components" as Components

Item {
    id: menu_global_area

    property var delegateComponentMap: {
        "category": categoryMenuComponent,
        "space": spaceMenuComponent,
        "button": buttonMenuComponent,
    }

    signal buttonMenuClicked(var name);

    // Модель меню
    ListModel {
        id: modelLeftMenu
        //-------------------------
//        ListElement { text: "ФАЙЛ"; type: "category"; name: "category_file"; hidden: false }
//        ListElement { type: "space"; group: "category_service"; hidden: false; }
        //-------------------------
        ListElement { text: "СЕРВИС";   type: "category"; name: "service"; hidden: false }
        ListElement { text: "Калькулятор"; type: "button"; name: "Calc"; iconSrc: ""; iconText:""; group: "service"; hidden: false }
        ListElement { text: "Настройки"; type: "button"; name: "Calc"; iconSrc: ""; iconText:""; group: "service"; hidden: false }
        ListElement { type: "space"; group: "service"; hidden: false; }
        //-------------------------
        ListElement { text: "СПРАВКА"; type: "category"; name: "help"; hidden: false }
        ListElement { text: "О программе"; type: "button"; name: "About"; iconSrc: ""; iconText:""; group: "help"; hidden: false }
        ListElement { type: "space"; group: "help"; hidden: false; }
    }

    // Внешнее обрамление меню
    Rectangle {
        id: menu_body
        width: parent.width
        color: appColors.pageBackgroundColor
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        border.color: Qt.darker(appColors.headerBackgroundColor, 1.3)

        // Заголовок
        Item {
            id: menu_header
            height: 80
            width: parent.width
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
            }
        }
        // Тело
        // Слой отображения плавающего меню
        ColumnLayout {
            id: leftMenuLayout
            anchors {
                top: parent.top
                topMargin: 10
                left: parent.left
                leftMargin: 10
                right: parent.right
                rightMargin: 10
                bottom: parent.bottom
                bottomMargin: 60
            }
            ListView {
                id: listView
                spacing: 1
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                cacheBuffer: 320
                snapMode: ListView.SnapToItem
                boundsBehavior: Flickable.OvershootBounds
                flickableDirection: Flickable.VerticalFlick
                model: modelLeftMenu
                delegate: Loader {
                    // Загрузчик компонентов
                    id: delegateLoader
                    function toCorrectString(value, default_value) {
                        return ( (value === undefined) ? default_value : value );
                    }
                    function toCorrectBool(value, default_value) {
                        return ( (value === undefined) ? default_value : value );
                    }

                    width: listView.width
                    sourceComponent: delegateComponentMap[type]
                    property string labelText: toCorrectString(text, "")
                    property ListView view: listView
                    property int ourIndex: index
                    property string nameAttr: toCorrectString(name, "")
                    property string iconAttr: toCorrectString(iconSrc, "")
                    property string iconSymbolAttr: toCorrectString(iconText, "")
                    property string groupAttr: toCorrectString(group, "")
                    property bool hiddenAttr: toCorrectBool(hidden, false)
                }
                ScrollIndicator.vertical: ScrollIndicator { }
            }
        }
    }
    Rectangle {
        width: 1
        height: menu_body.height
        anchors.right: menu_body.right
        color: Qt.darker(menu_body.color, 1.8)
    }

    // Индикатор выпадающего меню
    Rectangle {
        id: ind_menu
        visible: !showLeftMenu
        opacity: 0.0
        width: 10
        height: menu_body.height
        anchors.left: menu_body.right
        anchors.verticalCenter: parent.verticalCenter
        color: menu_body.color
        MouseArea {
            id: indMenuMouseArea
            anchors.fill: parent
            enabled: !showLeftMenu
            hoverEnabled: !hideActionPanelMouseArea.hoverEnabled
            onEntered: {
                ind_menu.opacity = 0.8
            }
            onExited: {
                ind_menu.opacity = 0.0
            }
            onHoverEnabledChanged: {
                if(!hoverEnabled) {
                    ind_menu.opacity = 0.0
                }
            }
            onClicked: {
                showLeftMenu = true
            }
        }
        Behavior on opacity {
            NumberAnimation {
                duration: 400
                easing.type: "InOutQuad"
            }
        }
    }
    // Выпирающая скрытая область активации меню
    Item {
        id: hideActionPanel
        width: 150
        anchors {
            left: menu_body.right
            top: parent.top
            bottom: parent.bottom
        }
        MouseArea {
            id: hideActionPanelMouseArea
            property int dx: 0
            anchors.fill: parent
            enabled: !showLeftMenu
            propagateComposedEvents: true
            onPressed: {
                if(mouseX < 15) {
                    dx = mouseX
                    hoverEnabled = true
                } else {
                    mouse.accepted = false
                }
            }
            onReleased: {
                if(mouseX - dx > 60) {
                    showLeftMenu = true
                    hoverEnabled = false
                } else {
                    hoverEnabled = false
                    mouse.accepted = false
                }
            }
        }
    }

    /// ЗАГРУЖАЕМЫЕ КОМПОНЕНТЫ:
    // - категория
    Component {
        id: categoryMenuComponent
        Components.LeftMenuCategory {
            text: labelText
            font.pixelSize: 24
            font.bold: true
            textColor: "black"
            color: button.pressed ? Qt.darker(appColors.headerBackgroundColor, 1.7) : appColors.headerBackgroundColor
            button.onClicked: {
                var i;
                if(collapsed) {
                    // свернуть
                    for(i = 0; i < modelLeftMenu.count; i++) {
                        if(modelLeftMenu.get(i).group === nameAttr) {
                            modelLeftMenu.setProperty(i, "hidden", true)
                        }
                    }
                    collapsed = false;
                } else {
                    // развернуть
                    for(i = 0; i < modelLeftMenu.count; i++) {
                        if(modelLeftMenu.get(i).group === nameAttr) {
                            modelLeftMenu.setProperty(i, "hidden", false)
                        }
                    }
                    collapsed = true;
                }
            }            
        }
    }
    // - кнопка с иконкой
    Component {
        id: buttonMenuComponent
        Components.LeftMenuButton {
            text: labelText
            iconSrc: iconAttr
            font.pixelSize: 22*height/40
            textColor: "black"
            color: button.pressed ? Qt.darker(appColors.headerBackgroundColor, 1.7) : Qt.lighter(appColors.headerBackgroundColor, 1.1)
            border.color: Qt.darker(appColors.headerBackgroundColor, 1.1)
            button.onReleased: {
                menu_global_area.buttonMenuClicked(nameAttr);
            }
            Behavior on height {
                NumberAnimation {
                    duration: 400
                    easing.type: "InOutQuad"
                }
            }
        }
    }    
    // - разделитель (пространство)
    Component {
        id: spaceMenuComponent
        Components.LeftMenuSpacer { }
    }
    //--------------------------------
}
