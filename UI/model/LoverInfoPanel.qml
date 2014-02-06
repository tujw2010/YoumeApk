import QtQuick 2.0
import QtQuick.Layouts 1.0

Item {
    id: loverInfoPanel
    state: "hidden"
    visible: false;

    Row {
        anchors.fill: parent;

        Rectangle {
            id: maskLayer
            width:77; height:parent.height;
            color: "black"

            MouseArea {
                anchors.fill: parent;
                onClicked: {
                    loverInfoPanel.state = "hidden"
                }
            }
        }

        Rectangle {
            id: contentArea
            width: parent.width; height: parent.height
            color:"gray"

            GridLayout {
                id: grid
                columns: 2
                anchors.left: parent.left; anchors.leftMargin: 18
                anchors.top: parent.top; anchors.topMargin: 5

                Text { text: "距离:" }
                Text { text: "1.98 km" }
                Text { text: "城市:" }
                Text { text: "佛山-禅城  百度地图查看" }
                Text { text: "心情:" }
                Text { text: "思恋" }
                Text { text: "..." }
            }
        }
    }

    states: [
        State {
            name: "show"
            PropertyChanges {
                target: maskLayer
                opacity:0.4
                width: 77
            }
            PropertyChanges {
                target: contentArea
                opacity:1
            }
            PropertyChanges {
                target: loverInfoPanel
                x:0;
            }
        },
        State {
            name: "hidden"
            PropertyChanges {
                target: maskLayer
                opacity:0
                width: 100
            }
            PropertyChanges {
                target: contentArea
                opacity:0
            }
            PropertyChanges {
                target: loverInfoPanel
                x:77
            }
        }
    ]

    transitions: Transition {

        property bool flag: false;

        onRunningChanged: {
            if(flag == false) {
                loverInfoPanel.visible = true;
                flag = true;
            } else {
                flag = false;
                if(loverInfoPanel.state == "hidden") {
                    loverInfoPanel.visible = false;
                }
            }
        }

        NumberAnimation {
            target: loverInfoPanel
            properties: "x"
            duration: 250
        }
        NumberAnimation {
            target: maskLayer
            properties: "opacity,width"
            duration: 250
        }
        NumberAnimation {
            target: contentArea
            property: "opacity"
            duration: 200
        }
    }
}
