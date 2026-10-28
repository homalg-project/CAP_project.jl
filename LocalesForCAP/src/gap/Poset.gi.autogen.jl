# SPDX-License-Identifier: GPL-2.0-or-later
# LocalesForCAP: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

#= comment for Julia
InstallTrueMethod( IsPosetCategory, IsThinCategory && IsSkeletalCategory );
# =#
InstallTrueMethod( IsThinCategory, IsPosetCategory );
InstallTrueMethod( IsSkeletalCategory, IsPosetCategory );

InstallTrueMethod( IsPosetCategory, IsTotalOrderCategory );

#= comment for Julia
InstallTrueMethod( IsMonoidalPoset, IsPosetCategory && IsStrictMonoidalCategory );
# =#
InstallTrueMethod( IsPosetCategory, IsMonoidalPoset );
InstallTrueMethod( IsStrictMonoidalCategory, IsMonoidalPoset );

#= comment for Julia
InstallTrueMethod( IsClosedMonoidalPoset, IsMonoidalPoset && IsClosedMonoidalCategory );
# =#
InstallTrueMethod( IsMonoidalPoset, IsClosedMonoidalPoset );
InstallTrueMethod( IsClosedMonoidalCategory, IsClosedMonoidalPoset );

#= comment for Julia
InstallTrueMethod( IsCoclosedMonoidalPoset, IsMonoidalPoset && IsCoclosedMonoidalCategory );
# =#
InstallTrueMethod( IsMonoidalPoset, IsCoclosedMonoidalPoset );
InstallTrueMethod( IsCoclosedMonoidalCategory, IsCoclosedMonoidalPoset );

#= comment for Julia
InstallTrueMethod( IsSymmetricMonoidalPoset, IsPosetCategory && IsStrictMonoidalCategory && IsSymmetricMonoidalCategory );
# =#
InstallTrueMethod( IsPosetCategory, IsSymmetricMonoidalPoset );
InstallTrueMethod( IsStrictMonoidalCategory, IsSymmetricMonoidalPoset );
InstallTrueMethod( IsSymmetricMonoidalCategory, IsSymmetricMonoidalPoset );

#= comment for Julia
InstallTrueMethod( IsSymmetricClosedMonoidalPoset, IsSymmetricMonoidalPoset && IsSymmetricClosedMonoidalCategory );
# =#
InstallTrueMethod( IsSymmetricMonoidalPoset, IsSymmetricClosedMonoidalPoset );
InstallTrueMethod( IsSymmetricClosedMonoidalCategory, IsSymmetricClosedMonoidalPoset );

#= comment for Julia
InstallTrueMethod( IsSymmetricCoclosedMonoidalPoset, IsSymmetricMonoidalPoset && IsSymmetricCoclosedMonoidalCategory );
# =#
InstallTrueMethod( IsSymmetricMonoidalPoset, IsSymmetricCoclosedMonoidalPoset );
InstallTrueMethod( IsSymmetricCoclosedMonoidalCategory, IsSymmetricCoclosedMonoidalPoset );

##
@InstallMethod( <,
        "for two objects in a thin category",
        [ IsObjectInThinCategory, IsObjectInThinCategory ],
        
  function( A, B )
    local C;
    
    C = CapCategory( A );
    
    if (!( HasIsSkeletalCategory( C ) && IsSkeletalCategory( C ) ))
        TryNextMethod( );
    elseif (@not IsIdenticalObj( C, CapCategory( B ) ))
        TryNextMethod( );
    end;
    
    return IsHomSetInhabited( A, B ) && @not AreIsomorphicForObjectsIfIsHomSetInhabited( A, B );
    
end );
