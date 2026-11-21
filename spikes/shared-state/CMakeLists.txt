# SPDX-License-Identifier: BSD-3-Clause
# SPDX-FileCopyrightText: 2026 Trond Lossius
#
# THROWAWAY SPIKE (removed in milestone 0, Task 4): two separate externals that report
# the registry they see, to prove there is one registry per Max process.

jamoma_add_external(NAME j.spike.a SOURCES j.spike.a.cpp)
jamoma_add_external(NAME j.spike.b SOURCES j.spike.b.cpp)
