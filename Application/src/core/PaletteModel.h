#pragma once

#include <QObject>
#include <QColor>
#include <QQmlEngine>
#include <QJSEngine>

class PaletteModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QColor textColor READ textColor WRITE setTextColor NOTIFY textColorChanged)
    Q_PROPERTY(QColor backgroundColor READ backgroundColor WRITE setBackgroundColor NOTIFY backgroundChanged)
    Q_PROPERTY(QColor accentColor READ accentColor WRITE setAccentColor NOTIFY accentColorChanged)

public:
    PaletteModel(const PaletteModel &) = delete;
    void operator= (const PaletteModel &) = delete;
    ~PaletteModel() = default;

    static PaletteModel *instantiateQmlSingleton(QQmlEngine *engine, QJSEngine *jsEngine);

    QColor textColor() const;
    QColor backgroundColor() const;
    QColor accentColor() const;

    void setTextColor(QColor);
    void setBackgroundColor(QColor);
    void setAccentColor(QColor);

signals:
    void textColorChanged();
    void backgroundChanged();
    void accentColorChanged();

private:
    PaletteModel(QObject *parent = nullptr);

    QColor m_textColor;
    QColor m_backgroundColor;
    QColor m_accentColor;
};
