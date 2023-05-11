# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal && monoidal (co)closed categories
#
# Implementations
#

@InstallValueConst( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, @rec(

LeftDistributivityExpanding = @rec(
  filter_list = [ "category", "object", "list_of_objects" ],
  io_type = [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string = "TensorProductOnObjects( cat, a, DirectSum( cat, L ) )",
  output_source_getter_preconditions = [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  output_range_getter_string = "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, a, summand ) ) )",
  output_range_getter_preconditions = [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "LeftDistributivityFactoring",
  dual_arguments_reversed = false,
  # Test ⥉ AdditiveMonoidalCategoriesTest
),

LeftDistributivityExpandingWithGivenObjects = @rec(
  filter_list = [ "category", "object", "object", "list_of_objects", "object" ],
  io_type = [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "LeftDistributivityFactoringWithGivenObjects",
  dual_with_given_objects_reversed = true,
),

LeftDistributivityFactoring = @rec(
  filter_list = [ "category", "object", "list_of_objects" ],
  io_type = [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string = "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, a, summand ) ) )",
  output_source_getter_preconditions = [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  output_range_getter_string = "TensorProductOnObjects( cat, a, DirectSum( cat, L ) )",
  output_range_getter_preconditions = [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "LeftDistributivityExpanding",
  dual_arguments_reversed = false,
  # Test ⥉ AdditiveMonoidalCategoriesTest
),

LeftDistributivityFactoringWithGivenObjects = @rec(
  filter_list = [ "category", "object", "object", "list_of_objects", "object" ],
  io_type = [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "LeftDistributivityExpandingWithGivenObjects",
  dual_with_given_objects_reversed = true,
),

RightDistributivityExpanding = @rec(
  filter_list = [ "category", "list_of_objects", "object" ],
  io_type = [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string = "TensorProductOnObjects( cat, DirectSum( cat, L ), a )",
  output_source_getter_preconditions = [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  output_range_getter_string = "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, summand, a ) ) )",
  output_range_getter_preconditions = [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "RightDistributivityFactoring",
  dual_arguments_reversed = false,
  # Test ⥉ AdditiveMonoidalCategoriesTest
),

RightDistributivityExpandingWithGivenObjects = @rec(
  filter_list = [ "category", "object", "list_of_objects", "object", "object" ],
  io_type = [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "RightDistributivityFactoringWithGivenObjects",
  dual_with_given_objects_reversed = true,
),

RightDistributivityFactoring = @rec(
  filter_list = [ "category", "list_of_objects", "object" ],
  io_type = [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string = "DirectSum( cat, List( L, summand -> TensorProductOnObjects( cat, summand, a ) ) )",
  output_source_getter_preconditions = [ [ "DirectSum", 1 ], [ "TensorProductOnObjects", 2 ] ],
  output_range_getter_string = "TensorProductOnObjects( cat, DirectSum( cat, L ), a )",
  output_range_getter_preconditions = [ [ "TensorProductOnObjects", 1 ], [ "DirectSum", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "RightDistributivityExpanding",
  dual_arguments_reversed = false,
  # Test ⥉ AdditiveMonoidalCategoriesTest
),

RightDistributivityFactoringWithGivenObjects = @rec(
  filter_list = [ "category", "object", "list_of_objects", "object", "object" ],
  io_type = [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "RightDistributivityExpandingWithGivenObjects",
  dual_with_given_objects_reversed = true,
),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "AdditiveMonoidalCategories.autogen.gd",
    "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( DISTRIBUTIVE_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
