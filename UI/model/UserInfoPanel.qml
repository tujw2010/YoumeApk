import QtQuick 2.0
import "Component"

Flickable {
    id: flickable
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
        id:centerArea
        anchors.fill: parent;
        anchors.topMargin: 15; anchors.bottomMargin: 20;
        anchors.margins: 8
        spacing: 8;
        clip:true

        Row {
            id:contentArea
            width: parent.width; height: parent.height*0.75
            spacing: 15

            Column {
                id: userColumn
                spacing: 18
                y:5

                Column {
                    Text { text: "涂健武"}

                    Rectangle {
                        width:60; height: 60;
                        color: "red"

                        MouseArea {
                            anchors.fill: parent;

                            onClicked: {
                                loverInfoPanel.state = "show"
                            }
                        }
                    }
                }

                Column {
                    Text {
                        text: "某某某"
                    }

                    Rectangle {
                        width:60; height: 60;
                        color: "red"
                    }
                }

            }

            Column {
                spacing: 10
                width:contentArea.width - userColumn.x - userColumn.width - contentArea.spacing;
                height: parent.height

                ClearLineEdit {
                    id: filterLineEdit
                    width:parent.width;  height: 25;
                }

                ListView {
                    id: logListView
                    width: parent.width; height:parent.height - filterLineEdit.height - parent.spacing
                    clip: true

                    ListModel {
                        id: logModel
                        ListElement {
                            type: 1
                            time: "2014-2-4 10:38"
                        }
                        ListElement {
                            type: 1
                            time: "2014-2-4 10:38"
                        }
                        ListElement {
                            type: 1
                            time: "2014-2-4 10:38"
                        }
                        ListElement {
                            type: 1
                            time: "2014-2-4 10:38"
                        }
                        ListElement {
                            type: 1
                            time: "2014-2-4 10:38"
                        }
                        ListElement {
                            type: 1
                            time: "2014-2-4 10:38"
                        }
                    }
                    model:logModel

                    delegate: Item {
                        width: logListView.width; height: 30
                        Row {
                            Rectangle {
                                width: 25; height: 25;
                                color: "red"
                            }
                            Text {
                                text:time
                            }
                        }
                    }
                }
            }
        }

        Column {
            width: parent.width; height: parent.height * 0.25
            clip: true;

            Text {
                text: "爱情保鲜剂"
            }

            Text {
                width: contentArea.width;
                text:"包容，没有谁是十全十美，两个人在一起，就是互相包容。《心灵捕手》中西恩描绘妻子放屁的表情，不是嫌弃，不是不堪，那是一种对另一方的缺点的包容与宠溺，是她的缺点只有我知道的占有的荣耀。正是缺点才铸就了每个独一无二的人，才决定了允许谁进入自己的世界。"
                wrapMode: Text.WrapAnywhere
            }
        }

    }

    LoverInfoPanel {
        id:loverInfoPanel
        width: centerArea.width; height: centerArea.height
        anchors.top: centerArea.top; anchors.topMargin: 0
        anchors.bottom: centerArea.bottom; anchors.bottomMargin: 0
        anchors.margins: 8;
    }
}
