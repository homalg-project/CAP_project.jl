```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, MatricesForHomalg, LinearAlgebraForCAP, GeneralizedMorphismsForCAP

julia> # extracted from examples/VectorSpacesGeneralizedMorphismsCategory.g

julia> Q = HomalgFieldOfRationals();

julia> vec = MatrixCategory( Q );

julia> B = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> C = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> B_1 = MatrixCategoryObject( vec, 1 )
<A vector space object over Q of dimension 1>

julia> C_1 = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> c1_source_aid = VectorSpaceMorphism( B_1, [ [ 1, 0 ] ], B )
<A morphism in Category of matrices over Q>

julia> c1_range_aid = VectorSpaceMorphism( C, [ [ 1, 0 ], [ 0, 1 ], [ 0, 0 ] ], C_1 )
<A morphism in Category of matrices over Q>

julia> c1_associated = VectorSpaceMorphism( B_1, [ [ 1, 1 ] ], C_1 )
<A morphism in Category of matrices over Q>

julia> c1 = GeneralizedMorphism( c1_source_aid, c1_associated, c1_range_aid )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> B_2 = MatrixCategoryObject( vec, 1 )
<A vector space object over Q of dimension 1>

julia> C_2 = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> c2_source_aid = VectorSpaceMorphism( B_2, [ [ 2, 0 ] ], B )
<A morphism in Category of matrices over Q>

julia> c2_range_aid = VectorSpaceMorphism( C, [ [ 3, 0 ], [ 0, 3 ], [ 0, 0 ] ], C_2 )
<A morphism in Category of matrices over Q>

julia> c2_associated = VectorSpaceMorphism( B_2, [ [ 6, 6 ] ], C_2 )
<A morphism in Category of matrices over Q>

julia> c2 = GeneralizedMorphism( c2_source_aid, c2_associated, c2_range_aid )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> IsCongruentForMorphisms( c1, c2 )
true

julia> IsCongruentForMorphisms( c1, c1 )
true

julia> c3_associated = VectorSpaceMorphism( B_1, [ [ 2, 2 ] ], C_1 )
<A morphism in Category of matrices over Q>

julia> c3 = GeneralizedMorphism( c1_source_aid, c3_associated, c1_range_aid )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> IsCongruentForMorphisms( c1, c3 )
false

julia> IsCongruentForMorphisms( c2, c3 )
false

julia> c1 + c2
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> Arrow( c1 + c2 )
<A morphism in Category of matrices over Q>

```

```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, MatricesForHomalg, LinearAlgebraForCAP, GeneralizedMorphismsForCAP

julia> # extracted from examples/VectorSpacesGeneralizedMorphismsCategory.g

julia> Q = HomalgFieldOfRationals();

julia> vec = MatrixCategory( Q );

julia> A = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> Asub = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> B = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> Bfac = MatrixCategoryObject( vec, 1 )
<A vector space object over Q of dimension 1>

julia> Bsub = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> C = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> Cfac = MatrixCategoryObject( vec, 1 )
<A vector space object over Q of dimension 1>

julia> Asub_into_A = VectorSpaceMorphism( Asub, [ [ 1, 0, 0 ], [ 0, 1, 0 ] ], A )
<A morphism in Category of matrices over Q>

julia> Asub_to_Bfac = VectorSpaceMorphism( Asub, [ [ 1 ], [ 1 ] ], Bfac )
<A morphism in Category of matrices over Q>

julia> B_onto_Bfac = VectorSpaceMorphism( B, [ [ 1 ], [ 1 ], [ 1 ] ], Bfac )
<A morphism in Category of matrices over Q>

julia> Bsub_into_B = VectorSpaceMorphism( Bsub, [ [ 2, 2, 0 ], [ 0, 2, 2 ] ], B )
<A morphism in Category of matrices over Q>

julia> Bsub_to_Cfac = VectorSpaceMorphism( Bsub, [ [ 3 ], [ 0 ] ], Cfac )
<A morphism in Category of matrices over Q>

julia> C_onto_Cfac = VectorSpaceMorphism( C, [ [ 1 ], [ 2 ], [ 3 ] ], Cfac )
<A morphism in Category of matrices over Q>

julia> generalized_morphism1 = GeneralizedMorphism( Asub_into_A, Asub_to_Bfac, B_onto_Bfac )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> generalized_morphism2 = GeneralizedMorphism( Bsub_into_B, Bsub_to_Cfac, C_onto_Cfac )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> IsWellDefined( generalized_morphism1 )
true

julia> IsWellDefined( generalized_morphism2 )
true

julia> p = PreCompose( generalized_morphism1, generalized_morphism2 )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> SourceAid( p )
<A morphism in Category of matrices over Q>

julia> Arrow( p )
<A morphism in Category of matrices over Q>

julia> RangeAid( p )
<A morphism in Category of matrices over Q>

julia> A = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> Asub = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> B = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> Bfac = MatrixCategoryObject( vec, 1 )
<A vector space object over Q of dimension 1>

julia> Bsub = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> C = MatrixCategoryObject( vec, 3 )
<A vector space object over Q of dimension 3>

julia> Cfac = MatrixCategoryObject( vec, 2 )
<A vector space object over Q of dimension 2>

julia> Bsub_to_Cfac = VectorSpaceMorphism( Bsub, [ [ 3, 3 ], [ 0, 0 ] ], Cfac )
<A morphism in Category of matrices over Q>

julia> C_onto_Cfac = VectorSpaceMorphism( C, [ [ 1, 0 ], [ 0, 2 ], [ 3, 3 ] ], Cfac )
<A morphism in Category of matrices over Q>

julia> generalized_morphism1 = GeneralizedMorphism( Asub_into_A, Asub_to_Bfac, B_onto_Bfac )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> generalized_morphism2 = GeneralizedMorphism( Bsub_into_B, Bsub_to_Cfac, C_onto_Cfac )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> IsWellDefined( generalized_morphism1 )
true

julia> IsWellDefined( generalized_morphism2 )
true

julia> p = PreCompose( generalized_morphism1, generalized_morphism2 )
<A morphism in Generalized morphism category of Category of matrices over Q>

julia> SourceAid( p )
<A morphism in Category of matrices over Q>

julia> Arrow( p )
<A morphism in Category of matrices over Q>

julia> RangeAid( p )
<A morphism in Category of matrices over Q>

```
