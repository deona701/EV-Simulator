#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QResource>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QResource::registerResource(app.applicationDirPath() + "/car_assets.rcc");
    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("ev_simulator", "Main");

    return QGuiApplication::exec();
}
