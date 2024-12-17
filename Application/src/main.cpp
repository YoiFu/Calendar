#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "Palette.h"
#include "TemporalUnit.h"
#include "PaletteModel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    const QUrl url(QStringLiteral("ui/Main.qml"));

    (void)qmlRegisterSingletonType<Palette>("CPalette",
                                                    1, 0,
                                                    "CPalette",
                                                    &Palette::instantiateQmlSingleton);
    (void)qmlRegisterSingletonType<TemporalUnit>("TemporalUnit",
                                                  1, 0,
                                                  "TemporalUnit",
                                                  &TemporalUnit::instantiateQmlSingleton);
    (void)qmlRegisterSingletonType<TemporalUnit>("PaletteModel",
                                                  1, 0,
                                                  "PaletteModel",
                                                  &PaletteModel::instantiateQmlSingleton);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
                         if (!obj && url == objUrl)
                             QCoreApplication::exit(-1);
                     }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();
}
