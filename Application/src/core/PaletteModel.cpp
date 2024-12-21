#include "PaletteModel.h"

#include <mutex>
#include <optional>

namespace {

std::once_flag flag;
std::optional<QColor> m_enhanceRequest;
static PaletteModel *model = nullptr;

const int singleColorRange = 7;

QVector<QColor> rgbDefaultColor = {
    {"#fe4a49"},
    {"#2ab7ca"},
    {"#fed766"},
    {"#f4b6c2"},
    {"#6497b1"},
    {"#451e3e"},
    {"#35a79c"},
    {"#dfa290"},
    {"#3d1e6d"},
    {"#b8860b"},
    {"#f37736"},
    {"#556b2f"},
    {"#2f4f4f"},
    {"#e0ffff"}
};

QVector<QColor> getRangeOfSingleColor(const QColor &color)
{
    QVector<QColor> colors;
    const auto rangeColor = singleColorRange - 1;
    for (int i = 0; i < rangeColor; i++) {
        const auto darkerColor = color.darker(rangeColor * 100 / (rangeColor - i));
        colors.append(darkerColor);
    }
    colors.append(color);
    return colors;
}

}

ColorModel::UPtr ColorModel::getRgbColorModelInstance()
{
    return UPtr(new ColorModel());
}

ColorModel::UPtr ColorModel::getSingleColorModelInstance(const QColor &color)
{
    return UPtr(new ColorModel(getRangeOfSingleColor(color)));
}

QVariant ColorModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid()) {
        Q_ASSERT(false);
        return {};
    }

    if (index.row() < 0 || index.row() > m_colors.size()) {
        Q_ASSERT(false);
        return {};
    }

    switch(role) {
    default: {
        Q_ASSERT(false);
        return {};
    }
    case ColorRole: {
        return QVariant::fromValue(m_colors[index.row()]);
    }
    }
}

int ColorModel::rowCount(const QModelIndex &) const
{
    return m_colors.size();
}

QHash<int, QByteArray> ColorModel::roleNames() const
{
    return {
        {ColorRole, "colors"}
    };
}

ColorModel::ColorModel()
{
}

ColorModel::ColorModel(const QVector<QColor> &colors)
    : m_colors(std::move(colors))
{
}

void ColorModel::setSingleColor(const QColor &)
{

}

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

void PaletteModel::initColorModel()
{
    m_rgbColorModel = ColorModel::getRgbColorModelInstance();
    m_singleColorModel = ColorModel::getSingleColorModelInstance(Qt::white);
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

QObject *PaletteModel::singleColorModel() const
{
    return m_singleColorModel.get();
}

QObject *PaletteModel::rgbColorModel() const
{
    return m_rgbColorModel.get();
}

bool PaletteModel::singleColor() const
{
    return m_isSingleColor;
}

void PaletteModel::setSingleColor(bool value)
{
    if (m_isSingleColor == value) {
        return;
    }
    m_isSingleColor = value;
    emit singleColorChanged();
}
