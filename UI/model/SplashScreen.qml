import QtQuick 2.0

Item {
    id: splashScreenContainer

    signal splashScreenCompleted()
    function splashAnimationStart() {
        splashanimation.start();
    }

    Image {
        id: splashImage
        source: "qrc:/Img/Youme.png"
        anchors.fill: splashScreenContainer // do specify the size and position
    }

    // simple QML animation to give a good user experience
    SequentialAnimation {
        id:splashanimation
        running: false

        PropertyAnimation {
            target: splashImage
            duration: 350
            properties: "opacity"
            to:0
        }

        onStopped: {
            splashScreenContainer.splashScreenCompleted()
        }
    }
}
