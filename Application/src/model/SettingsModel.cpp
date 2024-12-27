#include "SettingsModel.h"
#include "PaletteModel.h"

SettingsModel::SettingsModel(QObject *parent)
    : QObject(parent)
{
}

QObject *SettingsModel::paletteModel() const
{
    return PaletteModel::instantiateQmlSingleton();
}

int SettingsModel::transparency()
{
	return m_transparency;
}

void SettingsModel::setTransparency(int value)
{
	if (m_transparency == value) {
		return;
	}
	m_transparency = value;
	emit transparencyChanged();
}

QColor SettingsModel::backgroundColor() const
{
    return m_backgroundColor;
}

void SettingsModel::setBackgroundColor(QColor color)
{
    if (m_backgroundColor == color) {
        return;
    }
    m_backgroundColor = color;
    emit backgroundColorChanged();
}

QColor SettingsModel::textColor() const
{
    return m_textColor;
}

void SettingsModel::setTextColor(QColor color)
{
    if (m_textColor == color) {
        return;
    }
    m_textColor = color;
    emit textColorChanged();
}

QColor SettingsModel::accentColor() const
{
    return m_accentColor;
}

void SettingsModel::setAccentColor(QColor color)
{
    if (m_accentColor == color) {
        return;
    }
    m_accentColor = color;
    emit accentColorChanged();
}

bool SettingsModel::customBackgroundEnabled() const
{
    return m_customBackgroundEnabled;
}

void SettingsModel::setCustomBackgroundEnabled(bool enabled)
{
    if (m_customBackgroundEnabled == enabled) {
        return;
    }
    m_customBackgroundEnabled = enabled;
    emit customBackgroundEnabledChanged();
}
