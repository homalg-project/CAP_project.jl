# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



InstallTrueMethod( IsCartesianCategory, IsStrictCartesianCategory );

##
AddDerivationToCAP( CartesianAssociatorRightToLeft,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ DirectProduct, 2 ],
                      [ CartesianAssociatorRightToLeftWithGivenDirectProducts, 1 ] ],
                    
  function( cat, object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range = BinaryDirectProduct( cat, object_1, BinaryDirectProduct( cat, object_2, object_3 ) );
    
    return CartesianAssociatorRightToLeftWithGivenDirectProducts( cat,
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end; CategoryFilter = IsSkeletalCategory );

##
AddDerivationToCAP( CartesianAssociatorLeftToRight,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ DirectProduct, 2 ],
                      [ CartesianAssociatorLeftToRightWithGivenDirectProducts, 1 ] ],
                    
  function( cat, object_1, object_2, object_3 )
    local source_and_range;
    
    source_and_range = BinaryDirectProduct( cat, object_1, BinaryDirectProduct( cat, object_2, object_3 ) );
    
    return CartesianAssociatorLeftToRightWithGivenDirectProducts( cat,
             source_and_range,
             object_1, object_2, object_3,
             source_and_range
           );
    
end; CategoryFilter = IsSkeletalCategory );

##
AddDerivationToCAP( CartesianLeftUnitor,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ CartesianLeftUnitorWithGivenDirectProduct, 1 ] ],
                    
  function( cat, object )
    
    return CartesianLeftUnitorWithGivenDirectProduct( cat, object, object );
    
end; CategoryFilter = IsSkeletalCategory );

##
AddDerivationToCAP( CartesianLeftUnitorInverse,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ CartesianLeftUnitorInverseWithGivenDirectProduct, 1 ] ],
                    
  function( cat, object )
    
    return CartesianLeftUnitorInverseWithGivenDirectProduct( cat, object, object );
    
end; CategoryFilter = IsSkeletalCategory );

##
AddDerivationToCAP( CartesianRightUnitor,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ CartesianRightUnitorWithGivenDirectProduct, 1 ] ],
                    
  function( cat, object )
    
    return CartesianRightUnitorWithGivenDirectProduct( cat, object, object );
    
end; CategoryFilter = IsSkeletalCategory );

##
AddDerivationToCAP( CartesianRightUnitorInverse,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ CartesianRightUnitorInverseWithGivenDirectProduct, 1 ] ],
                    
  function( cat, object )
    
    return CartesianRightUnitorInverseWithGivenDirectProduct( cat, object, object );
    
end; CategoryFilter = IsSkeletalCategory );
