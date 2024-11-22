return [[#include "Dummy.h"
#include "log.h"

Dummy::Dummy(void) {
  LOG("constructor Dummy empty")
}

Dummy::Dummy(const Dummy &src) {
  LOG("constructor Dummy copy")
  if (this != &src)
    *this = src;
}

Dummy::~Dummy(void) {
  LOG("destructor Dummy")
}

Dummy &Dummy::operator=(Dummy const &src) {
  if (this == &src)
    return (*this);
  return (*this);
}]]
