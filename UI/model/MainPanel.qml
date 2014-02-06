import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import "Component"

Rectangle {
    id:mainPanel
    color: "gray"

    MenuBar {
        id:menuBar
        anchors.fill: parent
        property int previousIndex: 0

        onPageChange: {
            if(previousIndex + 1 == index || previousIndex == menuList.count - 1 && index == 0) {
                stackView.delegate = rightToLeftDelegate;
            } else {
                stackView.delegate = leftToRightDelegate;
            }

            switch (index) {
            case 0:
                stackView.push(userInfo)
                break;
            case 1:
                stackView.push(zonePanel)
                break;
            case 2:
                stackView.push(aboutPanel)
                break;
            }

            previousIndex = index;
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent;
        anchors.topMargin: 24
        initialItem:userInfo;

        UserInfoPanel{
            id: userInfo; visible: false

            onMoving: {
                if (x > 0) {
                    menuBar.menuList.incrementCurrentIndex();
                } else {
                    menuBar.menuList.decrementCurrentIndex();
                }
            }
        }


        ZonePanel {id:zonePanel; visible: false
            onMoving: {
                if (x > 0) {
                    menuBar.menuList.incrementCurrentIndex();
                } else {
                    menuBar.menuList.decrementCurrentIndex();
                }
            }
        }
        AboutPanel {id:aboutPanel; visible: false
            onMoving: {
                if (x > 0) {
                    menuBar.menuList.incrementCurrentIndex();
                } else {
                    menuBar.menuList.decrementCurrentIndex();
                }
            }
        }

        delegate: rightToLeftDelegate;

        StackViewDelegate {
            id: rightToLeftDelegate

            function transitionFinished(properties)
            {
                properties.exitItem.x = 0
                properties.exitItem.contentX = 0;
                properties.exitItem.state = "normal"
            }

            property Component pushTransition: StackViewTransition {
                PropertyAnimation {
                    target: enterItem
                    property: "x"
                    from: enterItem.width
                    to: 0
                    duration: 150;
                }
                PropertyAnimation {
                    target: exitItem
                    property: "x"
                    to: -exitItem.width
                    duration: 150;
                }
            }
        }

        StackViewDelegate {
            id: leftToRightDelegate

            function transitionFinished(properties)
            {
                properties.enterItem.x = 0
                properties.exitItem.contentX = 0;
                properties.exitItem.state = "normal"
            }

            property Component pushTransition: StackViewTransition {
                PropertyAnimation {
                    target: exitItem
                    property: "x"
                    to: exitItem.width
                    duration: 150;
                }
                PropertyAnimation {
                    target: enterItem
                    property: "x"
                    from: -enterItem.width
                    to: 0
                    duration: 150;
                }
            }
        }
    }

    NumberAnimation {
        running: visible
        id:showAnimation
        target:mainPanel
        property: "opacity";
        from: 0; to: 1;
        duration: 300
    }
}
