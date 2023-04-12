# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal && monoidal (co)closed categories
#
# Implementations
#

@InstallValueConst( RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

CoclosedCoevaluationForCoDual = rec(
  filter_list = [ "category", "object" ],
  io_type = [ [ "a" ], [ "s", "r" ] ],
  output_source_getter_string = "TensorProductOnObjects( cat, a, CoDualOnObjects( cat, a ) )",
  output_source_getter_preconditions = [ [ "TensorProductOnObjects", 1 ], [ "CoDualOnObjects", 1 ] ],
  output_range_getter_string = "TensorUnit( cat )",
  output_range_getter_preconditions = [ [ "TensorUnit", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "CoevaluationForDual",
  # Test ⥉ RigidSymmetricCoclosedMonoidalCategoriesTest
),

CoclosedCoevaluationForCoDualWithGivenTensorProduct = rec(
  filter_list = [ "category", "object", "object", "object" ],
  io_type = [ [ "s", "a", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "CoevaluationForDualWithGivenTensorProduct",
  dual_arguments_reversed = true,
  # Test ⥉ RigidSymmetricCoclosedMonoidalCategoriesTest
),

MorphismToCoBidual = rec(
  filter_list = [ "category", "object" ],
  io_type = [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string = "a",
  output_range_getter_string = "CoDualOnObjects( cat, CoDualOnObjects( cat, a ) )",
  output_range_getter_preconditions = [ [ "CoDualOnObjects", 2 ] ],
  with_given_object_position = "Range",
  return_type = "morphism",
  dual_operation = "MorphismFromBidual",
  # Test ⥉ RigidSymmetricCoclosedMonoidalCategoriesTest
),

MorphismToCoBidualWithGivenCoBidual = rec(
  filter_list = [ "category", "object", "object" ],
  io_type = [ [ "a", "r" ], [ "a", "r" ] ],
  return_type = "morphism",
  dual_operation = "MorphismFromBidualWithGivenBidual",
  dual_arguments_reversed = false,
  # Test ⥉ RigidSymmetricCoclosedMonoidalCategoriesTest
),

InternalCoHomTensorProductCompatibilityMorphismInverse = rec(
  filter_list = [ "category", "list_of_objects" ],
  input_arguments_names = [ "cat", "list" ],
  output_source_getter_string = "TensorProductOnObjects( cat, InternalCoHomOnObjects( cat, list[1], list[3] ), InternalCoHomOnObjects( cat, list[2], list[4] ) )",
  output_source_getter_preconditions = [ [ "TensorProductOnObjects", 1 ], [ "InternalCoHomOnObjects", 2 ] ],
  output_range_getter_string = "InternalCoHomOnObjects( cat, TensorProductOnObjects( cat, list[1], list[2] ), TensorProductOnObjects( cat, list[3], list[4] ) )",
  output_range_getter_preconditions = [ [ "InternalCoHomOnObjects", 1 ], [ "TensorProductOnObjects", 2 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "TensorProductInternalHomCompatibilityMorphismInverse",
  dual_preprocessor_func =
    ( cat, list ) -> PairGAP( Opposite( cat ), [ Opposite( list[3] ), Opposite( list[1] ), Opposite( list[4] ), Opposite( list[2] ) ] ),
  dual_arguments_reversed = false,
  # Test ⥉ RigidSymmetricCoclosedMonoidalCategoriesTest
),

InternalCoHomTensorProductCompatibilityMorphismInverseWithGivenObjects = rec(
  filter_list = [ "category", "object", "list_of_objects", "object" ],
  input_arguments_names = [ "cat", "source", "list", "range" ],
  output_source_getter_string = "source",
  output_range_getter_string = "range",
  return_type = "morphism",
  dual_operation = "TensorProductInternalHomCompatibilityMorphismInverseWithGivenObjects",
  dual_preprocessor_func =
    ( cat, s, list, r ) -> NTupleGAP( 4, Opposite( cat ), Opposite( r ), [ Opposite( list[3] ), Opposite( list[1] ), Opposite( list[4] ), Opposite( list[2] ) ], Opposite( s ) ),
  dual_arguments_reversed = false,
  # Test ⥉ RigidSymmetricCoclosedMonoidalCategoriesTest
),

MorphismFromTensorProductToInternalCoHom = rec(
  filter_list = [ "category", "object", "object" ],
  io_type = [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string = "TensorProductOnObjects( cat, CoDualOnObjects( cat, a ), b  )",
  output_source_getter_preconditions = [ [ "TensorProductOnObjects", 1 ], [ "CoDualOnObjects", 1 ] ],
  output_range_getter_string = "InternalCoHomOnObjects( cat, b, a )",
  output_range_getter_preconditions = [ [ "InternalCoHomOnObjects", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "MorphismFromInternalHomToTensorProduct",
  dual_arguments_reversed = false,
  # Test ⥉ RigidSymmetricCoclosedMonoidalCategoriesTest
),

MorphismFromTensorProductToInternalCoHomWithGivenObjects = rec(
  filter_list = [ "category", "object", "object", "object", "object" ],
  io_type = [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "MorphismFromInternalHomToTensorProductWithGivenObjects",
  dual_preprocessor_func = ( cat, s, a, b, r ) -> NTupleGAP( 5, Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( b ), Opposite( s ) ),
  dual_arguments_reversed = false,
  # Test ⥉ RigidSymmetricCoclosedMonoidalCategoriesTest
),

CoTraceMap = rec(
  filter_list = [ "category", "morphism" ],
  io_type = [ [ "alpha" ], [ "u", "u" ] ],
  return_type = "morphism",
  dual_operation = "TraceMap",
  # Test ⥉ RigidSymmetricCoclosedMonoidalCategoriesTest
),

CoRankMorphism = rec(
  filter_list = [ "category", "object" ],
  io_type = [ [ "a" ], [ "u", "u" ] ],
  return_type = "morphism",
  dual_operation = "RankMorphism",
  # Test ⥉ RigidSymmetricCoclosedMonoidalCategoriesTest
),

IsomorphismFromInternalCoHomToTensorProductWithCoDualObject = rec(
  filter_list = [ "category", "object", "object" ],
  io_type = [ [ "a", "b" ], [ "i", "t" ] ],
  return_type = "morphism",
  dual_operation = "IsomorphismFromTensorProductWithDualObjectToInternalHom",
  dual_arguments_reversed = true,
  # Test ⥉ RigidSymmetricCoclosedMonoidalCategoriesTest
),

IsomorphismFromTensorProductWithCoDualObjectToInternalCoHom = rec(
  filter_list = [ "category", "object", "object" ],
  io_type = [ [ "a", "b" ], [ "t", "i" ] ],
  return_type = "morphism",
  dual_operation = "IsomorphismFromInternalHomToTensorProductWithDualObject",
  dual_arguments_reversed = false,
  # Test ⥉ RigidSymmetricCoclosedMonoidalCategoriesTests
),

) );

# collect closed && coclosed operations
@BindGlobal( "RIGID_SYMMETRIC_CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD", rec( ) );

Perform( RecNames( RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD ), function ( name )

    RIGID_SYMMETRIC_CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD[name] = RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD[name];

end );

Perform( RecNames( RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD ), function ( name )

    RIGID_SYMMETRIC_CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD[name] = RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD[name];

end );

CAP_INTERNAL_ENHANCE_NAME_RECORD( RIGID_SYMMETRIC_CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    RIGID_SYMMETRIC_CLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "RigidSymmetricClosedMonoidalCategories.autogen.gd", "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    RIGID_SYMMETRIC_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "RigidSymmetricCoclosedMonoidalCategories.autogen.gd", "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( RIGID_SYMMETRIC_CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( RIGID_SYMMETRIC_CLOSED_AND_COCLOSED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
