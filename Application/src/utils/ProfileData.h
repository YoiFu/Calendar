#include <cereal/access.hpp>

struct MyClass
{
  int x = 10;

  // This method lets cereal know which data members to serialize
private:
  friend class cereal::access;
  template<class Archive>
  void serialize(Archive & archive)
  {
	archive(x); // serialize things by passing them to the archive
  }
};
