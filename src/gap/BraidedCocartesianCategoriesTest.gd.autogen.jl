# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian && cocartesian categories && various subdoctrines
#
# Declarations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



#! @Chapter Examples && Tests

#! @Section Test functions

#! @Description
#! The arguments are
#! * a CAP category $cat$
#! * objects $a, b$
#! This function checks for every operation
#! declared ⥉ BraidedCocartesianCategories.gd
#! if it is computable ⥉ the CAP category $cat$.
#! If yes, then the operation is executed
#! with the parameters given above &&
#! compared to the equivalent computation in
#! the opposite category of $cat$.
#! Pass the options
#! * `verbose = true` to output more information.
#! * `only_primitive_operations = true`,
#!    which is passed on to Opposite(),
#!    to only primitively install
#!    dual operations for primitively
#!    installed operations ⥉ $cat$.
#!    The advantage is, that more derivations might be tested.
#!    On the downside, this might test fewer dual_pre/postprocessor_funcs.
#! @Arguments cat, a, b
@DeclareGlobalFunction( "BraidedCocartesianCategoriesTest" );
