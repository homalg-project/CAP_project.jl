# SPDX-License-Identifier: GPL-2.0-or-later
# FinSetsForCAP: The (skeletal) elementary topos of finite sets
#
# Reading the declaration part of the package.
#

include( "gap/Tools.gd.autogen.jl" );

include( "gap/FinSets.gd.autogen.jl" );

include( "gap/SkeletalFinSets.gd.autogen.jl" );

include( "gap/SkeletalFinSetsWithCountingStartingAt1.gd.autogen.jl" );

#= comment for Julia
if IsPackageMarkedForLoading( "JuliaInterface", ">= 0.2" ) then
    # COVERAGE_IGNORE_NEXT_LINE
    include( "gap/Julia.gd.autogen.jl" );
fi;
# =#
