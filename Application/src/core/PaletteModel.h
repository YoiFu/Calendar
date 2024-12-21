#pragma once

#include <QObject>
#include <QColor>
#include <QQmlEngine>
#include <QJSEngine>
#include <QAbstractListModel>

class ColorModel final : public QAbstractListModel
{
    Q_OBJECT
public:
    using UPtr = std::unique_ptr<ColorModel>;

    ColorModel (const ColorModel &) = delete;
    ColorModel& operator=(const ColorModel &) = delete;

    enum Roles {
        ColorRole = Qt::UserRole + 1
    };
    Q_ENUM(Roles)

    static UPtr getRgbColorModelInstance();
    static UPtr getSingleColorModelInstance(const QColor &baseColor);

    QVariant data(const QModelIndex &index, int role) const final;
    int rowCount(const QModelIndex &parent = {}) const final;
    QHash<int, QByteArray> roleNames() const final;

    void setSingleColor(const QColor &);

private:
    explicit ColorModel();
    explicit ColorModel(const QVector<QColor> &);
    QVector<QColor> m_colors;
};

class PaletteModel : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QColor textColor READ textColor WRITE setTextColor NOTIFY textColorChanged)
    Q_PROPERTY(QColor backgroundColor READ backgroundColor WRITE setBackgroundColor NOTIFY backgroundChanged)
    Q_PROPERTY(QColor accentColor READ accentColor WRITE setAccentColor NOTIFY accentColorChanged)
    Q_PROPERTY(bool singleColor READ singleColor WRITE setSingleColor NOTIFY singleColorChanged)
    Q_PROPERTY(QObject *rgbColorModel READ rgbColorModel CONSTANT)
    Q_PROPERTY(QObject *singleColorModel READ singleColorModel CONSTANT)

public:
    PaletteModel(const PaletteModel &) = delete;
    void operator= (const PaletteModel &) = delete;
    ~PaletteModel() = default;

    static PaletteModel *instantiateQmlSingleton(QQmlEngine *engine, QJSEngine *jsEngine);

    QColor textColor() const;
    QColor backgroundColor() const;
    QColor accentColor() const;
    bool singleColor() const;

    void setTextColor(QColor);
    void setBackgroundColor(QColor);
    void setAccentColor(QColor);
    void setSingleColor(bool);

    QObject *singleColorModel() const;
    QObject *rgbColorModel() const;

signals:
    void textColorChanged();
    void backgroundChanged();
    void accentColorChanged();
    void singleColorChanged();

private:
    PaletteModel(QObject *parent = nullptr);
    void initColorModel();

    QColor m_textColor;
    QColor m_backgroundColor;
    QColor m_accentColor;

    ColorModel::UPtr m_rgbColorModel;
    ColorModel::UPtr m_singleColorModel;

    bool m_isSingleColor = false;
};
