#include "parameters_controller.h"

#include <QDebug>

#include "locator.h"

using namespace kjarni::domain;
using namespace draken::endpoint;

ParametersController::ParametersController(QObject* parent) :
    QObject(parent),
    m_pTree(Locator::get<IPropertyTree>())
{
    Q_ASSERT(m_pTree);

    connect(m_pTree, &IPropertyTree::propertiesChanged, this,
            [this](const QString& path, const QJsonObject& properties) {
                if (m_root == path)
                    emit parametersChanged();
            });
}

QString ParametersController::root() const
{
    return m_root;
}

QJsonObject ParametersController::parameters() const
{
    return m_pTree->properties(m_root);
}

void ParametersController::setRoot(const QString& root)
{
    if (m_root == root)
        return;

    m_root = root;
    emit rootChanged();
    emit parametersChanged();
}
