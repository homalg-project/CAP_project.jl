```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, MatricesForHomalg, LinearAlgebraForCAP, GeneralizedMorphismsForCAP

julia> # extracted from examples/VectorSpacesIsWellDefined.g

julia> Q = HomalgFieldOfRationals();

julia> vec = MatrixCategory( Q );

julia> A = MatrixCategoryObject( vec, 1 )
<A vector space object over Q of dimension 1>

julia> B = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> C = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> phi_tilde_associated = VectorSpaceMorphism( A, [ [ 1, 2, 0 ] ], C )
<A morphism in Category of matrices over Q>

julia> phi_tilde_source_aid = VectorSpaceMorphism( A, [ [ 1, 2 ] ], B )
<A morphism in Category of matrices over Q>

julia> phi_tilde = GeneralizedMorphismWithSourceAid( phi_tilde_source_aid, phi_tilde_associated )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> psi_tilde_associated = IdentityMorphism( B )
<A morphism in Category of matrices over Q>

julia> psi_tilde_source_aid = VectorSpaceMorphism( B, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], C )
<A morphism in Category of matrices over Q>

julia> psi_tilde = GeneralizedMorphismWithSourceAid( psi_tilde_source_aid, psi_tilde_associated )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> composition = PreCompose( phi_tilde, psi_tilde )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> Arrow( composition )
<A morphism in Category of matrices over Q>

julia> SourceAid( composition )
<A morphism in Category of matrices over Q>

julia> RangeAid( composition )
<A morphism in Category of matrices over Q>

```

```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, MatricesForHomalg, LinearAlgebraForCAP, GeneralizedMorphismsForCAP

julia> # extracted from examples/VectorSpacesIsWellDefined.g

julia> Q = HomalgFieldOfRationals();

julia> vec = MatrixCategory( Q );

julia> A = MatrixCategoryObject( vec, 1 )
<A vector space object over Q of dimension 1>

julia> B = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> C = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> phi2_tilde_associated = VectorSpaceMorphism( A, [ [ 1, 5 ] ], B )
<A morphism in Category of matrices over Q>

julia> phi2_tilde_range_aid = VectorSpaceMorphism( C, [ [ 1, 0 ], [ 0, 1 ], [ 1, 1 ] ], B )
<A morphism in Category of matrices over Q>

julia> phi2_tilde = GeneralizedMorphismWithRangeAid( phi2_tilde_associated, phi2_tilde_range_aid )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> psi2_tilde_associated = VectorSpaceMorphism( C, [ [ 1 ], [ 3 ], [ 4 ] ], A )
<A morphism in Category of matrices over Q>

julia> psi2_tilde_range_aid = VectorSpaceMorphism( B, [ [ 1 ], [ 1 ] ], A )
<A morphism in Category of matrices over Q>

julia> psi2_tilde = GeneralizedMorphismWithRangeAid( psi2_tilde_associated, psi2_tilde_range_aid )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> composition2 = PreCompose( phi2_tilde, psi2_tilde )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> Arrow( composition2 )
<A morphism in Category of matrices over Q>

julia> RangeAid( composition2 )
<A morphism in Category of matrices over Q>

julia> SourceAid( composition2 )
<A morphism in Category of matrices over Q>

```

```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, MatricesForHomalg, LinearAlgebraForCAP, GeneralizedMorphismsForCAP

julia> # extracted from examples/VectorSpacesIsWellDefined.g

julia> Q = HomalgFieldOfRationals();

julia> vec = MatrixCategory( Q );

julia> A = MatrixCategoryObject( vec, 1 )
<A vector space object over Q of dimension 1>

julia> B = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> phi_tilde_source_aid = VectorSpaceMorphism( A, [ [ 2 ] ], A )
<A morphism in Category of matrices over Q>

julia> phi_tilde_associated = VectorSpaceMorphism( A, [ [ 1, 1 ] ], B )
<A morphism in Category of matrices over Q>

julia> phi_tilde_range_aid = VectorSpaceMorphism( B, [ [ 1, 2 ], [ 3, 4 ] ], B )
<A morphism in Category of matrices over Q>

julia> phi_tilde = GeneralizedMorphism( phi_tilde_source_aid, phi_tilde_associated, phi_tilde_range_aid )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> HonestRepresentative( phi_tilde )
<A morphism in Category of matrices over Q>

julia> IsWellDefined( phi_tilde )
true

julia> IsWellDefined( psi_tilde )
true

```

```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, MatricesForHomalg, LinearAlgebraForCAP, GeneralizedMorphismsForCAP

julia> # extracted from examples/VectorSpacesIsWellDefined.g

julia> Q = HomalgFieldOfRationals();

julia> vec = MatrixCategory( Q );

julia> A = MatrixCategoryObject( vec, 1 )
<A vector space object over Q of dimension 1>

julia> B = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> alpha = VectorSpaceMorphism( A, [ [ 1, 2 ] ], B )
<A morphism in Category of matrices over Q>

julia> g = GeneralizedMorphism( alpha, alpha, alpha )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> IsWellDefined( alpha )
true

julia> IsWellDefined( g )
true

julia> IsEqualForObjects( A, B )
false

```
