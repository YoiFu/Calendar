#pragma once

#include <QObject>
#include <QUrl>
#include <QColor>

class SettingsModel : public QObject
{
	Q_OBJECT

	Q_PROPERTY(QObject *paletteModel READ paletteModel CONSTANT)
	Q_PROPERTY(int transparency READ transparency WRITE setTransparency NOTIFY transparencyChanged)
	Q_PROPERTY(QColor backgroundColor READ backgroundColor WRITE setBackgroundColor NOTIFY backgroundColorChanged)
	Q_PROPERTY(QColor accentColor READ accentColor WRITE setAccentColor NOTIFY accentColorChanged)
	Q_PROPERTY(QColor textColor READ textColor WRITE setTextColor NOTIFY textColorChanged)
	Q_PROPERTY(bool customBackgroundEnabled READ customBackgroundEnabled
	           WRITE setCustomBackgroundEnabled NOTIFY customBackgroundEnabledChanged)
    Q_PROPERTY(QString sourcePath READ sourcePath NOTIFY sourcePathChanged)

public:
    explicit SettingsModel(QObject *parent = nullptr);
	~SettingsModel() = default;

	QObject *paletteModel() const;
	int transparency();
	void setTransparency(int value);

	QColor backgroundColor() const;
	void setBackgroundColor(QColor color);

	QColor textColor() const;
	void setTextColor(QColor color);

	QColor accentColor() const;
	void setAccentColor(QColor color);

	bool customBackgroundEnabled() const;
	void setCustomBackgroundEnabled(bool enabled);

    QString sourcePath() const;
	Q_INVOKABLE void openFolder();

signals:
	void transparencyChanged();
	void backgroundColorChanged();
	void accentColorChanged();
	void textColorChanged();
	void customBackgroundEnabledChanged();
	void sourcePathChanged();

private:
	QColor m_backgroundColor = Qt::red;
	QColor m_textColor = Qt::blue;
	QColor m_accentColor = Qt::blue;

    QString m_sourcePath;

    int m_transparency = 100;

	bool m_customBackgroundEnabled = false;
};
