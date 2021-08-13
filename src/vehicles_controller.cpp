#include "vehicles_controller.h"

#include <QDebug>

#include "i_property_tree.h"
#include "locator.h"

namespace
{
constexpr char adsb[] = "adsb";
}

using namespace kjarni::domain;
using namespace draken::endpoint;

VehiclesController::VehiclesController(QObject* parent) : QObject(parent)
{
}

QStringList VehiclesController::vehicles() const
{
    return { "UAV 1", "MAV 23", "ST-341" };
}

void VehiclesController::start()
{
    IPropertyTree* pTree = Locator::get<IPropertyTree>();
    Q_ASSERT(pTree);
}
