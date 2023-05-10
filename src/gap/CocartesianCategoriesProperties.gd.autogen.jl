# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian && cocartesian categories && various subdoctrines
#
# Declarations
#

#! @Description
#!  The property of the category <A>C</A> being cocartesian.
#! @Arguments C
@DeclareProperty( "IsCocartesianCategory", IsCapCategory );

AddCategoricalProperty( [ "IsCocartesianCategory", "IsCartesianCategory" ] );

#! @Description
#!  The property of the category <A>C</A> being strict cocartesian.
#! @Arguments C
@DeclareProperty( "IsStrictCocartesianCategory", IsCapCategory );

AddCategoricalProperty( [ "IsStrictCocartesianCategory", "IsStrictCartesianCategory" ] );

CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.IsCocartesianCategory  = @Concatenation( [
"Coproduct",
"InjectionOfCofactorOfCoproductWithGivenCoproduct",
"UniversalMorphismFromCoproductWithGivenCoproduct",
"InitialObject",
"UniversalMorphismFromInitialObjectWithGivenInitialObject",
], CAP_INTERNAL_CONSTRUCTIVE_CATEGORIES_RECORD.EveryCategory );

## For internal use only:
## we need an operation name different from `Coproduct`, since CompilerForCAP
## seems to be unable to compile the CAP operation `Coproduct`
## if declared ⥉ a way different from that ⥉ the method record
@DeclareOperation( "BinaryCoproduct",
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ] );

CapJitAddTypeSignature( "BinaryCoproduct", [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ], function ( input_types )
    
    return CapJitDataTypeOfObjectOfCategory( input_types[1].category );
    
end );

##
CAP_INTERNAL_ADD_REPLACEMENTS_FOR_METHOD_RECORD(
  rec(
    BinaryCoproduct =
      [ [ "Coproduct", 1 ] ]
  )
);
