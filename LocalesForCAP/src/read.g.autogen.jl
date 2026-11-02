# SPDX-License-Identifier: GPL-2.0-or-later
# LocalesForCAP: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Reading the implementation part of the package.
#

include( "gap/ProsetMethodRecord.gi.autogen.jl");
include( "gap/ProsetMethodRecordInstallations.autogen.gi.autogen.jl");
include( "gap/Proset.gi.autogen.jl");
include( "gap/ProsetDerivedMethods.gi.autogen.jl");

include( "gap/PosetMethodRecord.gi.autogen.jl");
include( "gap/PosetMethodRecordInstallations.autogen.gi.autogen.jl");
include( "gap/Poset.gi.autogen.jl");
include( "gap/PosetDerivedMethods.gi.autogen.jl");

include( "gap/Lattice.gi.autogen.jl");
include( "gap/LatticeDerivedMethods.gi.autogen.jl");

include( "gap/HeytingAlgebraMethodRecord.gi.autogen.jl");
include( "gap/CoHeytingAlgebraMethodRecord.gi.autogen.jl");

include( "gap/HeytingAlgebraMethodRecordInstallations.autogen.gi.autogen.jl");
include( "gap/CoHeytingAlgebraMethodRecordInstallations.autogen.gi.autogen.jl");

include( "gap/HeytingAlgebra.gi.autogen.jl");
include( "gap/CoHeytingAlgebra.gi.autogen.jl");

include( "gap/HeytingAlgebraDerivedMethods.gi.autogen.jl");
include( "gap/CoHeytingAlgebraDerivedMethods.gi.autogen.jl");

include( "gap/BooleanAlgebraMethodRecord.gi.autogen.jl");
include( "gap/BooleanAlgebraMethodRecordInstallations.autogen.gi.autogen.jl");
include( "gap/BooleanAlgebra.gi.autogen.jl");
include( "gap/BooleanAlgebraDerivedMethods.gi.autogen.jl");

include( "gap/Tools.gi.autogen.jl");

include( "gap/ProsetOfCategory.gi.autogen.jl");

include( "gap/Differences.gi.autogen.jl");
include( "gap/SingleDifferences.gi.autogen.jl");
include( "gap/MultipleDifferences.gi.autogen.jl");

include( "gap/ConstructibleObjects.gi.autogen.jl");
include( "gap/ConstructibleObjectsAsUnionOfSingleDifferences.gi.autogen.jl");
include( "gap/ConstructibleObjectsAsUnionOfMultipleDifferences.gi.autogen.jl");

include( "gap/IntervalCategory.gi.autogen.jl");

include( "gap/ProsetAsCategory.gi.autogen.jl");

#= comment for Julia
if IsPackageMarkedForLoading( "Digraphs", ">= 1.3.1" ) then
    include( "gap/ToolsUsingDigraphs.gi.autogen.jl");
fi;

if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) and IsPackageMarkedForLoading( "Digraphs", ">= 1.3.1" ) then
    include( "gap/JuliaWithDigraphs.gi.autogen.jl");
fi;
# =#
