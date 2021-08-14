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

VehiclesController::VehiclesController(QObject* parent) :
    QObject(parent),
    m_pTree(Locator::get<IPropertyTree>())
{
    Q_ASSERT(m_pTree);
}

QStringList VehiclesController::vehicles() const
{
    return m_pTree->rootNodes();
}

void VehiclesController::test()
{
    for (const QString& vehicle : m_pTree->rootNodes())
    {
        emit vehicleDataChanged(vehicle, m_pTree->property(vehicle));
    }
}
