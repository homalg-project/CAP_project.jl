# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal && monoidal (co)closed categories
#
# Implementations
#

@InstallValueConst( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, rec(

Braiding = rec(
  filter_list = [ "category", "object", "object" ],
  io_type = [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string = "TensorProductOnObjects( cat, a, b )",
  output_source_getter_preconditions = [ [ "TensorProductOnObjects", 1 ] ],
  output_range_getter_string = "TensorProductOnObjects( cat, b, a )",
  output_range_getter_preconditions = [ [ "TensorProductOnObjects", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "BraidingInverse",
  dual_arguments_reversed = false,
  # Test ⥉ BraidedMonoidalCategoriesTest
),

BraidingWithGivenTensorProducts = rec(
  filter_list = [ "category", "object", "object", "object", "object" ],
  io_type = [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "BraidingInverseWithGivenTensorProducts",
  dual_with_given_objects_reversed = true,
),

BraidingInverse = rec(
  filter_list = [ "category", "object", "object" ],
  io_type = [ [ "a", "b" ], [ "s", "r" ] ],
  output_source_getter_string = "TensorProductOnObjects( cat, b, a )",
  output_source_getter_preconditions = [ [ "TensorProductOnObjects", 1 ] ],
  output_range_getter_string = "TensorProductOnObjects( cat, a, b )",
  output_range_getter_preconditions = [ [ "TensorProductOnObjects", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "Braiding",
  dual_arguments_reversed = false,
  # Test ⥉ BraidedMonoidalCategoriesTest
),

BraidingInverseWithGivenTensorProducts = rec(
  filter_list = [ "category", "object", "object", "object", "object" ],
  io_type = [ [ "s", "a", "b", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "BraidingWithGivenTensorProducts",
  dual_with_given_objects_reversed = true,
),

) );

CAP_INTERNAL_ENHANCE_NAME_RECORD( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD,
    "MonoidalCategories",
    "BraidedMonoidalCategories.autogen.gd",
    "Monoidal Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD, "MonoidalCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( BRAIDED_MONOIDAL_CATEGORIES_METHOD_NAME_RECORD );
