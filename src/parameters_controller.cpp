#include "parameters_controller.h"

#include <QDebug>

#include "locator.h"

namespace
{
constexpr char adsb[] = "adsb";
}

using namespace kjarni::domain;
using namespace draken::endpoint;

ParametersController::ParametersController(QObject* parent) :
    QObject(parent),
    m_pTree(Locator::get<IPropertyTree>())
{
    Q_ASSERT(m_pTree);
}

QString ParametersController::root() const
{
    return m_root;
}

QJsonObject ParametersController::parameters() const
{
    return m_pTree->property(m_root);
}

void ParametersController::setRoot(const QString& root)
{
    if (m_root == root)
        return;

    m_root = root;
    emit rootChanged();
    emit parametersChanged();
}
