# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#

InstallTrueMethod( IsCartesianCategory, IsBicartesianCategory );
InstallTrueMethod( IsCocartesianCategory, IsBicartesianCategory );
#= comment for Julia
InstallTrueMethod( IsBicartesianCategory, IsCartesianCategory && IsCocartesianCategory );
# =#

# https://ncatlab.org/nlab/show/bicartesian+closed+category
#= comment for Julia
InstallTrueMethod( IsBicartesianClosedCategory, IsBicartesianCategory && IsCartesianClosedCategory );
# =#
InstallTrueMethod( IsBicartesianCategory, IsBicartesianClosedCategory );
InstallTrueMethod( IsCartesianClosedCategory, IsBicartesianClosedCategory );
InstallTrueMethod( IsDistributiveCategory, IsBicartesianClosedCategory );

# https://ncatlab.org/nlab/show/bicartesian+coclosed+category
#= comment for Julia
InstallTrueMethod( IsBicartesianCoclosedCategory, IsBicartesianCategory && IsCocartesianCoclosedCategory );
# =#
InstallTrueMethod( IsBicartesianCategory, IsBicartesianCoclosedCategory );
InstallTrueMethod( IsCocartesianCoclosedCategory, IsBicartesianCoclosedCategory );
InstallTrueMethod( IsCodistributiveCategory, IsBicartesianCoclosedCategory );

InstallTrueMethod( IsCartesianCategory, IsFiniteCompleteCategory );
InstallTrueMethod( IsCocartesianCategory, IsFiniteCocompleteCategory );

InstallTrueMethod( IsBicartesianCategory, IsAbelianCategory );
InstallTrueMethod( IsFiniteCompleteCategory, IsAbelianCategory );
InstallTrueMethod( IsFiniteCocompleteCategory, IsAbelianCategory );

##
InstallMethod( @__MODULE__,  BinaryDirectProduct,
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ],
        
  function( cat, object_1, object_2 )
    
    return DirectProduct( cat, [ object_1, object_2 ] );
    
end );

##
InstallMethod( @__MODULE__,  BinaryCoproduct,
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ],
        
  function( cat, object_1, object_2 )
    
    return Coproduct( cat, [ object_1, object_2 ] );
    
end );
