# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Reading the implementation part of the package.
#

#= comment for Julia
include( "gap/Tools.gi.autogen.jl" );
# =#

## Initial category

include( "gap/InitialCategory.gi.autogen.jl" );
include( "gap/InitialCategoryDerivedMethods.gi.autogen.jl" );

## Cartesian and Cocartesian

include( "gap/CartesianCategoriesProperties.gi.autogen.jl" );
include( "gap/CocartesianCategoriesProperties.gi.autogen.jl" );

include( "gap/CartesianCategoriesMethodRecord.gi.autogen.jl" );
include( "gap/CocartesianCategoriesMethodRecord.gi.autogen.jl" );

include( "gap/CartesianCategories.gi.autogen.jl" );
include( "gap/CocartesianCategories.gi.autogen.jl" );

include( "gap/CartesianCategoriesMethodRecordInstallations.autogen.gi.autogen.jl" );
include( "gap/CocartesianCategoriesMethodRecordInstallations.autogen.gi.autogen.jl" );

include( "gap/DistributiveCartesianCategoriesMethodRecord.gi.autogen.jl" );
include( "gap/CodistributiveCocartesianCategoriesMethodRecord.gi.autogen.jl" );

include( "gap/BraidedCartesianCategoriesMethodRecord.gi.autogen.jl" );
include( "gap/BraidedCocartesianCategoriesMethodRecord.gi.autogen.jl" );

include( "gap/BraidedCartesianCategories.gi.autogen.jl" );
include( "gap/BraidedCocartesianCategories.gi.autogen.jl" );

include( "gap/BraidedCartesianCategoriesMethodRecordInstallations.autogen.gi.autogen.jl" );
include( "gap/BraidedCocartesianCategoriesMethodRecordInstallations.autogen.gi.autogen.jl" );

## Cartesian Closed and Cocartesian Coclosed

include( "gap/CartesianClosedCategoriesProperties.gi.autogen.jl" );
include( "gap/CocartesianCoclosedCategoriesProperties.gi.autogen.jl" );

include( "gap/CartesianClosedCategoriesMethodRecord.gi.autogen.jl" );
include( "gap/CocartesianCoclosedCategoriesMethodRecord.gi.autogen.jl" );

include( "gap/CartesianClosedCategories.gi.autogen.jl" );
include( "gap/CocartesianCoclosedCategories.gi.autogen.jl" );

include( "gap/CartesianClosedCategoriesMethodRecordInstallations.autogen.gi.autogen.jl" );
include( "gap/CocartesianCoclosedCategoriesMethodRecordInstallations.autogen.gi.autogen.jl" );

## Bicartesian, distributive, and codistributive categories

include( "gap/BicartesianCategories.gi.autogen.jl" );

include( "gap/DistributiveCartesianCategories.gi.autogen.jl" );
include( "gap/CodistributiveCocartesianCategories.gi.autogen.jl" );

include( "gap/DistributiveCartesianCategoriesMethodRecordInstallations.autogen.gi.autogen.jl" );
include( "gap/CodistributiveCocartesianCategoriesMethodRecordInstallations.autogen.gi.autogen.jl" );

## Derived methods

include( "gap/CartesianCategoriesDerivedMethods.gi.autogen.jl" );
include( "gap/CocartesianCategoriesDerivedMethods.gi.autogen.jl" );

include( "gap/BraidedCartesianCategoriesDerivedMethods.gi.autogen.jl" );
include( "gap/BraidedCocartesianCategoriesDerivedMethods.gi.autogen.jl" );

include( "gap/SymmetricCartesianCategoriesDerivedMethods.gi.autogen.jl" );
include( "gap/SymmetricCocartesianCategoriesDerivedMethods.gi.autogen.jl" );

include( "gap/SymmetricCartesianCategoriesDerivedMethods_extra.gi.autogen.jl" );
include( "gap/SymmetricCocartesianCategoriesDerivedMethods_extra.gi.autogen.jl" );



include( "gap/CartesianClosedCategoriesDerivedMethods.gi.autogen.jl" );
include( "gap/CartesianClosedCategoriesDerivedMethods_extra.gi.autogen.jl" );
include( "gap/CocartesianCoclosedCategoriesDerivedMethods.gi.autogen.jl" );

include( "gap/SymmetricCartesianClosedCategoriesDerivedMethods.gi.autogen.jl" );
include( "gap/SymmetricCocartesianCoclosedCategoriesDerivedMethods.gi.autogen.jl" );

include( "gap/CartesianCategoriesDerivedMethods_extra.gi.autogen.jl" );
include( "gap/CocartesianCategoriesDerivedMethods_extra.gi.autogen.jl" );

## Synonyms

#= comment for Julia
include( "gap/Synonyms.gi.autogen.jl" );
# =#

## Test methods

include( "gap/CartesianCategoriesTest.gi.autogen.jl" );
include( "gap/CocartesianCategoriesTest.gi.autogen.jl" );

include( "gap/DistributiveCartesianCategoriesTest.gi.autogen.jl" );
include( "gap/CodistributiveCocartesianCategoriesTest.gi.autogen.jl" );

include( "gap/BraidedCartesianCategoriesTest.gi.autogen.jl" );
include( "gap/BraidedCocartesianCategoriesTest.gi.autogen.jl" );

include( "gap/CartesianClosedCategoriesTest.gi.autogen.jl" );
include( "gap/CocartesianCoclosedCategoriesTest.gi.autogen.jl" );

## Homomorphism structure

include( "gap/HomomorphismStructureDerivedMethods.gi.autogen.jl" );
