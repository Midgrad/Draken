#ifndef MODULE_DRAKEN_H
#define MODULE_DRAKEN_H

#include "i_module.h"

namespace md::app
{
class ModuleDraken
    : public QObject
    , public md::app::IModule
{
    Q_OBJECT
    Q_INTERFACES(md::app::IModule)
    Q_PLUGIN_METADATA(IID "Midgrad.ModuleDraken" FILE "meta.json")

public:
    Q_INVOKABLE ModuleDraken();

    void visit(QJsonObject& features) override;
};
} // namespace md::app

#endif // MODULE_DRAKEN_H
