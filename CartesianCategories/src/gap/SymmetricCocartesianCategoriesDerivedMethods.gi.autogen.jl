# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CocartesianBraidingWithGivenCoproducts,
                    "CocartesianBraidingWithGivenCoproducts using CocartesianBraidingInverseWithGivenCoproducts",
                    [ [ CocartesianBraidingInverseWithGivenCoproducts, 1 ] ],
                    
  function( cat, object_1_u_object_2, object_1, object_2, object_2_u_object_1 )
    
    return CocartesianBraidingInverseWithGivenCoproducts( cat,
                            object_1_u_object_2,
                            object_2, object_1,
                            object_2_u_object_1 );
    
end; CategoryFilter = IsCocartesianCategory );

##
AddDerivationToCAP( CocartesianBraidingInverseWithGivenCoproducts,
                    "CocartesianBraidingInverseWithGivenCoproducts using CocartesianBraidingWithGivenCoproducts",
                    [ [ CocartesianBraidingWithGivenCoproducts, 1 ] ],
                    
  function( cat, object_2_u_object_1, object_1, object_2, object_1_u_object_2 )
    
    return CocartesianBraidingWithGivenCoproducts( cat,
                     object_2_u_object_1,
                     object_2, object_1,
                     object_1_u_object_2 );
    
end; CategoryFilter = IsCocartesianCategory );
