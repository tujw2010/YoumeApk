#include<QGuiApplication>
#include<QQuickView>
#include<QQuickItem>
#include<QQmlEngine>
#include<QQmlContext>

int main(int argc, char* argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView viewer;
    viewer.engine()->rootContext()->setContextProperty("mainWindow", &viewer);
    viewer.setSource(QUrl("qrc:/UI/YouMe.qml"));
    viewer.showFullScreen();

    return app.exec();
}
