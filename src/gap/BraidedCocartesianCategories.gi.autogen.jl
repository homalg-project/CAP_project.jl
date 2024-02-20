# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



##
AddDerivationToCAP( CocartesianBraiding,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ Coproduct, 1 ],
                      [ CocartesianBraidingWithGivenCoproducts, 1 ] ],
                    
  function( cat, object_1, object_2 )
    local source_and_range;
    
    source_and_range = BinaryCoproduct( cat, object_1, object_2 );
    
    return CocartesianBraidingWithGivenCoproducts( cat, source_and_range, object_1, object_2, source_and_range );
    
end; CategoryFilter = IsSkeletalCategory );

##
AddDerivationToCAP( CocartesianBraidingInverse,
                    "calling the WithGiven operation in a skeletal setting",
                    [ [ Coproduct, 1 ],
                      [ CocartesianBraidingInverseWithGivenCoproducts, 1 ] ],
                    
  function( cat, object_1, object_2 )
    local source_and_range;
    
    source_and_range = BinaryCoproduct( cat, object_1, object_2 );
    
    return CocartesianBraidingInverseWithGivenCoproducts( cat, source_and_range, object_1, object_2, source_and_range );
    
end; CategoryFilter = IsSkeletalCategory );

##
@InstallMethod( CheckCocartesianBraiding,
               [ IsCapCategoryObject, IsCapCategoryObject, IsCapCategoryObject ],
               
  function( A, B, C )
    local AB, mor1, mor2, BC;
    
    AB = Coproduct( A, B );
    
    mor1 = PreCompose( [
                    CocartesianBraiding( AB, C ),
                    CocartesianAssociatorRightToLeft( C, A, B ),
                    CoproductOnMorphisms( CocartesianBraiding( C, A ), IdentityMorphism( B ) ) ] );
    
    mor2 = PreCompose( [
                    CocartesianAssociatorLeftToRight( A, B, C ),
                    CoproductOnMorphisms( IdentityMorphism( A ), CocartesianBraiding( B, C ) ),
                    CocartesianAssociatorRightToLeft( A, C, B ) ] );
    
    if (@not IsCongruentForMorphisms( mor1, mor2 ))
       return false;
    end;
    
    BC = Coproduct( B, C );
    
    mor1 = PreCompose( [
                    CocartesianBraiding( A, BC ),
                    CocartesianAssociatorLeftToRight( B, C, A ),
                    CoproductOnMorphisms( IdentityMorphism( B ), CocartesianBraiding( C, A ) ) ] );
    
    mor2 = PreCompose( [
                    CocartesianAssociatorRightToLeft( A, B, C ),
                    CoproductOnMorphisms( CocartesianBraiding( A, B ), IdentityMorphism( C ) ),
                    CocartesianAssociatorLeftToRight( B, A, C ) ] );
    
    return IsCongruentForMorphisms( mor1, mor2 );
    
end );
