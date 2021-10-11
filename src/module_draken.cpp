#include "module_draken.h"

#include <QCoreApplication>
#include <QDebug>
#include <QQmlEngine>

#include "i_gui_layout.h"
#include "locator.h"
#include "vehicles_controller.h"

using namespace md::app;

void registerTypes()
{
    Q_INIT_RESOURCE(industrial_indicators_qml);

    qmlRegisterType<md::presentation::VehiclesController>("Dreka.Draken", 1, 0,
                                                          "VehiclesController");
}

Q_COREAPP_STARTUP_FUNCTION(registerTypes);

ModuleDraken::ModuleDraken()
{
}

void ModuleDraken::init()
{
    Locator::get<presentation::IGuiLayout>()->addItem("dashboard", "qrc:/Draken/VehiclesView.qml");
}
