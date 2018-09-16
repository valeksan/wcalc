import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

import "components" as Components

Item {
    id: body
    StackLayout {
        id: loadArea
        anchors.fill: parent
        currentIndex: app.showLeftMenu ? 1 : 0
        Loader {
            id: pageLoader
            function setPage(name) {
                switch(name) {
                case "Calc":
                    return "pages/Calc.qml";
                }
                return "pages/Calc.qml";
            }
            Layout.fillHeight: true
            Layout.fillWidth: true
            source: setPage(app.activePage)
        }
        Loader {
            id: menuLoader
            Layout.fillHeight: true
            Layout.fillWidth: true
            source: "pages/LeftMenu.qml"
        }
    }
}
