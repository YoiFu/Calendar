#pragma once

#include <QColor>
#include <QJSEngine>
#include <QObject>
#include <QQmlEngine>

class Palette : public QObject
{
	Q_OBJECT

	Q_PROPERTY(QColor border READ border CONSTANT)

	Q_PROPERTY(QColor background1 READ background1 CONSTANT)
	Q_PROPERTY(QColor background2 READ background2 CONSTANT)
	Q_PROPERTY(QColor background3 READ background3 CONSTANT)
	Q_PROPERTY(QColor background4 READ background4 CONSTANT)
	Q_PROPERTY(QColor background5 READ background5 CONSTANT)

	Q_PROPERTY(QColor layer1 READ layer1 CONSTANT)
	Q_PROPERTY(QColor layer2 READ layer2 CONSTANT)
	Q_PROPERTY(QColor layer3 READ layer3 CONSTANT)
	Q_PROPERTY(QColor layer4 READ layer4 CONSTANT)
	Q_PROPERTY(QColor layer5 READ layer5 CONSTANT)

	Q_PROPERTY(QColor layerHover1 READ layerHover1 CONSTANT)
	Q_PROPERTY(QColor layerHover2 READ layerHover2 CONSTANT)

	Q_PROPERTY(QColor error1 READ error1 CONSTANT)

public:
    static Palette *instantiateQmlSingleton(QQmlEngine *engine, QJSEngine *jsEngine);
    ~Palette();
    Palette(const Palette &obj) = delete;
    Palette& operator=(const Palette &obj) = delete;

	QColor background2() const;
	QColor background3() const;
	QColor background4() const;
	QColor background1() const;
	QColor background5() const;

	QColor border() const;

	QColor layer1() const;
	QColor layer2() const;
	QColor layer3() const;
	QColor layer4() const;
	QColor layer5() const;

	QColor layerHover1() const;
	QColor layerHover2() const;

	QColor error1() const;

private:
    explicit Palette(QObject *parent = nullptr);
};
