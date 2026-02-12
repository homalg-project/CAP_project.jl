
```jldoctest AutoDocTests
julia> using MatricesForHomalg, CAP, LinearAlgebraForCAP, FinSetsForCAP, LinearClosuresForCAP

julia> Q = HomalgFieldOfRationals( );

julia> QSkeletalFinSets = LinearClosure( Q, SkeletalFinSets )
LinearClosure( SkeletalFinSets )

julia> Display( QSkeletalFinSets )
A CAP category with name LinearClosure( SkeletalFinSets ):

22 primitive operations were used to derive 69 operations for this category which algorithmically
* IsEquippedWithHomomorphismStructure
* IsLinearCategoryOverCommutativeRingWithFinitelyGeneratedFreeExternalHoms
and furthermore mathematically
* IsLinearClosureOfACategory
* IsSkeletalCategory

julia> U = LinearClosureObject( QSkeletalFinSets, BigInt(2) / SkeletalFinSets )
LinearClosureObject(|2|)

julia> HomomorphismStructureOnObjects( U, U )
<A row module over Q of rank 4>

julia> hom_UU = BasisOfExternalHom( U, U );

julia> Length( hom_UU )
4

julia> @Assert( 0, hom_UU[1] + hom_UU[2] == hom_UU[2] + hom_UU[1] )

```
