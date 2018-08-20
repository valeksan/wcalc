import QtQuick 2.9
import QtQuick.Controls 2.2

import "components" as Components

Item {
    id: body
//    anchors.fill: parent
    Rectangle {
        id: loadArea
        anchors.fill: parent

        Loader {
            id: pageLoader
            function setPage(name) {
                switch(name) {
                case "Calc":
                    return "pages/Calc.qml";
                }
                return "pages/Calc.qml";
            }
            anchors.fill: parent
            source: app.showLeftMenu ? "pages/LeftMenu.qml" : setPage(app.activePage)
        }
    }
}
