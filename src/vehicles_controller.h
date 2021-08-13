#ifndef VEHICLES_CONTROLLER_H
#define VEHICLES_CONTROLLER_H

#include <QObject>

namespace draken::endpoint
{
class VehiclesController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QStringList vehicles READ vehicles NOTIFY vehiclesChanged)

public:
    explicit VehiclesController(QObject* parent = nullptr);

    QStringList vehicles() const;

public slots:
    void start();

signals:
    void vehiclesChanged();
};
} // namespace draken::endpoint

#endif // VEHICLES_CONTROLLER_H
