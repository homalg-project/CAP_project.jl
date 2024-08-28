# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Reading the implementation part of the package.
#
## the CAP core

# ToolsForCategories.gi is already loaded in init.g
#include( "gap/ToolsForCategories.gi.autogen.jl" );

include( "gap/CAP.gi.autogen.jl" );

include( "gap/Derivations.gi.autogen.jl" );

include( "gap/Finalize.gi.autogen.jl" );

include( "gap/MethodRecordTools.gi.autogen.jl" );

include( "gap/CategoryObjects.gi.autogen.jl" );

include( "gap/CategoryMorphisms.gi.autogen.jl" );

include( "gap/CategoryTwoCells.gi.autogen.jl" );

include( "gap/LimitConvenience.gi.autogen.jl" );

include( "gap/InstallAdds.gi.autogen.jl" );

#= comment for Julia
include( "gap/TheoremParser.gi.autogen.jl" );
# =#

include( "gap/LogicForCAP.gi.autogen.jl" );

include( "gap/ConstructiveCategoriesRecord.gi.autogen.jl" );

include( "gap/PrintingFunctions.gi.autogen.jl" );

include( "gap/PrepareFunctionsTools.gi.autogen.jl" );

## the CAP library

## pre-defined CAP operations
include( "gap/CategoryObjectsOperations.gi.autogen.jl" );

include( "gap/CategoryMorphismsOperations.gi.autogen.jl" );

include( "gap/CategoryTwoCellsOperations.gi.autogen.jl" );

include( "gap/UniversalObjects.gi.autogen.jl" );

include( "gap/MethodRecord.gi.autogen.jl" );

include( "gap/PrepareFunctions.gi.autogen.jl" );

include( "gap/DerivedMethods.gi.autogen.jl" );

include( "gap/LimitConvenienceOutput.gi.autogen.jl" );

include( "gap/DerivedMethods.autogen.gi.autogen.jl" );

## pre-defined category constructors
include( "gap/OppositeCategory.gi.autogen.jl" );

include( "gap/ProductCategory.gi.autogen.jl" );

include( "gap/CategoriesCategory.gi.autogen.jl" );

include( "gap/CategoryConstructor.gi.autogen.jl" );

include( "gap/TerminalCategory.gi.autogen.jl" );

include( "gap/ReinterpretationOfCategory.gi.autogen.jl" );

include( "gap/WrapperCategory.gi.autogen.jl" );

include( "gap/DummyImplementations.gi.autogen.jl" );

## init
include( "gap/init.gi.autogen.jl" );
