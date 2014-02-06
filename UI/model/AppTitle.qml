import QtQuick 2.0

Item{

    property string title: "Youme"

    Rectangle {
        width: parent.width; height: parent.height;
        color: "black"
    }

    Text {
        text: "Youme v0.1"
        color: "white"
        anchors.centerIn: parent;
    }
}
