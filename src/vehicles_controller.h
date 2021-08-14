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

public:
    explicit VehiclesController(QObject* parent = nullptr);

    QStringList vehicles() const;

signals:
    void vehiclesChanged();

private:
    kjarni::domain::IPropertyTree* const m_pTree;
};
} // namespace draken::endpoint

#endif // VEHICLES_CONTROLLER_H
