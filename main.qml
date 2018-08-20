import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.0
import QtQuick.Layouts 1.3

import "components" as Components
import "controls" as Awesome

ApplicationWindow {
    id: app
    visible: true
    title:   qsTr("Smart home")
    width:  Screen.desktopAvailableWidth
    height: Screen.desktopAvailableHeight

    property int headerHeight: height <= 320 ? 0.1*height : 50
    property int footerHeight: 0

    property int minimumPageHeight: 320-headerHeight-footerHeight
    property int minimumPageWidth: 240

    property int dpi: Screen.pixelDensity * 25.4
    property int minDim: Math.min(width, height)
    property bool showLeftMenu: false
    property string activePage: "Calc"

    function dp(x) {
        if(dpi < 120) {
            return x; // For the usual computer monitor
        } else {
            return x*(dpi/160);
        }
    }

    Colors {
        id: appColors
    }

    FontAwesome {
        id: awesome
        resource: "qrc:///fonts/fontawesome-webfont.ttf"
    }
//    Text {
//        text: awesome.icons.fa_angle_down
//    }

    header: AppHeader {
        id: appHeader
    }

    AppBody {
        id: appBody
        height: app.height - app.header.height - app.footer.height
        width: app.width
    }

    background: Rectangle {
        color: appColors.appBackgroundColor
    }

    footer: Rectangle {
        id: appFooter
    }

}
