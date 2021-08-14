#ifndef PARAMETERS_CONTROLLER_H
#define PARAMETERS_CONTROLLER_H

#include "i_property_tree.h"

#include <QJsonObject>
#include <QObject>

namespace draken::endpoint
{
class ParametersController : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString root READ root WRITE setRoot NOTIFY rootChanged)
    Q_PROPERTY(QJsonObject parameters READ parameters NOTIFY parametersChanged)

public:
    explicit ParametersController(QObject* parent = nullptr);

    QString root() const;
    QJsonObject parameters() const;

public slots:
    void setRoot(const QString& root);
    void start();

signals:
    void rootChanged();
    void parametersChanged();

private:
    kjarni::domain::IPropertyTree* m_pTree = nullptr;

    QString m_root;
};
} // namespace draken::endpoint

#endif // PARAMETERS_CONTROLLER_H
