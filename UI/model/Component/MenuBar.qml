import QtQuick 2.0
import ".."

Rectangle {
    id: menuBar
    color:"transparent"

    property alias menuList: pathView

    signal pageChange(int index);

    ListModel {
        id: menuModel

        ListElement { name: "个人中心"; }
        ListElement { name: "空间"; }
        ListElement { name: "关于" }
    }

    PathView {
        id:pathView
        anchors.fill: parent; anchors.topMargin: 15
        dragMargin: parent.height

        onCurrentIndexChanged: {
            pageChange(currentIndex)
        }

        model: menuModel
        delegate: Item {
            width: 1; height:24
            Text {
                id: title
                text: name
                font.bold: true
                font.pointSize: 16
                state:parent.PathView.isCurrentItem ? "current" : "hide"

                states: [
                    State {
                        name: "current"
                        PropertyChanges {target: title; color: "black"}
                    },
                    State {
                        name: "hide"
                        PropertyChanges {target: title;color: "lightgray"}
                    }
                ]
                transitions: Transition {ColorAnimation {duration: 100 }}
            }
        }

        interactive:true
        snapMode: PathView.SnapOneItem
        maximumFlickVelocity:200
        path: Path {
            startX: 0; startY: 0
            PathLine { x: window.width - 25; y: 0}
            PathPercent{value:0.3}
            PathLine { x: window.width + 100; y: 0}
            PathPercent{value:0.9}
        }
    }
}
