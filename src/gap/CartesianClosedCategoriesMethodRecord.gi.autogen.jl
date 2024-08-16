# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



@InstallValueConst( CARTESIAN_CLOSED_CATEGORIES_METHOD_NAME_RECORD, @rec(

ExponentialOnObjects = @rec(
  filter_list = [ "category", "object", "object" ],
  return_type = "object",
  input_arguments_names = [ "cat", "a", "b" ],
  dual_operation = "CoexponentialOnObjects",
  dual_arguments_reversed = true,
  # Test in CartesianClosedCategoriesTest
),

ExponentialOnMorphisms = @rec(
  filter_list = [ "category", "morphism", "morphism" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "alpha", "beta" ],
  output_source_getter_string = "ExponentialOnObjects( cat, Range( alpha ), Source( beta ) )",
  output_source_getter_preconditions = [ [ "ExponentialOnObjects", 1 ] ],
  output_range_getter_string = "ExponentialOnObjects( cat, Source( alpha ), Range( beta ) )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ] ],
  with_given_object_position = "both",
  dual_operation = "CoexponentialOnMorphisms",
  dual_arguments_reversed = true,
  # Test in CartesianClosedCategoriesTest
),

ExponentialOnMorphismsWithGivenExponentials = @rec(
  filter_list = [ "category", "object", "morphism", "morphism", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "s", "alpha", "beta", "r" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
  dual_operation = "CoexponentialOnMorphismsWithGivenCoexponentials",
  dual_arguments_reversed = true,
),

CartesianRightEvaluationMorphism = @rec(
  filter_list = [ "category", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b" ],
  output_source_getter_string = "BinaryDirectProduct( cat, a, ExponentialOnObjects( cat, a, b ) )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "ExponentialOnObjects", 1 ] ],
  output_range_getter_string = "b",
  output_range_getter_preconditions = [ ],
  with_given_object_position = "Source",
  dual_operation = "CocartesianRightEvaluationMorphism",
  dual_arguments_reversed = false,
  # Test in CartesianClosedCategoriesTest
),

CartesianRightEvaluationMorphismWithGivenSource = @rec(
  filter_list = [ "category", "object", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b", "s" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "b",
  output_range_getter_preconditions = [ ],
  dual_operation = "CocartesianRightEvaluationMorphismWithGivenRange",
  dual_arguments_reversed = false,
),

CartesianRightCoevaluationMorphism = @rec(
  filter_list = [ "category", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b" ],
  output_source_getter_string = "b",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "ExponentialOnObjects( cat, a, BinaryDirectProduct( cat, a, b ) )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "DirectProduct", 1 ] ],
  with_given_object_position = "Range",
  dual_operation = "CocartesianRightCoevaluationMorphism",
  dual_arguments_reversed = false,
  # Test in CartesianClosedCategoriesTest
),

CartesianRightCoevaluationMorphismWithGivenRange = @rec(
  filter_list = [ "category", "object", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b", "r" ],
  output_source_getter_string = "b",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
  dual_operation = "CocartesianRightCoevaluationMorphismWithGivenSource",
  dual_arguments_reversed = false,
),

DirectProductToExponentialRightAdjunctMorphism = @rec(
  filter_list = [ "category", "object", "object", "morphism" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b", "f" ],
  output_source_getter_string = "b",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "ExponentialOnObjects( cat, a, Range( f ) )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ] ],
  with_given_object_position = "Range",
  dual_operation = "CoproductToCoexponentialRightAdjunctMorphism",
  dual_arguments_reversed = false,
  # Test in CartesianClosedCategoriesTest
),

DirectProductToExponentialRightAdjunctMorphismWithGivenExponential = @rec(
  filter_list = [ "category", "object", "object", "morphism", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b", "f", "i" ],
  output_source_getter_string = "b",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "i",
  output_range_getter_preconditions = [ ],
  dual_operation = "CoproductToCoexponentialRightAdjunctMorphismWithGivenCoexponential",
  dual_arguments_reversed = false,
),

DirectProductToExponentialRightAdjunctionIsomorphism = @rec(
  filter_list = [ "category", "object", "object", "object" ],
  return_type = "morphism_in_range_category_of_homomorphism_structure",
  input_arguments_names = [ "cat", "a", "b", "c" ],
  output_source_getter_string = "HomomorphismStructureOnObjects( cat, BinaryDirectProduct( cat, a, b ), c )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "HomomorphismStructureOnObjects", 1 ] ],
  output_range_getter_string = "HomomorphismStructureOnObjects( cat, b, ExponentialOnObjects( cat, a, c ) )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "HomomorphismStructureOnObjects", 1 ] ],
  with_given_object_position = "both",
  # Test in CartesianClosedCategoriesTest
),

DirectProductToExponentialRightAdjunctionIsomorphismWithGivenObjects = @rec(
  filter_list = [ "category", "object_in_range_category_of_homomorphism_structure", "object", "object", "object", "object_in_range_category_of_homomorphism_structure" ],
  return_type = "morphism_in_range_category_of_homomorphism_structure",
  input_arguments_names = [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
),

ExponentialToDirectProductRightAdjunctMorphism = @rec(
  filter_list = [ "category", "object", "object", "morphism" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "c", "g" ],
  output_source_getter_string = "BinaryDirectProduct( cat, a, Source( g ) )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ] ],
  output_range_getter_string = "c",
  output_range_getter_preconditions = [ ],
  with_given_object_position = "Source",
  dual_operation = "CoexponentialToCoproductRightAdjunctMorphism",
  dual_preprocessor_func = ( cat, a, c, g ) -> @NTupleGAP( 4, Opposite( cat ), Opposite( c ), Opposite( a ), Opposite( g ) ),
  dual_arguments_reversed = false,
  # Test in CartesianClosedCategoriesTest
),

ExponentialToDirectProductRightAdjunctMorphismWithGivenDirectProduct = @rec(
  filter_list = [ "category", "object", "object", "morphism", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "c", "g", "s" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "c",
  output_range_getter_preconditions = [ ],
  dual_operation = "CoexponentialToCoproductRightAdjunctMorphismWithGivenCoproduct",
  dual_preprocessor_func = ( cat, a, c, g, s ) -> @NTupleGAP( 5, Opposite( cat ), Opposite( c ), Opposite( a ), Opposite( g ), Opposite( s ) ),
  dual_arguments_reversed = false,
  # Test in CartesianClosedCategoriesTestWithGiven
),

ExponentialToDirectProductRightAdjunctionIsomorphism = @rec(
  filter_list = [ "category", "object", "object", "object" ],
  return_type = "morphism_in_range_category_of_homomorphism_structure",
  input_arguments_names = [ "cat", "a", "b", "c" ],
  output_source_getter_string = "HomomorphismStructureOnObjects( cat, b, ExponentialOnObjects( cat, a, c ) )",
  output_source_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "HomomorphismStructureOnObjects", 1 ] ],
  output_range_getter_string = "HomomorphismStructureOnObjects( cat, BinaryDirectProduct( cat, a, b ), c )",
  output_range_getter_preconditions = [ [ "DirectProduct", 1 ], [ "HomomorphismStructureOnObjects", 1 ] ],
  with_given_object_position = "both",
  # Test in CartesianClosedCategoriesTest
),

ExponentialToDirectProductRightAdjunctionIsomorphismWithGivenObjects = @rec(
  filter_list = [ "category", "object_in_range_category_of_homomorphism_structure", "object", "object", "object", "object_in_range_category_of_homomorphism_structure" ],
  return_type = "morphism_in_range_category_of_homomorphism_structure",
  input_arguments_names = [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
),

CartesianLeftEvaluationMorphism = @rec(
  filter_list = [ "category", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b" ],
  output_source_getter_string = "BinaryDirectProduct( cat, ExponentialOnObjects( cat, a, b ), a )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "ExponentialOnObjects", 1 ] ],
  output_range_getter_string = "b",
  output_range_getter_preconditions = [ ],
  with_given_object_position = "Source",
  dual_operation = "CocartesianLeftEvaluationMorphism",
  dual_arguments_reversed = false,
  # Test in CartesianClosedCategoriesTest
),

CartesianLeftEvaluationMorphismWithGivenSource = @rec(
  filter_list = [ "category", "object", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b", "s" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "b",
  output_range_getter_preconditions = [ ],
  dual_operation = "CocartesianLeftEvaluationMorphismWithGivenRange",
  dual_arguments_reversed = false,
),

CartesianLeftCoevaluationMorphism = @rec(
  filter_list = [ "category", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b" ],
  output_source_getter_string = "b",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "ExponentialOnObjects( cat, a, BinaryDirectProduct( cat, b, a ) )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "DirectProduct", 1 ] ],
  with_given_object_position = "Range",
  dual_operation = "CocartesianLeftCoevaluationMorphism",
  dual_arguments_reversed = false,
  # Test in CartesianClosedCategoriesTest
),

CartesianLeftCoevaluationMorphismWithGivenRange = @rec(
  filter_list = [ "category", "object", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b", "r" ],
  output_source_getter_string = "b",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
  dual_operation = "CocartesianLeftCoevaluationMorphismWithGivenSource",
  dual_arguments_reversed = false,
),

DirectProductToExponentialLeftAdjunctMorphism = @rec(
  filter_list = [ "category", "object", "object", "morphism" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b", "f" ],
  output_source_getter_string = "a",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "ExponentialOnObjects( cat, b, Range( f ) )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ] ],
  with_given_object_position = "Range",
  dual_operation = "CoproductToCoexponentialLeftAdjunctMorphism",
  dual_arguments_reversed = false,
  # Test in CartesianClosedCategoriesTest
),

DirectProductToExponentialLeftAdjunctMorphismWithGivenExponential = @rec(
  filter_list = [ "category", "object", "object", "morphism", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b", "f", "i" ],
  output_source_getter_string = "a",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "i",
  output_range_getter_preconditions = [ ],
  dual_operation = "CoproductToCoexponentialLeftAdjunctMorphismWithGivenCoexponential",
  dual_arguments_reversed = false,
),

DirectProductToExponentialLeftAdjunctionIsomorphism = @rec(
  filter_list = [ "category", "object", "object", "object" ],
  return_type = "morphism_in_range_category_of_homomorphism_structure",
  input_arguments_names = [ "cat", "a", "b", "c" ],
  output_source_getter_string = "HomomorphismStructureOnObjects( cat, BinaryDirectProduct( cat, a, b ), c )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "HomomorphismStructureOnObjects", 1 ] ],
  output_range_getter_string = "HomomorphismStructureOnObjects( cat, a, ExponentialOnObjects( cat, b, c ) )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "HomomorphismStructureOnObjects", 1 ] ],
  with_given_object_position = "both",
  # Test in CartesianClosedCategoriesTest
),

DirectProductToExponentialLeftAdjunctionIsomorphismWithGivenObjects = @rec(
  filter_list = [ "category", "object_in_range_category_of_homomorphism_structure", "object", "object", "object", "object_in_range_category_of_homomorphism_structure" ],
  return_type = "morphism_in_range_category_of_homomorphism_structure",
  input_arguments_names = [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
),

ExponentialToDirectProductLeftAdjunctMorphism = @rec(
  filter_list = [ "category", "object", "object", "morphism" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "b", "c", "g" ],
  output_source_getter_string = "BinaryDirectProduct( cat, Source( g ), b )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ] ],
  output_range_getter_string = "c",
  output_range_getter_preconditions = [ ],
  with_given_object_position = "Source",
  dual_operation = "CoexponentialToCoproductLeftAdjunctMorphism",
  dual_preprocessor_func = ( cat, a, b, g ) -> @NTupleGAP( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( g ) ),
  dual_arguments_reversed = false,
  # Test in CartesianClosedCategoriesTest
),

ExponentialToDirectProductLeftAdjunctMorphismWithGivenDirectProduct = @rec(
  filter_list = [ "category", "object", "object", "morphism", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "b", "c", "g", "s" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "c",
  output_range_getter_preconditions = [ ],
  dual_operation = "CoexponentialToCoproductLeftAdjunctMorphismWithGivenCoproduct",
  dual_preprocessor_func = ( cat, a, b, g, s ) -> @NTupleGAP( 5, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( g ), Opposite( s ) ),
  dual_arguments_reversed = false,
),

ExponentialToDirectProductLeftAdjunctionIsomorphism = @rec(
  filter_list = [ "category", "object", "object", "object" ],
  return_type = "morphism_in_range_category_of_homomorphism_structure",
  input_arguments_names = [ "cat", "a", "b", "c" ],
  output_source_getter_string = "HomomorphismStructureOnObjects( cat, a, ExponentialOnObjects( cat, b, c ) )",
  output_source_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "HomomorphismStructureOnObjects", 1 ] ],
  output_range_getter_string = "HomomorphismStructureOnObjects( cat, BinaryDirectProduct( cat, a, b ), c )",
  output_range_getter_preconditions = [ [ "DirectProduct", 1 ], [ "HomomorphismStructureOnObjects", 1 ] ],
  with_given_object_position = "both",
  # Test in CartesianClosedCategoriesTest
),

ExponentialToDirectProductLeftAdjunctionIsomorphismWithGivenObjects = @rec(
  filter_list = [ "category", "object_in_range_category_of_homomorphism_structure", "object", "object", "object", "object_in_range_category_of_homomorphism_structure" ],
  return_type = "morphism_in_range_category_of_homomorphism_structure",
  input_arguments_names = [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
),

CartesianPreComposeMorphism = @rec(
  filter_list = [ "category", "object", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b", "c" ],
  output_source_getter_string = "BinaryDirectProduct( cat, ExponentialOnObjects( cat, a, b ), ExponentialOnObjects( cat, b, c ) )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "ExponentialOnObjects", 2 ] ],
  output_range_getter_string = "ExponentialOnObjects( cat, a, c )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ] ],
  with_given_object_position = "both",
  dual_operation = "CocartesianPreCoComposeMorphism",
  dual_arguments_reversed = true,
  # Test in CartesianClosedCategoriesTest
),

CartesianPreComposeMorphismWithGivenObjects = @rec(
  filter_list = [ "category", "object", "object", "object", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
  dual_operation = "CocartesianPreCoComposeMorphismWithGivenObjects",
  dual_arguments_reversed = true,
),

CartesianPostComposeMorphism = @rec(
  filter_list = [ "category", "object", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b", "c" ],
  output_source_getter_string = "BinaryDirectProduct( cat, ExponentialOnObjects( cat, b, c ), ExponentialOnObjects( cat, a, b ) )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "ExponentialOnObjects", 2 ] ],
  output_range_getter_string = "ExponentialOnObjects( cat, a, c )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ] ],
  with_given_object_position = "both",
  dual_operation = "CocartesianPostCoComposeMorphism",
  dual_arguments_reversed = true,
  # Test in CartesianClosedCategoriesTest
),

CartesianPostComposeMorphismWithGivenObjects = @rec(
  filter_list = [ "category", "object", "object", "object", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "s", "a", "b", "c", "r" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
  dual_operation = "CocartesianPostCoComposeMorphismWithGivenObjects",
  dual_arguments_reversed = true,
),

CartesianDualOnObjects = @rec(
  filter_list = [ "category", "object" ],
  return_type = "object",
  input_arguments_names = [ "cat", "a" ],
  dual_operation = "CocartesianDualOnObjects",
  # Test in CartesianClosedCategoriesTest
),

CartesianDualOnMorphisms = @rec(
  filter_list = [ "category", "morphism" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "alpha" ],
  output_source_getter_string = "CartesianDualOnObjects( cat, Range( alpha ) )",
  output_source_getter_preconditions = [ [ "CartesianDualOnObjects", 1 ] ],
  output_range_getter_string = "CartesianDualOnObjects( cat, Source( alpha ) )",
  output_range_getter_preconditions = [ [ "CartesianDualOnObjects", 1 ] ],
  with_given_object_position = "both",
  dual_operation = "CocartesianDualOnMorphisms",
  # Test in CartesianClosedCategoriesTest
),

CartesianDualOnMorphismsWithGivenCartesianDuals = @rec(
  filter_list = [ "category", "object", "morphism", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "s", "alpha", "r" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
  dual_operation = "CocartesianDualOnMorphismsWithGivenCocartesianDuals",
  dual_arguments_reversed = true,
),

CartesianEvaluationForCartesianDual = @rec(
  filter_list = [ "category", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a" ],
  output_source_getter_string = "BinaryDirectProduct( cat, CartesianDualOnObjects( cat, a ), a )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "CartesianDualOnObjects", 1 ] ],
  output_range_getter_string = "TerminalObject( cat )",
  output_range_getter_preconditions = [ [ "TerminalObject", 1 ] ],
  with_given_object_position = "both",
  dual_operation = "CocartesianEvaluationForCocartesianDual",
  # Test in CartesianClosedCategoriesTest
),

CartesianEvaluationForCartesianDualWithGivenDirectProduct = @rec(
  filter_list = [ "category", "object", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "s", "a", "r" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
  dual_operation = "CocartesianEvaluationForCocartesianDualWithGivenCoproduct",
  dual_arguments_reversed = true,
),

MorphismToCartesianBidual = @rec(
  filter_list = [ "category", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a" ],
  output_source_getter_string = "a",
  output_source_getter_preconditions = [ ],
  output_source_getter_string = "a",
  output_range_getter_string = "CartesianDualOnObjects( cat, CartesianDualOnObjects( cat, a ) )",
  output_range_getter_preconditions = [ [ "CartesianDualOnObjects", 2 ] ],
  with_given_object_position = "Range",
  dual_operation = "MorphismFromCocartesianBidual",
  # Test in CartesianClosedCategoriesTest
),

MorphismToCartesianBidualWithGivenCartesianBidual = @rec(
  filter_list = [ "category", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "r" ],
  output_source_getter_string = "a",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
  dual_operation = "MorphismFromCocartesianBidualWithGivenCocartesianBidual",
  dual_arguments_reversed = false,
),

DirectProductExponentialCompatibilityMorphism = @rec(
  filter_list = [ "category", "list_of_objects" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "list" ],
  output_source_getter_string = "BinaryDirectProduct( cat, ExponentialOnObjects( cat, list[1], list[2] ), ExponentialOnObjects( cat, list[3], list[4] ) )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "ExponentialOnObjects", 2 ] ],
  output_range_getter_string = "ExponentialOnObjects( cat, BinaryDirectProduct( cat, list[1], list[3] ), BinaryDirectProduct( cat, list[2], list[4] ) )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "DirectProduct", 2 ] ],
  with_given_object_position = "both",
  dual_operation = "CoexponentialCoproductCompatibilityMorphism",
  dual_preprocessor_func = ( cat, list ) -> PairGAP( Opposite( cat ), [ Opposite( list[2] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[3] ) ] ),
  dual_arguments_reversed = false,
  # Test in CartesianClosedCategoriesTest
),

DirectProductExponentialCompatibilityMorphismWithGivenObjects = @rec(
  filter_list = [ "category", "object", "list_of_objects", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "source", "list", "range" ],
  output_source_getter_string = "source",
  output_range_getter_string = "range",
  dual_operation = "CoexponentialCoproductCompatibilityMorphismWithGivenObjects",
  dual_preprocessor_func =
    ( cat, s, list, r ) -> @NTupleGAP( 4, Opposite( cat ), Opposite( r ), [ Opposite( list[2] ), Opposite( list[4] ), Opposite( list[1] ), Opposite( list[3] ) ], Opposite( s ) ),
  dual_arguments_reversed = false,
),

DirectProductCartesianDualityCompatibilityMorphism = @rec(
  filter_list = [ "category", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b" ],
  output_source_getter_string = "BinaryDirectProduct( cat, CartesianDualOnObjects( cat, a ), CartesianDualOnObjects( cat, b ) )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "CartesianDualOnObjects", 2 ] ],
  output_range_getter_string = "CartesianDualOnObjects( cat, BinaryDirectProduct( cat, a, b ) )",
  output_range_getter_preconditions = [ [ "CartesianDualOnObjects", 1 ], [ "DirectProduct", 1 ] ],
  with_given_object_position = "both",
  dual_operation = "CocartesianDualityCoproductCompatibilityMorphism",
  dual_arguments_reversed = false,
  # Test in CartesianClosedCategoriesTest
),

DirectProductCartesianDualityCompatibilityMorphismWithGivenObjects = @rec(
  filter_list = [ "category", "object", "object", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
  dual_operation = "CocartesianDualityCoproductCompatibilityMorphismWithGivenObjects",
  dual_with_given_objects_reversed = true,
),

MorphismFromDirectProductToExponential = @rec(
  filter_list = [ "category", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b" ],
  output_source_getter_string = "BinaryDirectProduct( cat, CartesianDualOnObjects( cat, a ), b )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "CartesianDualOnObjects", 1 ] ],
  output_range_getter_string = "ExponentialOnObjects( cat, a, b )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ] ],
  with_given_object_position = "both",
  dual_operation = "MorphismFromCoexponentialToCoproduct",
  dual_arguments_reversed = true,
  # Test in CartesianClosedCategoriesTest
),

MorphismFromDirectProductToExponentialWithGivenObjects = @rec(
  filter_list = [ "category", "object", "object", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "s", "a", "b", "r" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
  dual_operation = "MorphismFromCoexponentialToCoproductWithGivenObjects",
  dual_arguments_reversed = true,
),

IsomorphismFromExponentialIntoTerminalObjectToCartesianDualObject = @rec(
  filter_list = [ "category", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a" ],
  output_source_getter_string = "ExponentialOnObjects( cat, a, TerminalObject( cat ) )",
  output_source_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "TerminalObject", 1 ] ],
  output_range_getter_string = "CartesianDualOnObjects( cat, a )",
  output_range_getter_preconditions = [ [ "CartesianDualOnObjects", 1 ] ],
  dual_operation = "IsomorphismFromCocartesianDualObjectToCoexponentialFromInitialObject",
  # Test in CartesianClosedCategoriesTest
),

IsomorphismFromCartesianDualObjectToExponentialIntoTerminalObject = @rec(
  filter_list = [ "category", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a" ],
  output_source_getter_string = "CartesianDualOnObjects( cat, a )",
  output_source_getter_preconditions = [ [ "CartesianDualOnObjects", 1 ] ],
  output_range_getter_string = "ExponentialOnObjects( cat, a, TerminalObject( cat ) )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "TerminalObject", 1 ] ],
  dual_operation = "IsomorphismFromCoexponentialFromInitialObjectToCocartesianDualObject",
  # Test in CartesianClosedCategoriesTest
),

UniversalPropertyOfCartesianDual = @rec(
  filter_list = [ "category", "object", "object", "morphism" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "t", "a", "alpha" ],
  output_source_getter_string = "t",
  output_source_getter_preconditions = [ ],
  dual_operation = "UniversalPropertyOfCocartesianDual",
  dual_arguments_reversed = false,
  # Test in CartesianClosedCategoriesTest
),

CartesianLambdaIntroduction = @rec(
  filter_list = [ "category", "morphism" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "alpha" ],
  dual_operation = "CocartesianLambdaIntroduction",
  # Test in CartesianClosedCategoriesTest
),

CartesianLambdaElimination = @rec(
  filter_list = [ "category", "object", "object", "morphism" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "b", "alpha" ],
  output_source_getter_string = "a",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "b",
  output_range_getter_preconditions = [ ],
  dual_operation = "CocartesianLambdaElimination",
  dual_preprocessor_func = ( cat, a, b, alpha ) -> @NTupleGAP( 4, Opposite( cat ), Opposite( b ), Opposite( a ), Opposite( alpha ) ),
  dual_arguments_reversed = false,
  # Test in CartesianClosedCategoriesTest
),

IsomorphismFromObjectToExponential = @rec(
  filter_list = [ "category", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a" ],
  output_source_getter_string = "a",
  output_source_getter_preconditions = [ ],
  output_source_getter_string = "a",
  output_range_getter_string = "ExponentialOnObjects( cat, TerminalObject( cat ), a )",
  output_range_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "TerminalObject", 1 ] ],
  with_given_object_position = "Range",
  dual_operation = "IsomorphismFromCoexponentialToObject",
  # Test in CartesianClosedCategoriesTest
),

IsomorphismFromObjectToExponentialWithGivenExponential = @rec(
  filter_list = [ "category", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "r" ],
  output_source_getter_string = "a",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "r",
  output_range_getter_preconditions = [ ],
  dual_operation = "IsomorphismFromCoexponentialToObjectWithGivenCoexponential",
  dual_arguments_reversed = false,
),

IsomorphismFromExponentialToObject = @rec(
  filter_list = [ "category", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a" ],
  output_range_getter_string = "a",
  output_range_getter_preconditions = [ ],
  output_source_getter_string = "ExponentialOnObjects( cat, TerminalObject( cat ), a )",
  output_source_getter_preconditions = [ [ "ExponentialOnObjects", 1 ], [ "TerminalObject", 1 ] ],
  output_range_getter_string = "a",
  with_given_object_position = "Source",
  dual_operation = "IsomorphismFromObjectToCoexponential",
  # Test in CartesianClosedCategoriesTest
),

IsomorphismFromExponentialToObjectWithGivenExponential = @rec(
  filter_list = [ "category", "object", "object" ],
  return_type = "morphism",
  input_arguments_names = [ "cat", "a", "s" ],
  output_source_getter_string = "s",
  output_source_getter_preconditions = [ ],
  output_range_getter_string = "a",
  output_range_getter_preconditions = [ ],
  dual_operation = "IsomorphismFromObjectToCoexponentialWithGivenCoexponential",
  dual_arguments_reversed = false,
),

) );
