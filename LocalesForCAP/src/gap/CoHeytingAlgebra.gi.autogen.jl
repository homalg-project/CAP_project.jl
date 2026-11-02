# SPDX-License-Identifier: GPL-2.0-or-later
# LocalesForCAP: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

## thin

#= comment for Julia
InstallTrueMethod( IsCoHeytingAlgebroid, IsBicartesianProset && IsCocartesianCoclosedCategory );
# =#
InstallTrueMethod( IsBicartesianProset, IsCoHeytingAlgebroid );
InstallTrueMethod( IsCocartesianCoclosedCategory, IsCoHeytingAlgebroid );

## thin & skeletal

#= comment for Julia
InstallTrueMethod( IsCoHeytingAlgebra, IsCoHeytingAlgebroid && IsSkeletalCategory );
# =#
InstallTrueMethod( IsCoHeytingAlgebroid, IsCoHeytingAlgebra );
InstallTrueMethod( IsSkeletalCategory, IsCoHeytingAlgebra );

##
@InstallMethod( StableInternalCoHom,
        "for two objects in a thin category",
        [ IsObjectInThinCategory, IsObjectInThinCategory ],

  function( V, W )
    local V_W;
    
    V_W = V;
    
    while true
        V = V_W;
        V_W = InternalCoHomOnObjects( V_W, W );
        
        if (AreIsomorphicForObjectsIfIsHomSetInhabited( V_W, V ))
            break;
        end;
        
    end;
    
    return V_W;
    
end );
