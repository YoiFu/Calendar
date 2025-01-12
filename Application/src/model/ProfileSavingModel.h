#pragma once

#include <QObject>

#include <cereal/archives/xml.hpp>

class ProfileSavingModel : QObject
{
	Q_OBJECT

	friend class cereal::access;
};
