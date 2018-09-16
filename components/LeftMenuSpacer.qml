import QtQuick 2.7
import QtQuick.Controls 2.1

ItemDelegate {
    height: hiddenAttr ? 0 : 10
    visible: height > 0
    width: 100
    background: Rectangle {
        color: "transparent"
    }
}
