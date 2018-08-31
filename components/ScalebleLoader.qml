import QtQuick 2.7

Item {
    id: root_component
    height: 0
    width: 0
    property int minimumHeight: 0
    property int minimumWidth: 0
    property alias content: loader.sourceComponent
    property alias sourceQml: loader.source
    property alias loaded: loader.loaded
    property alias origin: loader.transformOrigin


    /* Системные методы масштабирования */
    function fixScale() {
        if(height < minimumHeight || width < minimumWidth) {
            return Math.min(height/minimumHeight, width/minimumWidth);
        }
        return 1.0;
    }

    /* Подгрузчик масштабируемых контролов */
    Loader {
        id: loader
        property bool loaded: false
        onStatusChanged: (status === Loader.Ready) ?  loaded = true : loaded = false
        anchors.centerIn: parent
        height: parent.height
        width: parent.width
        scale: fixScale()
        transformOrigin: Item.Center
    }
}
