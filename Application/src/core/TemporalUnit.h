#pragma once

#include <QDateTime>
#include <QMap>
#include <QObject>
#include <QQmlEngine>
#include <QTimer>
#include <QVariantList>

class DayInfo : public QObject
{
	Q_OBJECT

	Q_PROPERTY(int day READ day NOTIFY daysChanged)
	Q_PROPERTY(bool rightMonth READ rightMonth NOTIFY rightMonthChanged)
public:
	DayInfo(int day, bool rightMonth);
	DayInfo();
	DayInfo(const DayInfo &dayInfo);
	DayInfo &operator=(const DayInfo &dayInfo);
	int day() const;
	bool rightMonth() const;
	void setDay(int day);
	void setRightMonth(bool value);

signals:
	void daysChanged();
	void rightMonthChanged();

private:
	int m_day = 0;
	bool m_currentMonth = false;
};

class TemporalUnit : public QObject
{
	Q_OBJECT

	Q_PROPERTY(int month READ month WRITE setMonth NOTIFY monthChanged)
	Q_PROPERTY(int year READ year WRITE setYear NOTIFY yearChanged)
	Q_PROPERTY(int today READ today CONSTANT)
	Q_PROPERTY(QVariantList daysInCalendar READ daysInCalendar NOTIFY daysInCalendarChanged)
	Q_PROPERTY(bool realCurrentMonth READ realCurrentMonth NOTIFY realMonthChanged)
	Q_PROPERTY(int hour READ hour NOTIFY timeChanged)
	Q_PROPERTY(int minute READ minute NOTIFY timeChanged)
public:
	~TemporalUnit();

	static TemporalUnit *instantiateQmlSingleton(QQmlEngine *engine, QJSEngine *jsEngine);
    TemporalUnit(const TemporalUnit &obj) = delete;
    TemporalUnit& operator=(const TemporalUnit &obj) = delete;

	Q_INVOKABLE QString getDayName(int) const;
	Q_INVOKABLE int getDayNumber(QString) const;
	Q_INVOKABLE QString getMonthName(int) const;

	int month() const;
	void setMonth(int);

	int year() const;
	void setYear(int);

	int hour() const;
	int minute() const;

	QVariantList daysInCalendar() const;

	int today() const;
	void configureCalendarInfo(QDate currentDataInCalendar);
	void appendCalendarData(int dayOfPreviousMonth, int dayOfNextMonth, int firstDayOfCurrentMonth);

	bool realCurrentMonth() const;
	void setRealMonth(bool value);
	void updateTime();

signals:
	void monthChanged();
	void yearChanged();
	void daysInCalendarChanged();
	void realMonthChanged();
	void timeChanged();

public slots:
	void onMoveToNextMonth();
	void onMoveToPreviousMonth();

private slots:
	void onCounting();

private:
	explicit TemporalUnit(QObject *parent = nullptr);
	void updateTrueMonth();
	void startClockCounting();

	QDate m_date;
	QDate m_currentDateInCalendar;
	QVector<DayInfo *> m_daysInCalendar;
	int m_day;
	QTimer m_timer;
	int m_counter = 0;
	bool m_realMonth = true;
};
