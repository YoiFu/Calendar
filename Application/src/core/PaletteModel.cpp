#include "PaletteModel.h"

#include <mutex>
#include <optional>

std::once_flag flag;
std::optional<QColor> m_enhanceRequest;
static PaletteModel *model = nullptr;


PaletteModel *PaletteModel::instantiateQmlSingleton(QQmlEngine *engine, QJSEngine *jsEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(jsEngine)

    std::call_once(flag, []{
        model = new PaletteModel();
    });
    QJSEngine::setObjectOwnership(model, QJSEngine::CppOwnership);
    return model;
}

PaletteModel::PaletteModel(QObject *parent) : QObject(parent)
{
}

QColor PaletteModel::textColor() const
{
    return m_textColor;
}

QColor PaletteModel::backgroundColor() const
{
    return m_backgroundColor;
}

QColor PaletteModel::accentColor() const
{
    return m_accentColor;
}

void PaletteModel::setTextColor(QColor)
{

}

void PaletteModel::setBackgroundColor(QColor)
{

}

void PaletteModel::setAccentColor(QColor)
{

}
