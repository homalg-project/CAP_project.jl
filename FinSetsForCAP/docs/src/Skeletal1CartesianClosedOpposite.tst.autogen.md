

```jldoctest
julia> using CAP, MonoidalCategories, CartesianCategories, Toposes, FinSetsForCAP

julia> true
true

julia> a = FinSet1( 2 );

julia> b = FinSet1( 3 );

julia> c = FinSet1( 3 );

julia> d = FinSet1( 2 );

julia> finsets = CapCategory( a );

julia> opposite = Opposite( finsets, "Opposite with all operations" );

julia> opposite_primitive = Opposite( finsets, "Opposite with primitive operations"; only_primitive_operations = true );

julia> alpha = MapOfFinSets( a, [ 3, 2 ], b );

julia> beta = MapOfFinSets( c, [ 1, 1, 2 ], d );

julia> CartesianCategoriesTest( finsets, opposite, a, b, c, alpha, beta );

julia> CartesianCategoriesTest( finsets, opposite_primitive, a, b, c, alpha, beta );

julia> i = InitialObject( finsets );

julia> t = TerminalObject( finsets );

julia> alpha = UniversalMorphismFromInitialObject( a );

julia> beta = UniversalMorphismIntoTerminalObject( a );

julia> CartesianCategoriesTest( finsets, opposite, i, a, a, alpha, beta );

julia> CartesianCategoriesTest( finsets, opposite_primitive, i, a, a, alpha, beta );

julia> CartesianCategoriesTest( finsets, opposite, a, t, i, beta, alpha );

julia> CartesianCategoriesTest( finsets, opposite_primitive, a, t, i, beta, alpha );

julia> a = FinSet1( 2 );

julia> b = FinSet1( 3 );

julia> c = FinSet1( 3 );

julia> d = FinSet1( 2 );

julia> alpha = MapOfFinSets( a, [ 3, 2 ], b );

julia> beta = MapOfFinSets( c, [ 1, 1, 2 ], d );

julia> CocartesianCategoriesTest( finsets, opposite, a, b, c, alpha, beta );

julia> CocartesianCategoriesTest( finsets, opposite_primitive, a, b, c, alpha, beta );

julia> i = InitialObject( finsets );

julia> t = TerminalObject( finsets );

julia> alpha = UniversalMorphismFromInitialObject( a );

julia> beta = UniversalMorphismIntoTerminalObject( a );

julia> CocartesianCategoriesTest( finsets, opposite, i, a, a, alpha, beta );

julia> CocartesianCategoriesTest( finsets, opposite_primitive, i, a, a, alpha, beta );

julia> CocartesianCategoriesTest( finsets, opposite, a, t, i, beta, alpha );

julia> CocartesianCategoriesTest( finsets, opposite_primitive, a, t, i, beta, alpha );

julia> a = FinSet1( 2 );

julia> b = FinSet1( 3 );

julia> BraidedCartesianCategoriesTest( finsets, opposite, a, b );

julia> BraidedCartesianCategoriesTest( finsets, opposite_primitive, a, b );

julia> a = FinSet1( 3 );

julia> b = FinSet1( 2 );

julia> BraidedCartesianCategoriesTest( finsets, opposite, a, b );

julia> BraidedCartesianCategoriesTest( finsets, opposite_primitive, a, b );

julia> i = InitialObject( finsets );

julia> a = FinSet1( 4 );

julia> BraidedCartesianCategoriesTest( finsets, opposite, i, a );

julia> BraidedCartesianCategoriesTest( finsets, opposite_primitive, i, a );

julia> BraidedCartesianCategoriesTest( finsets, opposite, a, i );

julia> BraidedCartesianCategoriesTest( finsets, opposite_primitive, a, i );

julia> t = TerminalObject( finsets );

julia> a = FinSet1( 3 );

julia> BraidedCartesianCategoriesTest( finsets, opposite, t, a );

julia> BraidedCartesianCategoriesTest( finsets, opposite_primitive, t, a );

julia> BraidedCartesianCategoriesTest( finsets, opposite, a, t );

julia> BraidedCartesianCategoriesTest( finsets, opposite_primitive, a, t );

julia> a = FinSet1( 2 );

julia> b = FinSet1( 3 );

julia> BraidedCocartesianCategoriesTest( finsets, opposite, a, b );

julia> BraidedCocartesianCategoriesTest( finsets, opposite_primitive, a, b );

julia> a = FinSet1( 3 );

julia> b = FinSet1( 2 );

julia> BraidedCocartesianCategoriesTest( finsets, opposite, a, b );

julia> BraidedCocartesianCategoriesTest( finsets, opposite_primitive, a, b );

julia> i = InitialObject( finsets );

julia> a = FinSet1( 4 );

julia> BraidedCocartesianCategoriesTest( finsets, opposite, i, a );

julia> BraidedCocartesianCategoriesTest( finsets, opposite_primitive, i, a );

julia> BraidedCocartesianCategoriesTest( finsets, opposite, a, i );

julia> BraidedCocartesianCategoriesTest( finsets, opposite_primitive, a, i );

julia> t = TerminalObject( finsets );

julia> a = FinSet1( 3 );

julia> BraidedCocartesianCategoriesTest( finsets, opposite, t, a );

julia> BraidedCocartesianCategoriesTest( finsets, opposite_primitive, t, a );

julia> BraidedCocartesianCategoriesTest( finsets, opposite, a, t );

julia> BraidedCocartesianCategoriesTest( finsets, opposite_primitive, a, t );

julia> a = FinSet1( 2 );

julia> L = [ FinSet1( 4 ), FinSet1( 2 ), FinSet1( 6 ) ];

julia> DistributiveCartesianCategoriesTest( finsets, opposite, a, L );

julia> DistributiveCartesianCategoriesTest( finsets, opposite_primitive, a, L );

julia> a = InitialObject( finsets );

julia> L = [ FinSet1( 4 ), FinSet1( 2 ), FinSet1( 6 ) ];

julia> DistributiveCartesianCategoriesTest( finsets, opposite, a, L );

julia> DistributiveCartesianCategoriesTest( finsets, opposite_primitive, a, L );

julia> a = FinSet1( 2 );

julia> L = [ FinSet1( 4 ), InitialObject( finsets ), FinSet1( 6 ) ];

julia> DistributiveCartesianCategoriesTest( finsets, opposite, a, L );

julia> DistributiveCartesianCategoriesTest( finsets, opposite_primitive, a, L );

julia> a = TerminalObject( finsets );

julia> L = [ FinSet1( 4 ), FinSet1( 2 ), FinSet1( 6 ) ];

julia> DistributiveCartesianCategoriesTest( finsets, opposite, a, L );

julia> DistributiveCartesianCategoriesTest( finsets, opposite_primitive, a, L );

julia> a = FinSet1( 2 );

julia> L = [ FinSet1( 4 ), TerminalObject( finsets ), FinSet1( 6 ) ];

julia> DistributiveCartesianCategoriesTest( finsets, opposite, a, L );

julia> DistributiveCartesianCategoriesTest( finsets, opposite_primitive, a, L );

julia> a = FinSet1( 2 );

julia> b = FinSet1( 1 );

julia> c = FinSet1( 2 );

julia> d = FinSet1( 2 );

julia> t = TerminalObject( finsets );

julia> a_product_b = DirectProduct( a, b );

julia> c_product_d = DirectProduct( c, d );

julia> exp_ab = Exponential( a, b );

julia> exp_cd = Exponential( c, d );

julia> alpha = MapOfFinSets( a, [ 1, 1 ], b );

julia> beta = MapOfFinSets( c, [ 2, 1 ], d );

julia> gamma = UniversalMorphismIntoTerminalObject( a_product_b );

julia> delta = UniversalMorphismIntoTerminalObject( c_product_d );

julia> epsilon = MapOfFinSets( t, [ 1 ], exp_ab );

julia> zeta = MapOfFinSets( t, [ 2 ], exp_cd );

julia> CartesianClosedCategoriesTest( finsets, opposite, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );

julia> CartesianClosedCategoriesTest( finsets, opposite_primitive, a, b, c, d, alpha, beta, gamma, delta, epsilon, zeta );

julia> i = InitialObject( finsets );

julia> i_product_a = DirectProduct( i, a );

julia> a_product_t = DirectProduct( a, t );

julia> exp_ia = Exponential( i, a );

julia> exp_at = Exponential( a, t );

julia> alpha = UniversalMorphismFromInitialObject( a );

julia> beta = UniversalMorphismIntoTerminalObject( a );

julia> gamma = UniversalMorphismIntoTerminalObject( i_product_a );

julia> delta = UniversalMorphismIntoTerminalObject( a_product_t );

julia> epsilon = MapOfFinSets( t, [ 1 ], exp_ia );

julia> zeta = MapOfFinSets( t, [ 1 ], exp_at );

julia> CartesianClosedCategoriesTest( finsets, opposite, i, a, a, t, alpha, beta, gamma, delta, epsilon, zeta );

julia> CartesianClosedCategoriesTest( finsets, opposite_primitive, i, a, a, t, alpha, beta, gamma, delta, epsilon, zeta );

```
