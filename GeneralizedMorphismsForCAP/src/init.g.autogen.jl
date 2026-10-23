# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Reading the declaration part of the package.
#

include( "gap/GeneralizedMorphismCategory.gd.autogen.jl" );

include( "gap/GeneralizedMorphismCategoryByThreeArrows.gd.autogen.jl" );

include( "gap/GeneralizedMorphismCategoryByCospans.gd.autogen.jl" );

include( "gap/GeneralizedMorphismCategoryBySpans.gd.autogen.jl" );

include( "gap/GeneralizedMorphismCategoryFunctors.gd.autogen.jl" );

#= comment for Julia
include( "gap/SerreQuotients.gd.autogen.jl" );

include( "gap/SerreQuotientsByThreeArrows.gd.autogen.jl" );

include( "gap/SerreQuotientsByCospans.gd.autogen.jl" );

include( "gap/SerreQuotientsBySpans.gd.autogen.jl" );

include( "gap/SerreQuotientsFunctors.gd.autogen.jl" );

include( "gap/SerreQuotientSubcategory.gd.autogen.jl" );
# =#

include( "gap/Switcher.gd.autogen.jl" );
