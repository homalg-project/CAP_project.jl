

```jldoctest
julia> using CAP, MonoidalCategories, CartesianCategories, Toposes, FinSetsForCAP

julia> true
true


julia> SkeletalFinSets
SkeletalFinSets

julia> TensorUnit( SkeletalFinSets ) == TerminalObject( SkeletalFinSets )
true


julia> sFinSets = SkeletalCategoryOfFiniteSets(; cocartesian_monoidal_structure = true )
SkeletalFinSets

julia> TensorUnit( sFinSets ) == InitialObject( sFinSets )
true


julia> oFinSets = SkeletalCategoryOfFiniteSets(; cartesian_monoidal_structure = false )
SkeletalFinSets

julia> HasIsSymmetricMonoidalCategoryStructureGivenByDirectProduct( oFinSets )
false

julia> HasIsSymmetricMonoidalCategoryStructureGivenByCoproduct( oFinSets )
false


julia> SkeletalFinSets1
SkeletalFinSets1

julia> TensorUnit( SkeletalFinSets1 ) == TerminalObject( SkeletalFinSets1 )
true


julia> sFinSets1 = SkeletalCategoryOfFiniteSetsWithCountingStartingAt1( SkeletalCategoryOfFiniteSets(; cocartesian_monoidal_structure = true ); cocartesian_monoidal_structure = true )
SkeletalFinSets1

julia> TensorUnit( sFinSets1 ) == InitialObject( sFinSets1 )
true


julia> oFinSets1 = SkeletalCategoryOfFiniteSetsWithCountingStartingAt1( SkeletalCategoryOfFiniteSets(; cartesian_monoidal_structure = false ); cartesian_monoidal_structure = false )
SkeletalFinSets1

julia> HasIsSymmetricMonoidalCategoryStructureGivenByDirectProduct( oFinSets1 )
false

julia> HasIsSymmetricMonoidalCategoryStructureGivenByCoproduct( oFinSets1 )
false
