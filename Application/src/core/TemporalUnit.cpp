#include "TemporalUnit.h"

#include <mutex>
#include <cstdlib>

namespace calendar_util {

QVector<QString> convertedDay = {
	"Sun",
	"Mon",
	"Tue",
	"Wed",
	"Thu",
	"Fri",
	"Sat",
};

QVector<QString> convertedMonth = {
	"January",
	"February",
	"Match",
	"April",
	"May",
	"Jun",
	"July",
	"August",
	"September",
	"October",
	"November",
	"December",
};

const int maximumDayInCalendar = 42;

} // namespace calendar_util

static TemporalUnit* temporalUnitObject = nullptr;
static std::once_flag flag;

DayInfo::DayInfo(int day, bool rightMonth)
	: m_day(day)
	, m_currentMonth(rightMonth)
{}

DayInfo::DayInfo() {}

DayInfo::DayInfo(const DayInfo &dayInfo)
{
	m_day = dayInfo.m_day;
	m_currentMonth = dayInfo.m_currentMonth;
}

DayInfo &DayInfo::operator=(const DayInfo &dayInfo)
{
	m_day = dayInfo.m_day;
	m_currentMonth = dayInfo.m_currentMonth;
	return *this;
}

int DayInfo::day() const
{
	return m_day;
}

bool DayInfo::rightMonth() const
{
	return m_currentMonth;
}

void DayInfo::setDay(int day)
{
	if (day == m_day) {
		return;
	}
	m_day = day;
	emit daysChanged();
}

void DayInfo::setRightMonth(bool value)
{
	if (m_currentMonth == value) {
		return;
	}
	m_currentMonth = value;
	emit rightMonthChanged();
}

TemporalUnit *TemporalUnit::instantiateQmlSingleton(QQmlEngine *engine, QJSEngine *jsEngine)
{
	Q_UNUSED(engine)
	Q_UNUSED(jsEngine)

    std::call_once(flag, []() {
        temporalUnitObject = new TemporalUnit();

        std::atexit([] {
            if (temporalUnitObject) {
                delete temporalUnitObject;
            }
        });
    });

    QJSEngine::setObjectOwnership(temporalUnitObject, QJSEngine::CppOwnership);
    return temporalUnitObject;
}

TemporalUnit::TemporalUnit(QObject *parent)
	: QObject(parent)
	, m_counter(QDateTime::currentDateTime().time().second())
{
	m_date = QDateTime::currentDateTime().date();
	m_currentDateInCalendar.setDate(m_date.year(), m_date.month(), 1);

	m_daysInCalendar.resize(42);
	for (int i = 0; i < m_daysInCalendar.size(); i++) {
		m_daysInCalendar[i] = new DayInfo();
	}

	configureCalendarInfo(m_currentDateInCalendar);

	startClockCounting();
}

TemporalUnit::~TemporalUnit()
{
}

/* To configure the calendar, we get the chosen month first.
	* After that, detect two previous and next month to fill the rest of calendar
	* The method to get the data of next and previous month is set the exact date for QDate
	* base on the current month.*/
void TemporalUnit::configureCalendarInfo(QDate currentDataInCalendar)
{
	QDate previousMonth;
	QDate nextMonth;
	switch (currentDataInCalendar.month()) {
	case 1:
		previousMonth.setDate(currentDataInCalendar.year() - 1, 12, 1);
		nextMonth.setDate(currentDataInCalendar.year(), currentDataInCalendar.month() + 1, 1);
		break;
	case 12:
		previousMonth.setDate(currentDataInCalendar.year(), currentDataInCalendar.month() - 1, 1);
		nextMonth.setDate(currentDataInCalendar.year() + 1, 1, 1);
		break;
	default:
		previousMonth.setDate(currentDataInCalendar.year(), currentDataInCalendar.month() - 1, 1);
		nextMonth.setDate(currentDataInCalendar.year(), currentDataInCalendar.month() + 1, 1);
		break;
	}

	const int firstDayOfCurrentMonth = currentDataInCalendar.dayOfWeek() > 6
										   ? 0
										   : currentDataInCalendar.dayOfWeek();
	const int dayNumberOfPreviouseMonth = previousMonth.daysInMonth();
	const int dayNumberOfNextMonth = nextMonth.daysInMonth();

	appendCalendarData(dayNumberOfPreviouseMonth, dayNumberOfNextMonth, firstDayOfCurrentMonth);
}

