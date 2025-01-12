#pragma once

#include <QColor>

namespace utils{

// QString

} // namespace utils

struct MyData
{
  double d;

  template <class Archive>
  double save_minimal(Archive const & ) const
  {
	return d;
  }

  template <class Archive>
  void load_minimal( Archive const &, double const & value )
  {
	d = value;
  }


};
