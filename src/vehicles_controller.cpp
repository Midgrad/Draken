#include "vehicles_controller.h"

#include <QDebug>

#include "i_property_tree.h"
#include "locator.h"

using namespace kjarni::domain;
using namespace draken::endpoint;

VehiclesController::VehiclesController(QObject* parent) :
    QObject(parent),
    m_pTree(Locator::get<IPropertyTree>())
{
    Q_ASSERT(m_pTree);

    connect(m_pTree, &IPropertyTree::rootNodesChanged, this, &VehiclesController::vehiclesChanged);
    connect(m_pTree, &IPropertyTree::propertiesChanged, this,
            &VehiclesController::vehicleDataChanged);
}

QStringList VehiclesController::vehicles() const
{
    return m_pTree->rootNodes();
}

QJsonObject VehiclesController::vehicleData(const QString& vehicle) const
{
    return m_pTree->properties(vehicle);
}
