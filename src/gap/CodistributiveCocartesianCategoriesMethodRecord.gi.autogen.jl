# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian && cocartesian categories && various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



@InstallValueConst( CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, rec(

LeftCocartesianCodistributivityExpanding = rec(
  filter_list = [ "category", "object", "list_of_objects" ],
  io_type = [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string = "BinaryCoproduct( cat, a, DirectProduct( cat, L ) )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "Coproduct", 1 ] ],
  output_range_getter_string = "DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, a, summand ) ) )",
  output_range_getter_preconditions = [ [ "DirectProduct", 1 ], [ "Coproduct", 2 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "LeftCartesianDistributivityFactoring",
  dual_arguments_reversed = false,
  # Test ⥉ CodistributiveCocartesianCategoriesTest
),

LeftCocartesianCodistributivityExpandingWithGivenObjects = rec(
  filter_list = [ "category", "object", "object", "list_of_objects", "object" ],
  io_type = [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "LeftCartesianDistributivityFactoringWithGivenObjects",
  dual_preprocessor_func = ( cat, s, a, L, r ) -> [ Opposite( cat ), Opposite( r ), Opposite( a ), List( L, Opposite ), Opposite( s ) ],
  dual_arguments_reversed = false,
  # Test ⥉ CodistributiveCocartesianCategoriesTest
),

LeftCocartesianCodistributivityFactoring = rec(
  filter_list = [ "category", "object", "list_of_objects" ],
  io_type = [ [ "a", "L" ], [ "s", "r" ] ],
  output_source_getter_string = "DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, a, summand ) ) )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "Coproduct", 2 ] ],
  output_range_getter_string = "BinaryCoproduct( cat, a, DirectProduct( cat, L ) )",
  output_range_getter_preconditions = [ [ "DirectProduct", 1 ], [ "Coproduct", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "LeftCartesianDistributivityExpanding",
  dual_arguments_reversed = false,
  # Test ⥉ CodistributiveCocartesianCategoriesTest
),

LeftCocartesianCodistributivityFactoringWithGivenObjects = rec(
  filter_list = [ "category", "object", "object", "list_of_objects", "object" ],
  io_type = [ [ "s", "a", "L", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "LeftCartesianDistributivityExpandingWithGivenObjects",
  dual_preprocessor_func = ( cat, s, a, L, r ) -> [ Opposite( cat ), Opposite( r ), Opposite( a ), List( L, Opposite ), Opposite( s ) ],
  dual_arguments_reversed = false,
  # Test ⥉ CodistributiveCocartesianCategoriesTest
),

RightCocartesianCodistributivityExpanding = rec(
  filter_list = [ "category", "list_of_objects", "object" ],
  io_type = [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string = "BinaryCoproduct( cat, DirectProduct( cat, L ), a )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "Coproduct", 1 ] ],
  output_range_getter_string = "DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, summand, a ) ) )",
  output_range_getter_preconditions = [ [ "DirectProduct", 1 ], [ "Coproduct", 2 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "RightCartesianDistributivityFactoring",
  dual_arguments_reversed = false,
  # Test ⥉ CodistributiveCocartesianCategoriesTest
),

RightCocartesianCodistributivityExpandingWithGivenObjects = rec(
  filter_list = [ "category", "object", "list_of_objects", "object", "object" ],
  io_type = [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "RightCartesianDistributivityFactoringWithGivenObjects",
  dual_preprocessor_func = ( cat, s, L, a, r ) -> [ Opposite( cat ), Opposite( r ), List( L, Opposite ), Opposite( a ), Opposite( s ) ],
  dual_arguments_reversed = false,
  # Test ⥉ CodistributiveCocartesianCategoriesTest
),

RightCocartesianCodistributivityFactoring = rec(
  filter_list = [ "category", "list_of_objects", "object" ],
  io_type = [ [ "L", "a" ], [ "s", "r" ] ],
  output_source_getter_string = "DirectProduct( cat, List( L, summand -> BinaryCoproduct( cat, summand, a ) ) )",
  output_source_getter_preconditions = [ [ "DirectProduct", 1 ], [ "Coproduct", 2 ] ],
  output_range_getter_string = "BinaryCoproduct( cat, DirectProduct( cat, L ), a )",
  output_range_getter_preconditions = [ [ "DirectProduct", 1 ], [ "Coproduct", 1 ] ],
  with_given_object_position = "both",
  return_type = "morphism",
  dual_operation = "RightCartesianDistributivityExpanding",
  dual_arguments_reversed = false,
  # Test ⥉ CodistributiveCocartesianCategoriesTest
),

RightCocartesianCodistributivityFactoringWithGivenObjects = rec(
  filter_list = [ "category", "object", "list_of_objects", "object", "object" ],
  io_type = [ [ "s", "L", "a", "r" ], [ "s", "r" ] ],
  return_type = "morphism",
  dual_operation = "RightCartesianDistributivityExpandingWithGivenObjects",
  dual_preprocessor_func = ( cat, s, L, a, r ) -> [ Opposite( cat ), Opposite( r ), List( L, Opposite ), Opposite( a ), Opposite( s ) ],
  dual_arguments_reversed = false,
  # Test ⥉ CodistributiveCocartesianCategoriesTest
),

) );

# collect distributive && codistributive operations
@BindGlobal( "DISTRIBUTIVE_CARTESIAN_AND_CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD", rec( ) );

Perform( RecNames( DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD ), function ( name )
    
    DISTRIBUTIVE_CARTESIAN_AND_CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD[name] = DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD[name];
    
end );

Perform( RecNames( CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD ), function ( name )
    
    DISTRIBUTIVE_CARTESIAN_AND_CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD[name] = CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD[name];
    
end );

CAP_INTERNAL_ENHANCE_NAME_RECORD( DISTRIBUTIVE_CARTESIAN_AND_CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    DISTRIBUTIVE_CARTESIAN_CATEGORIES_METHOD_NAME_RECORD,
    "CartesianCategories",
    "DistributiveCartesianCategories.autogen.gd",
    "Cartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_GENERATE_DOCUMENTATION_FROM_METHOD_NAME_RECORD(
    CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD,
    "CartesianCategories",
    "CodistributiveCocartesianCategories.autogen.gd",
    "Cocartesian Categories",
    "Add-methods"
);

CAP_INTERNAL_REGISTER_METHOD_NAME_RECORD_OF_PACKAGE( DISTRIBUTIVE_CARTESIAN_AND_CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD, "CartesianCategories" );

CAP_INTERNAL_INSTALL_ADDS_FROM_RECORD( DISTRIBUTIVE_CARTESIAN_AND_CODISTRIBUTIVE_COCARTESIAN_CATEGORIES_METHOD_NAME_RECORD );
