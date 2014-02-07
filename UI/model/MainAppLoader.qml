import QtQuick 2.0

Item {
    id: mainAppLoaderItem

    // Loaders for the main application and the splash screen.
    Loader {
        id: mainAppLoader
        width: mainAppLoaderItem.width
        height: mainAppLoaderItem.height
    }
    Loader {
        id: splashScreenLoader
        source: Qt.resolvedUrl("./SplashScreen.qml");
        width: mainAppLoaderItem.width
        height: mainAppLoaderItem.height
    }

    // Timers for starting to load the main application and eventually deleting
    // the splash screen.
    Timer {
        id: firstPhaseTimer
        property int phase: 0
        interval: 300
        running: true
        repeat: false

        onTriggered: {
            if (!mainAppLoader.Loading) {
                mainAppLoader.source = Qt.resolvedUrl("./MainPanel.qml");
                secondPhaseTimer.start();
            }
        }
    }
    Timer {
        id: secondPhaseTimer
        property int phase: 0
        interval: 500
        running: false
        repeat: true

        onTriggered: {
            if (phase == 0) {
                if (mainAppLoader.Loading) {
                    console.debug("The main application is not loaded yet.");
                    return;
                }

                phase += 1;
            }
            else if (phase == 1) {
                // Hide the splash screen.

                if (splashScreenLoader.item) {
                    splashScreenLoader.item.splashAnimationStart();
                }

                phase += 1;
            }
            else {

                splashScreenLoader.source = "";
                secondPhaseTimer.stop();
            }
        }
    }
}
