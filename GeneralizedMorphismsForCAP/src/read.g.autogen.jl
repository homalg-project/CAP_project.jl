# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Reading the implementation part of the package.
#

include( "gap/GeneralizedMorphismCategory.gi.autogen.jl" );

include( "gap/GeneralizedMorphismCategoryByThreeArrows.gi.autogen.jl" );

include( "gap/GeneralizedMorphismCategoryByCospans.gi.autogen.jl" );

include( "gap/GeneralizedMorphismCategoryBySpans.gi.autogen.jl" );

include( "gap/GeneralizedMorphismCategoryFunctors.gi.autogen.jl" );

#= comment for Julia
include( "gap/SerreQuotients.gi.autogen.jl" );

include( "gap/SerreQuotientsByThreeArrows.gi.autogen.jl" );

include( "gap/SerreQuotientsByCospans.gi.autogen.jl" );

include( "gap/SerreQuotientsBySpans.gi.autogen.jl" );

include( "gap/SerreQuotientsFunctors.gi.autogen.jl" );

include( "gap/SerreQuotientSubcategory.gi.autogen.jl" );
# =#

include( "gap/Switcher.gi.autogen.jl" );
