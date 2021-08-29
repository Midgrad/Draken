#ifndef VEHICLES_CONTROLLER_H
#define VEHICLES_CONTROLLER_H

#include <QObject>

#include "i_property_tree.h"

namespace draken::endpoint
{
class VehiclesController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QStringList vehicles READ vehicles NOTIFY vehiclesChanged)
    Q_PROPERTY(bool tracking READ isTracking WRITE setTracking NOTIFY trackingChanged)
    Q_PROPERTY(QString selectedVehicle READ selectedVehicle WRITE selectVehicle NOTIFY
                   selectedVehicleChanged)
    Q_PROPERTY(int trackLength READ trackLength NOTIFY trackLengthChanged)

public:
    explicit VehiclesController(QObject* parent = nullptr);

    QStringList vehicles() const;
    bool isTracking() const;
    QString selectedVehicle() const;
    int trackLength() const;

    Q_INVOKABLE QJsonObject vehicleData(const QString& vehicle) const;

public slots:
    void setTracking(bool tracking);
    void selectVehicle(const QString& selectedVehicle);
    void setVehicleData(const QString& vehicle, const QJsonObject& data);

signals:
    void vehiclesChanged();
    void trackingChanged();
    void selectedVehicleChanged();
    void trackLengthChanged();

    void vehicleDataChanged(QString vehicle, QJsonObject data);

private:
    kjarni::domain::IPropertyTree* const m_pTree;
    bool m_tracking = false;
    QString m_selectedVehicle;
};
} // namespace draken::endpoint

#endif // VEHICLES_CONTROLLER_H
