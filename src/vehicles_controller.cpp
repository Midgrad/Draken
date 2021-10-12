#include "vehicles_controller.h"

#include <QDebug>

#include "locator.h"

using namespace md::domain;
using namespace md::presentation;

VehiclesController::VehiclesController(QObject* parent) :
    QObject(parent),
    m_pTree(md::app::Locator::get<IPropertyTree>()),
    m_vehiclesService(md::app::Locator::get<IVehiclesService>())
{
    Q_ASSERT(m_pTree);
    Q_ASSERT(m_vehiclesService);

    connect(m_pTree, &IPropertyTree::propertiesChanged, this,
            &VehiclesController::vehicleDataChanged);

    connect(m_vehiclesService, &IVehiclesService::vehicleAdded, this,
            &VehiclesController::onVehiclesChanged);
    connect(m_vehiclesService, &IVehiclesService::vehicleRemoved, this,
            &VehiclesController::onVehiclesChanged);
    this->onVehiclesChanged();
}

QJsonArray VehiclesController::vehicles() const
{
    return m_vehicles;
}

QJsonObject VehiclesController::selectedVehicle() const
{
    Vehicle* vehicle = m_vehiclesService->vehicle(m_selectedVehicleId);
    if (!vehicle)
        return QJsonObject();

    return vehicle->toJson();
}

bool VehiclesController::isTracking() const
{
    return m_tracking;
}

int VehiclesController::trackLength() const
{
    return 1000; // TODO: settings
}

QVariantMap VehiclesController::vehicleData(const QString& vehicleId) const
{
    return m_pTree->properties(vehicleId);
}

void VehiclesController::setTracking(bool tracking)
{
    if (m_tracking == tracking)
        return;

    m_tracking = tracking;
    emit trackingChanged();
}

void VehiclesController::selectVehicle(const QString& selectedVehicleId)
{
    if (m_selectedVehicleId == selectedVehicleId)
        return;

    this->setTracking(false);
    m_selectedVehicleId = selectedVehicleId;
    emit selectedVehicleChanged();
}

void VehiclesController::setVehicleData(const QString& vehicleId, const QVariantMap& data)
{
    if (data.isEmpty())
        return;

    m_pTree->appendProperties(vehicleId, data);
}

void VehiclesController::onVehiclesChanged()
{
    m_vehicles = QJsonArray();
    for (domain::Vehicle* vehicle : m_vehiclesService->vehicles())
    {
        m_vehicles += vehicle->toJson();
    }
    emit vehiclesChanged();

    if (m_selectedVehicleId.isNull() && m_vehicles.count())
    {
        this->selectVehicle(m_vehicles.first().toObject().value(params::id).toString());
    }
}
