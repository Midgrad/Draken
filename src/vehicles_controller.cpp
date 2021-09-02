#include "vehicles_controller.h"

#include <QDebug>

#include "i_property_tree.h"
#include "locator.h"

using namespace md::domain;
using namespace md::presentation;

VehiclesController::VehiclesController(QObject* parent) :
    QObject(parent),
    m_pTree(md::app::Locator::get<IPropertyTree>())
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

bool VehiclesController::isTracking() const
{
    return m_tracking;
}

QString VehiclesController::selectedVehicle() const
{
    return m_selectedVehicle;
}

int VehiclesController::trackLength() const
{
    return 1000; // TODO: settings
}

QVariantMap VehiclesController::vehicleData(const QString& vehicle) const
{
    return m_pTree->properties(vehicle);
}

void VehiclesController::setTracking(bool tracking)
{
    if (m_tracking == tracking)
        return;

    m_tracking = tracking;
    emit trackingChanged();
}

void VehiclesController::selectVehicle(const QString& selectedVehicle)
{
    this->setTracking(false);

    if (m_selectedVehicle == selectedVehicle)
        return;

    m_selectedVehicle = selectedVehicle;
    emit selectedVehicleChanged();
}

void VehiclesController::setVehicleData(const QString& vehicle, const QVariantMap& data)
{
    if (data.isEmpty())
        return;

    m_pTree->appendProperties(vehicle, data);
}
