# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian && cocartesian categories && various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CartesianBraidingInverseWithGivenDirectProducts,
                    "CartesianBraidingInverseWithGivenDirectProducts as the inverse of the braiding",
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianBraiding, 1 ] ],
                    
  function( cat, object_2_x_object_1, object_1, object_2, object_1_x_object_2 )
    ##TODO: Use CartesianBraidingWithGiven
    return InverseForMorphisms( cat, CartesianBraiding( cat, object_1, object_2 ) );
    
end; CategoryFilter = IsCartesianCategory );

##
AddDerivationToCAP( CartesianBraidingWithGivenDirectProducts,
                    "CartesianBraidingWithGivenDirectProducts as the inverse of CartesianBraidingInverse",
                    [ [ InverseForMorphisms, 1 ],
                      [ CartesianBraidingInverse, 1 ] ],
                    
  function( cat, object_1_x_object_2, object_1, object_2, object_2_x_object_1 )
    ##TODO: Use CartesianBraidingInverseWithGiven
    return InverseForMorphisms( cat, CartesianBraidingInverse( cat, object_1, object_2 ) );
    
end; CategoryFilter = IsCartesianCategory );
