# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian && cocartesian categories && various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



@InstallValueConst( CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD, rec(

ExponentialOnObjects = rec(
  filter_list = [ "category", "object", "object" ],
  input_arguments_names = [ "cat", "a", "b" ],
  return_type = "object",
  dual_operation = "CoexponentialOnObjects",
  dual_arguments_reversed = true,
  # Test ⥉ CartesianClosedCategoriesTest
),

ExponentialOnMorphisms = rec(
  filter_list = [ "category", "morphism", "morphism" ],
  io_type = [ [ "alpha", "beta" ], [ "s", "r" ] ],
  output_source_getter_string = "ExponentialOnObjects( cat, Range( alpha ), Source( beta ) )",
  output_source_getter_preconditions = [ [ "ExponentialOnObjects", 1 ] ],
  output_range_getter_string = "ExponentialOnObjects( cat, Source( alpha ), Range( beta ) )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "CoexponentialOnMorphisms",
  dual_arguments_reversed = true,
  # Test ⥉ CartesianClosedCategoriesTest
),

ExponentialOnMorphismsWithGivenExponentials = rec(
  filter_list = [ "category", "object", "morphism", "morphism", "object" ],
  io_type = [ [ "s", "alpha", "beta", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "CoexponentialOnMorphismsWithGivenCoexponentials",
  dual_arguments_reversed = true,
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianEvaluationMorphism = rec(
  filter_list = [ "category", "object", "object" ],
  io_type = [ [ "a", "b" ], [ "s", "b" ] ],
  output_source_getter_string = "BinaryDirectProduct( cat, ExponentialOnObjects( cat, a, b ), a )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "ExponentialOnObjects", 1 ] ],
  output_range_getter_string = "b",
  with_given_object_position = "Source",
  return_type = "morphism",
  dual_operation = "CocartesianEvaluationMorphism",
  dual_arguments_reversed = true,
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianEvaluationMorphismWithGivenSource = rec(
  filter_list = [ "category", "object", "object", "object" ],
  io_type = [ [ "a", "b", "s" ], [ "s", "b" ] ],
  return_type = "morphism",
  dual_operation = "CocartesianEvaluationMorphismWithGivenRange",
  dual_preprocessor_func = ( cat, a, b, s ) -> NTupleGAP( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( s ) ),
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianCoevaluationMorphism = rec(
  filter_list = [ "category", "object", "object" ],
  io_type = [ [ "a", "b" ], [ "a", "r" ] ],
  output_source_getter_string = "a",
  output_range_getter_string = "ExponentialOnObjects( cat, b, BinaryDirectProduct( cat, a, b ) )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "DirectProduct", 1 ] ],
  with_given_object_position = "Range",
  return_type = "morphism",
  dual_operation = "CocartesianCoevaluationMorphism",
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianCoevaluationMorphismWithGivenRange = rec(
  filter_list = [ "category", "object", "object", "object" ],
  io_type = [ [ "a", "b", "r" ], [ "a", "r" ] ],
  return_type = "morphism",
  dual_operation = "CocartesianCoevaluationMorphismWithGivenSource",
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

DirectProductToExponentialAdjunctionMap = rec(
  filter_list = [ "category", "object", "object", "morphism" ],
  io_type = [ [ "a", "b", "f" ], [ "a", "i" ] ],
  return_type = "morphism",
  dual_operation = "CoproductToCoexponentialAdjunctionMap",
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

DirectProductToExponentialAdjunctionMapWithGivenExponential = rec(
  filter_list = [ "category", "object", "object", "morphism", "object" ],
  io_type = [ [ "a", "b", "f", "i" ], [ "a", "i" ] ],
  return_type = "morphism",
  dual_operation = "CoproductToCoexponentialAdjunctionMapWithGivenCoexponential",
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

ExponentialToDirectProductAdjunctionMap = rec(
  filter_list = [ "category", "object", "object", "morphism" ],
  io_type = [ [ "b", "c", "g" ], [ "t", "c" ] ],
  return_type = "morphism",
  dual_operation = "CoexponentialToCoproductAdjunctionMap",
  dual_preprocessor_func = ( cat, a, b, g ) -> NTupleGAP( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( g ) ),
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

ExponentialToDirectProductAdjunctionMapWithGivenDirectProduct = rec(
  filter_list = [ "category", "object", "object", "morphism", "object" ],
  io_type = [ [ "b", "c", "g", "t" ], [ "t", "c" ] ],
  return_type = "morphism",
  dual_operation = "CoexponentialToCoproductAdjunctionMapWithGivenCoproduct",
  dual_preprocessor_func = ( cat, a, b, g, t ) -> NTupleGAP( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( g ),Opposite( t ) ),
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianPreComposeMorphism = rec(
  filter_list = [ "category", "object", "object", "object" ],
  io_type = [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string = "BinaryDirectProduct( cat, ExponentialOnObjects( cat, a, b ), ExponentialOnObjects( cat, b, c ) )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "ExponentialOnObjects", 2 ] ],
  output_range_getter_string = "ExponentialOnObjects( cat, a, c )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "CocartesianPreCoComposeMorphism",
  dual_arguments_reversed = true,
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianPreComposeMorphismWithGivenObjects = rec(
  filter_list = [ "category", "object", "object", "object", "object", "object" ],
  io_type = [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "CocartesianPreCoComposeMorphismWithGivenObjects",
  dual_arguments_reversed = true,
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianPostComposeMorphism = rec(
  filter_list = [ "category", "object", "object", "object" ],
  io_type = [ [ "a", "b", "c" ], [ "s", "r" ] ],
  output_source_getter_string = "BinaryDirectProduct( cat, ExponentialOnObjects( cat, b, c ), ExponentialOnObjects( cat, a, b ) )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "ExponentialOnObjects", 2 ] ],
  output_range_getter_string = "ExponentialOnObjects( cat, a, c )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "CocartesianPostCoComposeMorphism",
  dual_arguments_reversed = true,
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianPostComposeMorphismWithGivenObjects = rec(
  filter_list = [ "category", "object", "object", "object", "object", "object" ],
  io_type = [ [ "s", "a", "b", "c", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "CocartesianPostCoComposeMorphismWithGivenObjects",
  dual_arguments_reversed = true,
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianDualOnObjects = rec(
  filter_list = [ "category", "object" ],
  input_arguments_names = [ "cat", "a" ],
  return_type = "object",
  dual_operation = "CocartesianDualOnObjects",
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianDualOnMorphisms = rec(
  filter_list = [ "category", "morphism" ],
  io_type = [ [ "alpha" ], [ "s", "r" ] ],
  output_source_getter_string = "CartesianDualOnObjects( cat, Range( alpha ) )",
  output_source_getter_preconditions = [ [ "CartesianDualOnObjects", 1 ] ],
  output_range_getter_string = "CartesianDualOnObjects( cat, Source( alpha ) )",
  output_range_getter_preconditions = [ [ "CartesianDualOnObjects", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "CocartesianDualOnMorphisms",
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianDualOnMorphismsWithGivenCartesianDuals = rec(
  filter_list = [ "category", "object", "morphism", "object" ],
  io_type = [ [ "s", "alpha", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "CocartesianDualOnMorphismsWithGivenCocartesianDuals",
  dual_arguments_reversed = true,
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianEvaluationForCartesianDual = rec(
  filter_list = [ "category", "object" ],
  io_type = [ [ "a" ], [ "s", "r" ] ],
  output_source_getter_string = "BinaryDirectProduct( cat, CartesianDualOnObjects( cat, a ), a )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "CartesianDualOnObjects", 1 ] ],
  output_range_getter_string = "TerminalObject( cat )",
  output_range_getter_preconditions = [ [ "TerminalObject", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "CocartesianEvaluationForCocartesianDual",
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianEvaluationForCartesianDualWithGivenDirectProduct = rec(
  filter_list = [ "category", "object", "object", "object" ],
  io_type = [ [ "s", "a", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "CocartesianEvaluationForCocartesianDualWithGivenCoproduct",
  dual_arguments_reversed = true,
  # Test ⥉ CartesianClosedCategoriesTest
),

MorphismToCartesianBidual = rec(
  filter_list = [ "category", "object" ],
  io_type = [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string = "a",
  output_range_getter_string = "CartesianDualOnObjects( cat, CartesianDualOnObjects( cat, a ) )",
  output_range_getter_preconditions = [ [ "CartesianDualOnObjects", 2 ] ],
  with_given_object_position = "Range",
  return_type = "morphism",
  dual_operation = "MorphismFromCocartesianBidual",
  # Test ⥉ CartesianClosedCategoriesTest
),

MorphismToCartesianBidualWithGivenCartesianBidual = rec(
  filter_list = [ "category", "object", "object" ],
  io_type = [ [ "a", "r" ], [ "a", "r" ] ],
  return_type = "morphism",
  dual_operation = "MorphismFromCocartesianBidualWithGivenCocartesianBidual",
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

DirectProductExponentialCompatibilityMorphism = rec(
  filter_list = [ "category", "list_of_objects" ],
  input_arguments_names = [ "cat", "list" ],
  output_source_getter_string = "BinaryDirectProduct( cat, ExponentialOnObjects( cat, list[1], list[2] ), ExponentialOnObjects( cat, list[3], list[4] ) )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "ExponentialOnObjects", 2 ] ],
  output_range_getter_string = "ExponentialOnObjects( cat, BinaryDirectProduct( cat, list[1], list[3] ), BinaryDirectProduct( cat, list[2], list[4] ) )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "DirectProduct", 2 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "CoexponentialCoproductCompatibilityMorphism",
  dual_preprocessor_func = ( cat, list ) -> PairGAP( Opposite( cat ), [ Opposite( list[2] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[3] ) ] ),
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

DirectProductExponentialCompatibilityMorphismWithGivenObjects = rec(
  filter_list = [ "category", "object", "list_of_objects", "object" ],
  input_arguments_names = [ "cat", "source", "list", "range" ],
  output_source_getter_string = "source",
  output_range_getter_string = "range",
  return_type = "morphism",
  dual_operation = "CoexponentialCoproductCompatibilityMorphismWithGivenObjects",
  dual_preprocessor_func =
    ( cat, s, list, r ) -> NTupleGAP( 4, Opposite( cat ), Opposite( r ), [ Opposite( list[2] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[3] ) ], Opposite( s ) ),
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

DirectProductCartesianDualityCompatibilityMorphism = rec(
  filter_list = [ "category", "object", "object" ],
  io_type = [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string = "BinaryDirectProduct( cat, CartesianDualOnObjects( cat, a ), CartesianDualOnObjects( cat, b ) )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "CartesianDualOnObjects", 2 ] ],
  output_range_getter_string = "CartesianDualOnObjects( cat, BinaryDirectProduct( cat, a, b ) )",
  output_range_getter_preconditions = [ [ "CartesianDualOnObjects", 1 ], [ "DirectProduct", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "CocartesianDualityCoproductCompatibilityMorphism",
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects = rec(
  filter_list = [ "category", "object", "object", "object", "object" ],
  io_type = [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects",
  dual_preprocessor_func = ( cat, s, a, b, r ) -> NTupleGAP( 5, Opposite( cat ), Opposite( r ), Opposite( a ), Opposite( b ), Opposite( s ) ),
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

MorphismFromDirectProductToExponential = rec(
  filter_list = [ "category", "object", "object" ],
  io_type = [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string = "BinaryDirectProduct( cat, CartesianDualOnObjects( cat, a ), b )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "CartesianDualOnObjects", 1 ] ],
  output_range_getter_string = "ExponentialOnObjects( cat, a, b )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "MorphismFromCoexponentialToCoproduct",
  dual_arguments_reversed = true,
  # Test ⥉ CartesianClosedCategoriesTest
),

MorphismFromDirectProductToExponentialWithGivenObjects = rec(
  filter_list = [ "category", "object", "object", "object", "object" ],
  io_type = [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "MorphismFromCoexponentialToCoproductWithGivenObjects",
  dual_arguments_reversed = true,
  # Test ⥉ CartesianClosedCategoriesTest
),

IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject = rec(
  filter_list = [ "category", "object" ],
  io_type = [ [ "a" ], [ "i", "d" ] ],
  output_source_getter_string = "ExponentialOnObjects( cat, a, TerminalObject( cat ) )",
  output_source_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "TerminalObject", 1 ] ],
  output_range_getter_string = "CartesianDualOnObjects( cat, a )",
  output_range_getter_preconditions = [ [ "CartesianDualOnObjects", 1 ] ],
  return_type = "morphism",
  dual_operation = "IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject",
  # Test ⥉ CartesianClosedCategoriesTest
),

IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject = rec(
  filter_list = [ "category", "object" ],
  io_type = [ [ "a" ], [ "d", "i" ] ],
  output_source_getter_string = "CartesianDualOnObjects( cat, a )",
  output_source_getter_preconditions = [ [ "CartesianDualOnObjects", 1 ] ],
  output_range_getter_string = "ExponentialOnObjects( cat, a, TerminalObject( cat ) )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "TerminalObject", 1 ] ],
  return_type = "morphism",
  dual_operation = "IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject",
  # Test ⥉ CartesianClosedCategoriesTest
),

UniversalPropertyOfCartesianDual = rec(
  filter_list = [ "category", "object", "object", "morphism" ],
  io_type = [ [ "t", "a", "alpha" ], [ "t", "d" ] ],
  return_type = "morphism",
  dual_operation = "UniversalPropertyOfCocartesianDual",
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianLambdaIntroduction = rec(
  filter_list = [ "category", "morphism" ],
  io_type = [ [ "alpha" ], [ "u", "i" ] ],
  return_type = "morphism",
  dual_operation = "CocartesianLambdaIntroduction",
  # Test ⥉ CartesianClosedCategoriesTest
),

CartesianLambdaElimination = rec(
  filter_list = [ "category", "object", "object", "morphism" ],
  io_type = [ [ "a", "b", "alpha" ], [ "a", "b" ] ],
  return_type = "morphism",
  dual_operation = "CocartesianLambdaElimination",
  dual_preprocessor_func = ( cat, a, b, alpha ) -> NTupleGAP( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( alpha ) ),
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

IsomorphismFromObjectToExponential = rec(
  filter_list = [ "category", "object" ],
  io_type = [ [ "a" ], [ "a", "r" ] ],
  output_source_getter_string = "a",
  output_range_getter_string = "ExponentialOnObjects( cat, TerminalObject( cat ), a )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "TerminalObject", 1 ] ],
  with_given_object_position = "Range",
  return_type = "morphism",
  dual_operation = "IsomorphismFromCoexponentialToObject",
  # Test ⥉ CartesianClosedCategoriesTest
),

IsomorphismFromObjectToExponentialWithGivenExponential = rec(
  filter_list = [ "category", "object", "object" ],
  io_type = [ [ "a", "r" ], [ "a", "r" ] ],
  return_type = "morphism",
  dual_operation = "IsomorphismFromCoexponentialToObjectWithGivenCoexponential",
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

IsomorphismFromExponentialToObject = rec(
  filter_list = [ "category", "object" ],
  io_type = [ [ "a" ], [ "s", "a" ] ],
  output_source_getter_string = "ExponentialOnObjects( cat, TerminalObject( cat ), a )",
  output_source_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "TerminalObject", 1 ] ],
  output_range_getter_string = "a",
  with_given_object_position = "Source",
  return_type = "morphism",
  dual_operation = "IsomorphismFromObjectToCoexponential",
  # Test ⥉ CartesianClosedCategoriesTest
),

IsomorphismFromExponentialToObjectWithGivenExponential = rec(
  filter_list = [ "category", "object", "object" ],
  io_type = [ [ "a", "s" ], [ "s", "a" ] ],
  return_type = "morphism",
  dual_operation = "IsomorphismFromObjectToCoexponentialWithGivenCoexponential",
  dual_arguments_reversed = false,
  # Test ⥉ CartesianClosedCategoriesTest
),

) );