/* Parse the days of current month and fill the rest with previous and next month days*/
void TemporalUnit::appendCalendarData(int dayOfPreviousMonth,
									  int dayOfNextMonth,
									  int firstDayOfCurrentMonth)
{
	int daysOfCurrentMonth = m_currentDateInCalendar.daysInMonth();
	// Parse the current month
	for (int i = 0; daysOfCurrentMonth - i > 0; i++) {
		m_daysInCalendar[firstDayOfCurrentMonth + i]->setDay(i + 1);
		m_daysInCalendar[firstDayOfCurrentMonth + i]->setRightMonth(true);
	}

	// Parse the next month
	for (int i = 0;
		 daysOfCurrentMonth + firstDayOfCurrentMonth + i < calendar_util::maximumDayInCalendar;
		 i++) {
		m_daysInCalendar[daysOfCurrentMonth + firstDayOfCurrentMonth + i]->setDay(i + 1);
		m_daysInCalendar[daysOfCurrentMonth + firstDayOfCurrentMonth + i]->setRightMonth(false);
	}

	// Parse the previous month
	while (--firstDayOfCurrentMonth >= 0) {
		m_daysInCalendar[firstDayOfCurrentMonth]->setDay(dayOfPreviousMonth--);
		m_daysInCalendar[firstDayOfCurrentMonth]->setRightMonth(false);
	}

	emit daysInCalendarChanged();
	emit monthChanged();
	emit yearChanged();
}

int TemporalUnit::today() const
{
	return m_date.day();
}

QString TemporalUnit::getDayName(int dayNumber) const
{
	if (dayNumber < 0 || dayNumber > 6) {
		return {};
	}
	return calendar_util::convertedDay[dayNumber];
}

int TemporalUnit::getDayNumber(QString dayName) const
{
	return calendar_util::convertedDay.indexOf(dayName);
}

QString TemporalUnit::getMonthName(int monthNumber) const
{
	if (monthNumber < 1 || monthNumber > 12) {
		return {};
	}
	/* The input monthNumber starts from 1 */
	return calendar_util::convertedMonth[monthNumber - 1];
}

int TemporalUnit::month() const
{
	return m_currentDateInCalendar.month();
}

void TemporalUnit::setMonth(int newMonth)
{
	if (m_currentDateInCalendar.month() == newMonth) {
		return;
	}
	m_currentDateInCalendar.setDate(m_currentDateInCalendar.year(),
									newMonth,
									m_currentDateInCalendar.day());
	updateTrueMonth();
	configureCalendarInfo(m_currentDateInCalendar);
}

int TemporalUnit::year() const
{
	return m_currentDateInCalendar.year();
}

void TemporalUnit::setYear(int newYear)
{
	if (m_currentDateInCalendar.year() == newYear) {
		return;
	}
	m_currentDateInCalendar.setDate(newYear,
									m_currentDateInCalendar.month(),
									m_currentDateInCalendar.day());
	updateTrueMonth();
	configureCalendarInfo(m_currentDateInCalendar);
}

int TemporalUnit::hour() const
{
	return QDateTime::currentDateTime().time().hour();
}

int TemporalUnit::minute() const
{
	return QDateTime::currentDateTime().time().minute();
}

void TemporalUnit::updateTime()
{
	emit timeChanged();
}

QVariantList TemporalUnit::daysInCalendar() const
{
	QVariantList list;
	for (const auto &i : m_daysInCalendar) {
		list << QVariant::fromValue(i);
	}
	return list;
}

bool TemporalUnit::realCurrentMonth() const
{
	return m_realMonth;
}

void TemporalUnit::setRealMonth(bool value)
{
	if (m_realMonth == value) {
		return;
	}
	m_realMonth = value;
	emit realMonthChanged();
}

void TemporalUnit::onMoveToNextMonth()
{
	/* If the current month is 12, we will set the next month with the first month of next year */
	const int currentMonth = m_currentDateInCalendar.month();
	if (currentMonth == 12) {
		m_currentDateInCalendar.setDate(m_currentDateInCalendar.year() + 1, 1, 1);
		setYear(m_currentDateInCalendar.year());
	} else {
		m_currentDateInCalendar.setDate(m_currentDateInCalendar.year(),
										m_currentDateInCalendar.month() + 1,
										1);
	}

	updateTrueMonth();
	setMonth(m_currentDateInCalendar.month());
	configureCalendarInfo(m_currentDateInCalendar);
}

void TemporalUnit::onMoveToPreviousMonth()
{
	/* If the current month is 1, we will set the previous month with the last month of previous year */
	const int currentMonth = m_currentDateInCalendar.month();
	if (currentMonth == 1) {
		m_currentDateInCalendar.setDate(m_currentDateInCalendar.year() - 1, 12, 1);
		setYear(m_currentDateInCalendar.year());
	} else {
		m_currentDateInCalendar.setDate(m_currentDateInCalendar.year(),
										m_currentDateInCalendar.month() - 1,
										1);
	}

	updateTrueMonth();
	setMonth(m_currentDateInCalendar.month());
	configureCalendarInfo(m_currentDateInCalendar);
}

void TemporalUnit::updateTrueMonth()
{
	if (m_currentDateInCalendar.month() != m_date.month()
		|| m_currentDateInCalendar.year() != m_date.year()) {
		setRealMonth(false);
	} else {
		setRealMonth(true);
	}
}

void TemporalUnit::startClockCounting()
{
	connect(&m_timer, &QTimer::timeout, this, &TemporalUnit::onCounting);
	m_timer.setInterval(1000);
	m_timer.start();
}

void TemporalUnit::onCounting()
{
	++m_counter;
	if (m_counter >= 60) {
		emit timeChanged();
		m_counter = 0;
	}
}
