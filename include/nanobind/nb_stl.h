#pragma once
#include <type_traits>
#include <luisa/core/stl/string.h>
#include <luisa/core/stl/vector.h>
#include <luisa/core/stl/memory.h>
#include <luisa/core/stl/functional.h>
#include <vector>
#include <nanobind/nb_defs.h>
NAMESPACE_BEGIN(NB_NAMESPACE)
namespace std
{
using namespace ::std;
using luisa::string;
using luisa::span;
using eastl::vector;
template <typename T, typename Alloc>
using stl_vector = ::std::vector<T, Alloc>;
using luisa::function;
} // namespace std
NAMESPACE_END(NB_NAMESPACE)