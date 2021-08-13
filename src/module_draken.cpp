#include "module_draken.h"

#include <QDebug>
#include <QQmlEngine>

#include "vehicles_controller.h"

using namespace draken::app;

ModuleDraken::ModuleDraken()
{
    qmlRegisterType<endpoint::VehiclesController>("Dreka.Draken", 1, 0, "VehiclesController");
}

void ModuleDraken::visit(QJsonObject& features)
{
    features.insert("dashboard", "qrc:/Draken/VehiclesView.qml");
}
