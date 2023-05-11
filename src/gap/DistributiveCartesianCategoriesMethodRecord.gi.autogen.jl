# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian && cocartesian categories && various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



@InstallValueConst( DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD, @rec(

LeftCartesianDistributivityExpanding = @rec(
  filter_list = [ "category", "object", "list_of_objects" ],
  io_type = [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string = "BinaryDirectProduct( cat, a, Coproduct( cat, L ) )",
  output_source_getter_preconditions = [ [ "Coproduct", 1 ], [ "DirectProduct", 1 ] ],
  output_range_getter_string = "Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, a, summand ) ) )",
  output_range_getter_preconditions = [ [ "Coproduct", 1 ], [ "DirectProduct", 2 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "LeftCocartesianCodistributivityFactoring",
  dual_arguments_reversed = false,
  # Test ⥉ DistributiveCartesianCategoriesTest
),

LeftCartesianDistributivityExpandingWithGivenObjects = @rec(
  filter_list = [ "category", "object", "object", "list_of_objects", "object" ],
  io_type = [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "LeftCocartesianCodistributivityFactoringWithGivenObjects",
  dual_with_given_objects_reversed = true,
  # Test ⥉ DistributiveCartesianCategoriesTest
),

LeftCartesianDistributivityFactoring = @rec(
  filter_list = [ "category", "object", "list_of_objects" ],
  io_type = [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string = "Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, a, summand ) ) )",
  output_source_getter_preconditions = [ [ "Coproduct", 1 ], [ "DirectProduct", 2 ] ],
  output_range_getter_string = "BinaryDirectProduct( cat, a, Coproduct( cat, L ) )",
  output_range_getter_preconditions = [ [ "Coproduct", 1 ], [ "DirectProduct", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "LeftCocartesianCodistributivityExpanding",
  dual_arguments_reversed = false,
  # Test ⥉ DistributiveCartesianCategoriesTest
),

LeftCartesianDistributivityFactoringWithGivenObjects = @rec(
  filter_list = [ "category", "object", "object", "list_of_objects", "object" ],
  io_type = [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "LeftCocartesianCodistributivityExpandingWithGivenObjects",
  dual_with_given_objects_reversed = true,
  # Test ⥉ DistributiveCartesianCategoriesTest
),

RightCartesianDistributivityExpanding = @rec(
  filter_list = [ "category", "list_of_objects", "object" ],
  io_type = [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string = "BinaryDirectProduct( cat, Coproduct( cat, L ), a )",
  output_source_getter_preconditions = [ [ "Coproduct", 1 ], [ "DirectProduct", 1 ] ],
  output_range_getter_string = "Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, summand, a ) ) )",
  output_range_getter_preconditions = [ [ "Coproduct", 1 ], [ "DirectProduct", 2 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "RightCocartesianCodistributivityFactoring",
  dual_arguments_reversed = false,
  # Test ⥉ DistributiveCartesianCategoriesTest
),

RightCartesianDistributivityExpandingWithGivenObjects = @rec(
  filter_list = [ "category", "object", "list_of_objects", "object", "object" ],
  io_type = [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "RightCocartesianCodistributivityFactoringWithGivenObjects",
  dual_with_given_objects_reversed = true,
  # Test ⥉ DistributiveCartesianCategoriesTest
),

RightCartesianDistributivityFactoring = @rec(
  filter_list = [ "category", "list_of_objects", "object" ],
  io_type = [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string = "Coproduct( cat, List( L, summand -> BinaryDirectProduct( cat, summand, a ) ) )",
  output_source_getter_preconditions = [ [ "Coproduct", 1 ], [ "DirectProduct", 2 ] ],
  output_range_getter_string = "BinaryDirectProduct( cat, Coproduct( cat, L ), a )",
  output_range_getter_preconditions = [ [ "Coproduct", 1 ], [ "DirectProduct", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "RightCocartesianCodistributivityExpanding",
  dual_arguments_reversed = false,
  # Test ⥉ DistributiveCartesianCategoriesTest
),

RightCartesianDistributivityFactoringWithGivenObjects = @rec(
  filter_list = [ "category", "object", "list_of_objects", "object", "object" ],
  io_type = [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "RightCocartesianCodistributivityExpandingWithGivenObjects",
  dual_with_given_objects_reversed = true,
  # Test ⥉ DistributiveCartesianCategoriesTest
),

) );
