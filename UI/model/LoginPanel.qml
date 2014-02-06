import QtQuick 2.0
import "Component"

Item {
    id:loginPanel
    state: "logout"

    Rectangle {
        anchors.fill: parent;
        color:"#f37e7e"
    }

    Text {
        y:350
        text: "You and me, the zone just belongs to us."
    }

    Column {
        id: userInfoArea
        spacing: 30
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter

        Item {
            id: icon
            width: 80; height: 80;
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: iconBorder
                anchors.fill: parent; radius: width;
                color: "white"
                opacity: 0.4
            }

            Rectangle {
                id:iconImage
                color: "black"
                anchors.fill: icon; anchors.margins: 3
                radius: width;
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter

            Column {
                spacing: 15

                ClearLineEdit {

                    width: 150; height:35
                }

                ClearLineEdit {
                    width: 150; height:35
                }
            }
        }
    }

    Column {
        id: loginArea
        anchors.left: userInfoArea.right; anchors.leftMargin: 20
        spacing: -8

        Rectangle {
            color: Qt.darker("white", 1.4)
            width: 1; height: 140;
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Item {
            id:img
            width: img1.width; height: img1.height

            Image {
                id: img1
                rotation: 180
                sourceSize.width: 48; sourceSize.height: 48;
                source: "http://download.easyicon.net/png/1132459/48/"
            }

            Text {
                anchors.centerIn: parent
                text:"登录"
                font.family: "微软雅黑"
                color: "white"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    loginPanel.state = loginPanel.state == "login" ? "logout" : "login";
                }
            }
        }
    }

    states: [
        State {
            name: "login"
            PropertyChanges {
                target:loginArea
                y: -loginArea.height
            }
            PropertyChanges {
                target:loginPanel
                y: -loginPanel.height
            }
        },
        State {
            name: "logout"
            PropertyChanges {
                target:loginArea
                y: 0
            }
        }
    ]

    transitions: Transition {
        NumberAnimation { target: loginArea; properties: "y"; easing.type: Easing.OutCirc; duration: 200 }
        NumberAnimation { target: loginPanel; properties: "y"; easing.type: Easing.OutCirc; duration: 1000 }
    }

}
