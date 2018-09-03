import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Window 2.0
import QtQuick.Layouts 1.3

import Qt.labs.settings 1.0

import "components" as Components

ApplicationWindow {
    id: app
    visible: true
    title:   qsTr("Smart home")
    minimumWidth: minimumPageWidth

    function isDesktopApp() {
        return Qt.platform.os === "linux" || Qt.platform.os === "unix" || Qt.platform.os === "windows";
    }

    width:  isDesktopApp() ? 240 : Screen.desktopAvailableWidth
    height: isDesktopApp() ? 300 : Screen.desktopAvailableHeight

    property int headerHeight: 0.1*minDim < 25 ? 25 : (0.1*minDim > 50 ? 50 : 0.1*minDim)
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

    Settings {
        id: cfg
        category: "App"
        property string currency: "руб"
        property double d_w: 0.1
        property double d_h: 0.1
        property double d_price: 100
        property double s_price: 400
        property double s_minimum: 4.0
        property double price_per_count: 100
    }

    Colors {
        id: appColors
    }

    FontAwesome {
        id: awesome
        resource: "qrc:///fonts/fontawesome-webfont.ttf"
    }

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
