# SPDX-License-Identifier: GPL-2.0-or-later
# LocalesForCAP: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

## thin

#= comment for Julia
InstallTrueMethod( IsBiHeytingAlgebroid, IsHeytingAlgebroid && IsCoHeytingAlgebroid );
# =#
InstallTrueMethod( IsHeytingAlgebroid, IsBiHeytingAlgebroid );
InstallTrueMethod( IsCoHeytingAlgebroid, IsBiHeytingAlgebroid );

InstallTrueMethod( IsBiHeytingAlgebroid, IsBooleanAlgebroid );

## thin & skeletal

#= comment for Julia
InstallTrueMethod( IsBiHeytingAlgebra, IsBiHeytingAlgebroid && IsSkeletalCategory );
# =#
InstallTrueMethod( IsBiHeytingAlgebroid, IsBiHeytingAlgebra );
InstallTrueMethod( IsSkeletalCategory, IsBiHeytingAlgebra );

#= comment for Julia
InstallTrueMethod( IsBooleanAlgebra, IsBooleanAlgebroid && IsSkeletalCategory );
# =#
InstallTrueMethod( IsBooleanAlgebroid, IsBooleanAlgebra );
InstallTrueMethod( IsSkeletalCategory, IsBooleanAlgebra );
