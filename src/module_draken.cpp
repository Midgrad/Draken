#include "module_draken.h"

#include <QDebug>
#include <QGuiApplication>
#include <QQmlEngine>

#include "vehicles_controller.h"

using namespace md::app;

void registerTypes()
{
    Q_INIT_RESOURCE(industrial_indicators_qml);

    qmlRegisterType<md::presentation::VehiclesController>("Dreka.Draken", 1, 0, "VehiclesController");
}

Q_COREAPP_STARTUP_FUNCTION(registerTypes);

ModuleDraken::ModuleDraken()
{
}

void ModuleDraken::visit(QJsonObject& features)
{
    features.insert("dashboard", "qrc:/Draken/VehiclesView.qml");
}
