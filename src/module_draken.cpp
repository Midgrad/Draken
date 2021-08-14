#include "module_draken.h"

#include <QDebug>
#include <QGuiApplication>
#include <QQmlEngine>

#include "parameters_controller.h"
#include "vehicles_controller.h"

using namespace draken::app;

void registerTypes()
{
    Q_INIT_RESOURCE(industrial_indicators_qml);

    qmlRegisterType<draken::endpoint::VehiclesController>("Dreka.Draken", 1, 0,
                                                          "VehiclesController");
    qmlRegisterType<draken::endpoint::ParametersController>("Dreka.Draken", 1, 0,
                                                            "ParametersController");
}

Q_COREAPP_STARTUP_FUNCTION(registerTypes);

ModuleDraken::ModuleDraken()
{
}

void ModuleDraken::visit(QJsonObject& features)
{
    features.insert("dashboard", "qrc:/Draken/VehiclesView.qml");
}
