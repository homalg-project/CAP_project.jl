```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, MatricesForHomalg, LinearAlgebraForCAP, GeneralizedMorphismsForCAP

julia> # extracted from examples/Example.g

julia> Q = HomalgFieldOfRationals();

julia> vec = MatrixCategory( Q );

julia> A = MatrixCategoryObject( vec, 4 );

julia> B = MatrixCategoryObject( vec, 3 );

julia> C = MatrixCategoryObject( vec, 2 );

julia> alpha = VectorSpaceMorphism( A, 
        HomalgMatrix( [ [ 1, 1, 1 ], [ 0, 1, 1 ], 
        [ 1, 0, 1 ], [ 1, 1, 0 ] ], 4, 3, Q ), B );

julia> gamma = VectorSpaceMorphism( C, 
        HomalgMatrix( [ [ -1, 1, -1 ], [ 1, 0, -1 ] ], 2, 3, Q ), B );

julia> p = ProjectionInFactorOfFiberProduct( [ alpha, gamma ], 1 );

julia> q = ProjectionInFactorOfFiberProduct( [ alpha, gamma ], 2 );

julia> PreCompose( AsGeneralizedMorphism( alpha ), GeneralizedInverse( gamma ) )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> gen1 = PreCompose( AsGeneralizedMorphism( alpha ),
                            GeneralizedInverse( gamma ) )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> gen2 = PreCompose( GeneralizedInverse( p ), AsGeneralizedMorphism( q ) )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> IsCongruentForMorphisms( gen1, gen2 )
true

```
