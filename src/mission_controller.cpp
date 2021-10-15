#include "mission_controller.h"

#include <QDebug>

#include "locator.h"

using namespace md::domain;
using namespace md::presentation;

MissionController::MissionController(QObject* parent) :
    QObject(parent),
    m_missionsService(md::app::Locator::get<IMissionsService>())
{
    Q_ASSERT(m_missionsService);

    connect(m_missionsService, &IMissionsService::missionChanged, this, [this](Mission* mission) {
        if (m_mission == mission)
            emit missionChanged();
    });
}

QJsonObject MissionController::mission() const
{
    if (!m_mission)
        return QJsonObject();

    return m_mission->toJson(false);
}

QJsonObject MissionController::missionStatus() const
{
    if (!m_mission)
        return MissionStatus().toJson();

    return m_mission->status().toJson();
}

QJsonObject MissionController::route() const
{
    if (!m_mission)
        return QJsonObject();

    return m_mission->route()->toJson(true);
}

void MissionController::setVehicleId(const QString& vehicleId)
{
    Mission* mission = m_missionsService->missionForVehicle(vehicleId);

    if (m_mission == mission)
        return;

    if (m_mission)
    {
        disconnect(m_mission, nullptr, this, nullptr);
    }

    m_mission = mission;

    if (mission)
    {
        connect(mission, &Mission::statusChanged, this, &MissionController::missionStatusChanged);
        connect(mission, &Mission::routeChanged, this, &MissionController::routeChanged);
    }

    emit missionChanged();
    emit missionStatusChanged();
    emit routeChanged();
}

void MissionController::save(const QJsonObject& data)
{
    if (!m_mission)
        return;

    m_mission->fromJson(data);
    m_missionsService->saveMission(m_mission);
}

void MissionController::remove()
{
    if (!m_mission)
        return;

    m_missionsService->removeMission(m_mission);
}

void MissionController::upload()
{
    if (!m_mission)
        return;

    emit m_mission->upload();
}

void MissionController::download()
{
    if (!m_mission)
        return;

    emit m_mission->download();
}

void MissionController::clear()
{
    if (!m_mission)
        return;

    emit m_mission->clear();
}

void MissionController::cancel()
{
    if (!m_mission)
        return;

    emit m_mission->cancel();
}
