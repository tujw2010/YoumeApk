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
        State { name: "normal"}
    ]


    GridView {
        id:gridView
        anchors.fill: parent;
        anchors.topMargin: 15; anchors.bottomMargin: 20;
        anchors.margins: 8
        clip:true

        cellWidth: 82; cellHeight:132;

        ListModel {
            id: imageModel
            ListElement {
                user: "涂健武"
                time:"2014-2-4"
            }
            ListElement {
                user: "涂健武"
                time:"2014-2-4"
            }
            ListElement {
                user: "涂健武"
                time:"2014-2-4"
            }
            ListElement {
                user: "涂健武"
                time:"2014-2-4"
            }
            ListElement {
                user: "涂健武"
                time:"2014-2-4"
            }
        }

        model: imageModel
        delegate: Item {
            id:main
            width: 80; height: 130;

            Item {
                id:img
                state: "inGrid";

                Rectangle {
                    anchors.fill: parent;
                    color: "red"
                }

                Item {
                    id: imgTitleBar
                    width: parent.width; height: 20
                    anchors.bottom: parent.bottom;

                    Rectangle {
                        id:imgTitle;color:"black";opacity: 0.4;anchors.fill: parent;
                    }

                    Text {
                        anchors.left: imgTitle.left;anchors.leftMargin: 4
                        anchors.verticalCenter: imgTitle.verticalCenter
                        text:time
                        font.pixelSize: 11
                        color:"white"
                        font.family: "微软雅黑"
                    }
                }

                MouseArea {
                    anchors.fill: img;
                    onClicked: {
                        img.state = img.state == "fullScreen" ? "inGrid" : "fullScreen"
                    }
                }

                states: [
                    State {
                        name: "fullScreen"
                        ParentChange {
                            target:img;
                            parent:window;
                            x:0; y:0; width: window.width; height: window.height;
                        }
                        PropertyChanges {
                            target: imgTitleBar
                            opacity: 0
                        }
                    },
                    State {
                        name: "inGrid"
                        ParentChange {
                            target:img;
                            parent:main;
                            x:0; y:0; width:main.width; height:main.height
                        }
                        PropertyChanges {
                            target: imgTitleBar
                            opacity: 1
                        }
                    }
                ]

                transitions: [
                    Transition {
                        NumberAnimation {
                            target: imgTitleBar
                            property: "opacity"
                            duration: 500;
                        }
                        ParentAnimation {
                            target: img; via:window
                            NumberAnimation { properties: "width, height, x,y"; duration: 350 }
                        }
                    }
                ]
            }
        }
    }
}
