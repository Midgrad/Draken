#ifndef MODULE_DRAKEN_H
#define MODULE_DRAKEN_H

#include "i_module.h"

namespace draken::app
{
class ModuleDraken
    : public QObject
    , public kjarni::app::IModule
{
    Q_OBJECT
    Q_INTERFACES(kjarni::app::IModule)
    Q_PLUGIN_METADATA(IID "Midgrad.ModuleDraken" FILE "meta.json")

public:
    Q_INVOKABLE ModuleDraken();

    void visit(QJsonObject& features) override;
};
} // namespace draken::app

#endif // MODULE_DRAKEN_H
