#ifndef MISSION_CONTROLLER_H
#define MISSION_CONTROLLER_H

#include "i_missions_service.h"
#include "i_property_tree.h"

namespace md::presentation
{
class MissionController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString vehicleId WRITE setVehicleId)
    Q_PROPERTY(QJsonObject mission READ mission NOTIFY missionChanged)
    Q_PROPERTY(QJsonObject missionStatus READ missionStatus NOTIFY missionStatusChanged)
    Q_PROPERTY(QJsonObject route READ route NOTIFY routeChanged)

public:
    explicit MissionController(QObject* parent = nullptr);

    Q_INVOKABLE QJsonObject mission() const;
    Q_INVOKABLE QJsonObject missionStatus() const;
    Q_INVOKABLE QJsonObject route() const;

public slots:
    void setVehicleId(const QString& vehicleId);

    void save(const QJsonObject& data);
    void remove();
    void upload();
    void download();
    void clear();
    void cancel();

signals:
    void missionChanged();
    void missionStatusChanged();
    void routeChanged();

private:
    domain::IMissionsService* const m_missionsService;
    domain::Mission* m_mission = nullptr;
};
} // namespace md::presentation

#endif // MISSION_CONTROLLER_H
