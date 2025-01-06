#include "SettingsModel.h"
#include "PaletteModel.h"

#include <QFileDialog>

namespace utils {

QString filePath(QString fileName)
{
    return QString("file:///" + fileName);
}

}

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
	qDebug() << "DEBUG hehehe " << color;
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

QString SettingsModel::sourcePath() const
{
    if (m_sourcePath.isEmpty()) {
        return QString();
    }
    return utils::filePath(m_sourcePath);
}

void SettingsModel::openFolder()
{
    const QString fileName = QFileDialog::getOpenFileName(
        nullptr, tr("Open Image"), "", tr("Image Files (*.png *.jpg *.bmp)"));

    if (m_sourcePath == fileName) {
        return;
    }
    m_sourcePath = fileName;
    emit sourcePathChanged();
}
