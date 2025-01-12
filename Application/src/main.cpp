#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QApplication>

#include "Palette.h"
#include "TemporalUnit.h"
#include "SettingsModel.h"


// int main(int argc, char *argv[])
// {
// 	QApplication app(argc, argv);
// 	QQmlApplicationEngine engine;

// 	const QUrl url(QStringLiteral("ui/Main.qml"));

// 	(void)qmlRegisterSingletonType<Palette>("CPalette",
// 	                                        1, 0,
// 	                                        "CPalette",
// 	                                        &Palette::instantiateQmlSingleton);
// 	(void)qmlRegisterSingletonType<TemporalUnit>("TemporalUnit",
// 	                                             1, 0,
// 	                                             "TemporalUnit",
// 	                                             &TemporalUnit::instantiateQmlSingleton);
// 	qmlRegisterType<SettingsModel>("settings", 1, 0, "SettingsModel");

// 	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
// 	                 &app, [url](QObject *obj, const QUrl &objUrl) {
// 		if (!obj && url == objUrl)
// 			QCoreApplication::exit(-1);
// 	}, Qt::QueuedConnection);

// 	engine.load(url);

// 	return app.exec();
// }


#include <cereal/archives/binary.hpp>
#include <cereal/archives/xml.hpp>
#include "ProfileData.h"
#include <sstream>
#include <iostream>
#include <fstream>

int main()
{
	std::stringstream ss; // any stream can be used

	  {
		cereal::BinaryOutputArchive oarchive(ss); // Create an output archive

		MyClass m1;
		m1.x = 20;
		oarchive(m1); // Write the data to the archive
	  } // archive goes out of scope, ensuring all contents are flushed

	  {
		cereal::BinaryInputArchive iarchive(ss); // Create an input archive

		MyClass m1;
		iarchive(m1); // Read the data from the archive

		std::cout << m1.x << "\n";
	  }

	{
		std::ofstream os("data.xml");
		cereal::XMLOutputArchive archive(os);
		MyClass m1;
		int a = 20;
		double b = 35.5;
		bool c = true;
		QString value  = "hhehehehe";
		archive(cereal::make_nvp("check", c), a, CEREAL_NVP(m1), cereal::make_nvp("this_name_is_way_better", b ), value);
	}
	{
		std::ifstream is("data.xml");
		cereal::XMLInputArchive archive(is);

		MyClass m1;
		bool check;
		int someInt;
		double d;
		QString value;

		archive(CEREAL_NVP(m1));
		archive(cereal::make_nvp("this_name_is_way_better", d ));
		archive(value);

		archive(cereal::make_nvp("check", check ));
		archive(someInt);

		std::cout << someInt << "\n";
	}
}
