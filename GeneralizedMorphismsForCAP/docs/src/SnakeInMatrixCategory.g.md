```jldoctest AutoDocTests
julia> using CAP, MonoidalCategories, MatricesForHomalg, LinearAlgebraForCAP, GeneralizedMorphismsForCAP

julia> # extracted from examples/SnakeInMatrixCategory.g

julia> true
true

julia> true
true

julia> old_generalized_morphism_standard = CAP_INTERNAL_FIND_CORRECT_GENERALIZED_CATEGORY_TYPE( CAP_INTERNAL );

julia> SwitchGeneralizedMorphismStandard( "cospan" )
"cospan"

julia> Q = HomalgFieldOfRationals( );

julia> id = HomalgIdentityMatrix( 8, Q )
[1   0   0   0   0   0   0   0]
[0   1   0   0   0   0   0   0]
[0   0   1   0   0   0   0   0]
[0   0   0   1   0   0   0   0]
[0   0   0   0   1   0   0   0]
[0   0   0   0   0   1   0   0]
[0   0   0   0   0   0   1   0]
[0   0   0   0   0   0   0   1]

julia> a = CertainColumns( CertainRows( id, [ 1, 2, 3 ] ), [ 2, 3, 4, 5 ] )
[0   0   0   0]
[1   0   0   0]
[0   1   0   0]

julia> b = CertainColumns( CertainRows( id, [ 1, 2, 3, 4 ] ), [ 2, 3, 4, 5, 6 ] )
[0   0   0   0   0]
[1   0   0   0   0]
[0   1   0   0   0]
[0   0   1   0   0]

julia> c = CertainColumns( CertainRows( id, [ 1, 2, 3, 4, 5 ] ), [ 3, 4, 5, 6, 7, 8 ] )
[0   0   0   0   0   0]
[0   0   0   0   0   0]
[1   0   0   0   0   0]
[0   1   0   0   0   0]
[0   0   1   0   0   0]

julia> iszero( a * b )
false

julia> iszero( b * c )
false

julia> iszero( a * b * c )
true

julia> Qmat = MatrixCategory( Q )
Category of matrices over Q

julia> Wrapper = WrapperCategory( Qmat, @rec( ) )
WrapperCategory( Category of matrices over Q )

julia> a = a / Wrapper
<A morphism in WrapperCategory( Category of matrices over Q )>

julia> b = b / Wrapper
<A morphism in WrapperCategory( Category of matrices over Q )>

julia> c = c / Wrapper
<A morphism in WrapperCategory( Category of matrices over Q )>

julia> d = CokernelProjection( a )
<A morphism in WrapperCategory( Category of matrices over Q )>

julia> e = CokernelColift( a, PreCompose( b, c ) )
<A morphism in WrapperCategory( Category of matrices over Q )>

julia> f = KernelEmbedding( e )
<A morphism in WrapperCategory( Category of matrices over Q )>

julia> g = KernelEmbedding( c )
<A morphism in WrapperCategory( Category of matrices over Q )>

julia> h = KernelLift( c, PreCompose( a, b ) )
<A morphism in WrapperCategory( Category of matrices over Q )>

julia> i = CokernelProjection( h )
<A morphism in WrapperCategory( Category of matrices over Q )>

julia> ff = AsGeneralizedMorphism( f )
<A morphism in Generalized morphism category of
 WrapperCategory( Category of matrices over Q ) by cospan>

julia> dd = AsGeneralizedMorphism( d )
<A morphism in Generalized morphism category of
 WrapperCategory( Category of matrices over Q ) by cospan>

julia> bb = AsGeneralizedMorphism( b )
<A morphism in Generalized morphism category of
 WrapperCategory( Category of matrices over Q ) by cospan>

julia> gg = AsGeneralizedMorphism( g )
<A morphism in Generalized morphism category of
 WrapperCategory( Category of matrices over Q ) by cospan>

julia> ii = AsGeneralizedMorphism( i )
<A morphism in Generalized morphism category of
 WrapperCategory( Category of matrices over Q ) by cospan>

julia> ss = PreCompose( [ ff, PseudoInverse( dd ), bb, PseudoInverse( gg ), ii ] )
<A morphism in Generalized morphism category of
 WrapperCategory( Category of matrices over Q ) by cospan>

julia> s = HonestRepresentative( ss )
<A morphism in WrapperCategory( Category of matrices over Q )>

julia> j = KernelObjectFunctorial( b, d, e )
<A morphism in WrapperCategory( Category of matrices over Q )>

julia> k = CokernelObjectFunctorial( h, g, b )
<A morphism in WrapperCategory( Category of matrices over Q )>

julia> HK = HomologyObject( j, s )
<An object in WrapperCategory( Category of matrices over Q )>

julia> HC = HomologyObject( s, k )
<An object in WrapperCategory( Category of matrices over Q )>

julia> SwitchGeneralizedMorphismStandard( old_generalized_morphism_standard )
"threearrow"

```
