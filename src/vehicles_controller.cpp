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

    connect(m_pTree, &IPropertyTree::nodesChanged, this, &VehiclesController::vehiclesChanged);
}

QStringList VehiclesController::vehicles() const
{
    return m_pTree->rootNodes();
}
