import QtQuick 2.0

Flickable {
    id:flickable
    contentWidth: width; contentHeight: height;
    flickableDirection:Flickable.HorizontalFlick

    signal moving(var item, real x);

    rebound: Transition {
        NumberAnimation {
            property: "x"
            duration: 300;
            easing.type: Easing.Linear
        }
    }

    onContentXChanged: {
        if(Math.abs(contentX) >= width / 3) {
            if(!flickable.dragging)
            flickStarted()
        }
    }

    onFlickStarted: {
        if(Math.abs(contentX) >= 40) {
            if (contentX > 0) {
                flickable.state = "toLeft"
            } else {
                flickable.state = "toRight"
            }

            flickable.cancelFlick();
            moving(flickable, contentX)
        }
    }

    transitions: Transition {
        NumberAnimation {
            property: "x"
            duration: 400;
            easing.type: Easing.Linear
        }
    }

    states: [
        State {
            name: "toRight"
            PropertyChanges {
                target: flickable
                x: flickable.width
            }
        },
        State {
            name: "toLeft"
            PropertyChanges {
                target: flickable
                x: -flickable.width
            }
        },
        State {
            name: "normal"
        }
    ]

    Column {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top;anchors.topMargin: 40
        spacing: 8

        Rectangle {
            width: 80; height:80;
            color: "red"
        }

        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Youme 2014"
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                text: "V0.1"
            }
        }
    }

    Text {
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter

        text: "Copyright 2014-2014 ALi. All Rights Reserved"
        font.pointSize: 7
        font.family: "微软雅黑"
        color:"lightgray"
    }
}
