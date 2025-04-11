#include <QCoreApplication>
#include <QTcpSocket>
#include <QFile>
#include <QTextStream>
#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QScreen>
#include <QWindow>
#include <QtPlugin>
#include "tcpclient.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    TcpClient tcpClient;
    // Get the list of available screens
    const auto screens = QGuiApplication::screens();

    // Check if there are no screens available
    if (screens.isEmpty()) {
        qWarning() << "No screens detected. Exiting application.";
        return -1; // Exit early if no screens are available
    }

    // If there is only one screen, select it, otherwise select the second screen
    QScreen *targetScreen = (screens.size() > 1) ? screens.at(1) : screens.at(0);

    // Create the QML application engine
    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("tcpClient", &tcpClient);
    tcpClient.connectToServer();
    // Connect to handle object creation failure
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    // Load the QML file (ensure the correct module name)
    engine.loadFromModule("Qt_Cluster", "Main");

    const QObject *rootObject = engine.rootObjects().isEmpty() ? nullptr : engine.rootObjects().first();
    if (rootObject) {
        // Cast the root object to QWindow to allow manipulation
        QWindow *rootWindow = qobject_cast<QWindow *>(const_cast<QObject *>(rootObject));

        if (rootWindow) {
            // Move the window to the selected screen
            rootWindow->setScreen(targetScreen);
            rootWindow->showFullScreen();  // Optionally, use show() or showMaximized()
        } else {
            qWarning() << "Root object is not a QWindow.";
        }
    } else {
        qWarning() << "No root object found.";
    }

    return app.exec();
}
