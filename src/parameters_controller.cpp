#include "parameters_controller.h"

#include <QDebug>

#include "locator.h"

namespace
{
constexpr char adsb[] = "adsb";
}

using namespace kjarni::domain;
using namespace draken::endpoint;

ParametersController::ParametersController(QObject* parent) : QObject(parent)
{
}

QString ParametersController::root() const
{
    return m_root;
}

QJsonObject ParametersController::parameters() const
{
    return QJsonObject({ { "gs", 456 } });
}

void ParametersController::setRoot(const QString& root)
{
    if (m_root == root)
        return;

    m_root = root;
    emit rootChanged();
}

void ParametersController::start()
{
    m_pTree = Locator::get<IPropertyTree>();
    Q_ASSERT(m_pTree);
}
