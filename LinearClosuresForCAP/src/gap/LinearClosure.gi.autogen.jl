# SPDX-License-Identifier: GPL-2.0-or-later
# LinearClosuresForCAP: Linear closures
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
@InstallGlobalFunction( LINEAR_CLOSURE_CONSTRUCTOR_USING_CategoryOfRows,
  @FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, rows, underlying_category, arg... ) ## rows == CategoryOfRows( ... )
    local ring, name, category, is_finite, sorting_function, with_nf, cocycle;
    
    ring = UnderlyingRing( rows );
    
    if (!( HasIsCommutative( ring ) && IsCommutative( ring ) ))
        
        Error( "only commutative rings are supported" );
        
    end;
    
    sorting_function = fail;
    
    cocycle = fail;
    
    if (Length( arg ) == 0)
        
        with_nf = false;
        
        if (HasIsEquippedWithHomomorphismStructure( underlying_category ) &&
            IsEquippedWithHomomorphismStructure( underlying_category ) &&
            CanCompute( underlying_category, "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" )
            #= comment for Julia
            && IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2023.07-03" )
            # =#
       )
            
            sorting_function = HOM_STRUCTURE_BASED_SORTING_FUNCTION_OR_FAIL_FOR_LINEAR_CLOSURE( underlying_category );
            
            if (sorting_function != fail)
                
                with_nf = true;
                
            end;
            
        end;
        
    elseif (Length( arg ) == 1)
        
        sorting_function = arg[1];
        
        with_nf = true;
        
    else
        
        cocycle = arg[1];
        
        with_nf = arg[2];
        
        if (Length( arg ) >= 3)
            
            sorting_function = arg[3];
            
        end;
        
    end;
    
    if (cocycle != fail)
        
        name = @Concatenation( "TwistedLinearClosure( ", Name( underlying_category )," )" );
        
    else
        
        name = @Concatenation( "LinearClosure( ", Name( underlying_category )," )" );
        
    end;
    
    category = CreateCapCategory( name, IsLinearClosure, IsLinearClosureObject, IsLinearClosureMorphism, IsCapCategoryTwoCell; overhead = false );
    
    category.compiler_hints = @rec(
        category_attribute_names = [
            "UnderlyingCategory",
            "CommutativeRingOfLinearCategory",
        ],
    );
    
    category.with_nf = with_nf;
    
    if (sorting_function != fail)
        
        category.sorting_function = sorting_function;
        
    end;
    
    if (cocycle != fail)
        
        category.cocycle = cocycle;
        
    end;
    
    SetCommutativeRingOfLinearCategory( category, ring );
    
    SetUnderlyingRing( category, ring );
    
    SetUnderlyingCategory( category, underlying_category );
    
    if (cocycle == fail)
        SetIsLinearClosureOfACategory( category, true );
    end;
    
    SetIsLinearCategoryOverCommutativeRing( category, true );
    
    SetIsAbCategory( category, true );
    
    if (HasIsObjectFiniteCategory( underlying_category ) && IsObjectFiniteCategory( underlying_category ))
        
        SetIsObjectFiniteCategory( category, true );
        
    end;
    
    if (HasIsSkeletalCategory( underlying_category ) && IsSkeletalCategory( underlying_category ))
        
        SetIsSkeletalCategory( category, true );
        
    end;
    
    if (with_nf &&
       HasIsEquippedWithHomomorphismStructure( underlying_category ) &&
       IsEquippedWithHomomorphismStructure( underlying_category )
       #= comment for Julia
       && IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2023.07-03" )
       # =#
   )
        
        SET_HOMOMORPHISM_STRUCTURE_ATTRIBUTES_FOR_LINEAR_CLOSURE( category, rows );
        
    end;
    
    INSTALL_FUNCTIONS_FOR_LINEAR_CLOSURE( rows, category );
    
    if (FinalizeCategory)
      
      Finalize( category );
      
    end;
    
    return category;
    
end ) );

##
@InstallMethod( LinearClosure,
               [ IsCategoryOfRows, IsCapCategory, IsFunction ],
               LINEAR_CLOSURE_CONSTRUCTOR_USING_CategoryOfRows );

##
@InstallMethod( LinearClosure,
               [ IsCategoryOfRows, IsCapCategory ],
               LINEAR_CLOSURE_CONSTRUCTOR_USING_CategoryOfRows );

##
@InstallMethod( TwistedLinearClosure,
               [ IsCategoryOfRows, IsCapCategory, IsFunction ],
  function( rows, category, cocycle )
    
    return LINEAR_CLOSURE_CONSTRUCTOR_USING_CategoryOfRows( rows, category, cocycle, false );
    
end );

##
@InstallMethod( TwistedLinearClosure,
               [ IsCategoryOfRows, IsCapCategory, IsFunction, IsFunction ],
  function( rows, category, cocycle, sorting_function )
    
    return LINEAR_CLOSURE_CONSTRUCTOR_USING_CategoryOfRows( rows, category, cocycle, true, sorting_function );
    
end );

##
@InstallGlobalFunction( LINEAR_CLOSURE_CONSTRUCTOR,
  function( ring, underlying_category, arg... )
    local rows;
    
    rows = CategoryOfRows( ring; FinalizeCategory = true
            #= comment for Julia
            , overhead = false
            # =#
            );
    
    return CallFuncList( LINEAR_CLOSURE_CONSTRUCTOR_USING_CategoryOfRows,
                   @Concatenation( [ rows, underlying_category ], arg ) );
    
end );

## sorting_function:
## compares two morphisms alpha: a -> b, beta: a -> b
## such that, if we take the quotient by IsCongruentForMorphisms, we get a total ordering on morphisms
@InstallMethod( LinearClosure,
               [ IsHomalgRing, IsCapCategory, IsFunction ],
               LINEAR_CLOSURE_CONSTRUCTOR );

##
@InstallMethod( LinearClosure,
               [ IsHomalgRing, IsCapCategory ],
               LINEAR_CLOSURE_CONSTRUCTOR );

##
@InstallMethod( TwistedLinearClosure,
               [ IsHomalgRing, IsCapCategory, IsFunction ],
  function( ring, category, cocycle )
    
    return LINEAR_CLOSURE_CONSTRUCTOR( ring, category, cocycle, false );
    
end );

##
@InstallMethod( TwistedLinearClosure,
               [ IsHomalgRing, IsCapCategory, IsFunction, IsFunction ],
  function( ring, category, cocycle, sorting_function )
    
    return LINEAR_CLOSURE_CONSTRUCTOR( ring, category, cocycle, true, sorting_function );
    
end );

##
@InstallMethod( LinearClosureObject,
                                [ IsLinearClosure, IsCapCategoryObject ],
               
  function( category, object )
    
    return CreateCapCategoryObjectWithAttributes( category,
                                                  UnderlyingOriginalObject, object );
    
end );

##
@InstallMethod( LinearClosureObject,
                    [ IsCapCategoryObject, IsLinearClosure ],
               
  function( object, category )
    
    return LinearClosureObject( category, object );
    
end );

## Data structure for morphisms:
##
## 1.case: there is a sorting function
## list of morphisms in underlying category: [ alpha_1, alpha_2, ..., alpha_n ],
## pairwise not congruent, and sorted w.r.t. sorting_function in increasing order.
##
## list of coefficients, same length as list of morphisms: [ c_1, ..., c_n ].
## non of the c_i must be zero.
##
## Interpreation: formal linear combination Sum_[i == 1]^n c_i * alpha_i
##
## Reason for sorting:
## this gives a normal form, which makes the congruence decision possible
##
## 2.case: there is no sorting function
## list of morphisms in underlying category: [ alpha_1, alpha_2, ..., alpha_n ]
## list of coefficients, same length as list of morphisms: [ c_1, ..., c_n ]
## no further restrictions
##
@InstallMethod( LinearClosureMorphism,
               [ IsLinearClosure, IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ],
  function( category, source, coefficients, support_morphisms, range )
    local sorting_function, coefficients_copy, support_morphisms_copy,
          coefficients_NF, support_morphisms_NF, m, c, i, m_compare;
    
    if (IsEmpty( coefficients ) || ( @not category.with_nf ))
        
        return LinearClosureMorphismNC( source, coefficients, support_morphisms, range );
        
    end;
    
    ## create normal form (NF)
    sorting_function = category.sorting_function;
    
    coefficients_copy = ShallowCopy( coefficients );
    
    support_morphisms_copy = ShallowCopy( support_morphisms );
    
    SortParallel( support_morphisms_copy, coefficients_copy, sorting_function );
    
    coefficients_NF = [];
    
    support_morphisms_NF = [];
    
    m = support_morphisms_copy[1];
    
    c = coefficients_copy[1];
    
    for i in (2):(Length( support_morphisms_copy ))
        
        m_compare = support_morphisms_copy[i];
        
        if (IsCongruentForMorphisms( m, m_compare ))
            
            c = c + coefficients_copy[i];
            
        else
            
            if (@not IsZero( c ))
                
                Add( support_morphisms_NF, m );
                
                Add( coefficients_NF, c );
                
            end;
            
            m = m_compare;
            
            c = coefficients_copy[i];
            
        end;
        
    end;
    
    if (@not IsZero( c ))
        
        Add( support_morphisms_NF, m );
                
        Add( coefficients_NF, c );
        
    end;
    
    return LinearClosureMorphismNC( source, coefficients_NF, support_morphisms_NF, range );
    
end );

##
@InstallMethod( LinearClosureMorphism,
               [ IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ],
  function( source, coefficients, support_morphisms, range )
    
    return LinearClosureMorphism( CapCategory( source ), source, coefficients, support_morphisms, range );
    
end );

##
@InstallMethod( LinearClosureMorphismNC,
               [ IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ],
  function( source, coefficients, support_morphisms, range )
    local category;
    
    category = CapCategory( source );
    
    return LinearClosureMorphismNC( category, source, coefficients, support_morphisms, range );
    
end );

##
@InstallMethod( LinearClosureMorphismNC,
                                     [ IsLinearClosure, IsLinearClosureObject, IsList, IsList, IsLinearClosureObject ],
  function( category, source, coefficients, support_morphisms, range )
    local underlying_category;
    
    underlying_category = UnderlyingCategory( category );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 0, ForAll( support_morphisms, mor -> IsIdenticalObj( CapCategory( mor ), underlying_category ) ) );
    
    return CreateCapCategoryMorphismWithAttributes( category,
                   source, range,
                   CoefficientsList, coefficients,
                   SupportMorphisms, support_morphisms );
    
end );

##
@InstallGlobalFunction( LINEAR_CLOSURE_MORPHISM_SIMPLIFY,
    function( alpha, arg... )
        local abort, coeffs, supp, diff, s, test_func, pos, c, new_supp, new_coeffs;
        
        if (Length( arg ) == 1)
            
            abort = arg[1];
            
        else
            
            abort = false;
            
        end;
        
        coeffs = ShallowCopy( CoefficientsList( alpha ) );
        
        supp = ShallowCopy( SupportMorphisms( alpha ) );
        
        new_supp = [];
        
        new_coeffs = [];
        
        while @not IsEmpty( supp )
            
            s = supp[1];
            
            test_func = x -> IsCongruentForMorphisms( s, x );
            
            diff = (2):(Length( supp ));
            
            pos = @Concatenation( [1], PositionsProperty( supp[ diff ], test_func ) + 1 );
            
            c = Sum( coeffs[ pos ] );
            
            if (@not IsZero( c ))
                
                if (abort)
                    
                    return false;
                    
                end;
                
                Add( new_supp, s );
                
                Add( new_coeffs, c );
                
            end;
            
            diff = Difference( (1):(Length( supp )), pos ) ;
            
            supp = supp[ diff ];
            
            coeffs = coeffs[ diff ];
            
        end;
        
        if (abort && IsEmpty( new_supp ))
            
            return true;
            
        end;
        
        return LinearClosureMorphismNC(
            Source( alpha ),
            new_coeffs,
            new_supp,
            Range( alpha )
        );
        
end );

####################################
##
## Basic operations
##
####################################


@InstallGlobalFunction( INSTALL_FUNCTIONS_FOR_LINEAR_CLOSURE,
  function( rows, category )
    local ring, underlying_category, sorting_function, with_nf,
          equality_func, finsets, t_obj, t_finsets, FunctorMor, FunctorObj, cocycle;
    
    if (@not IsCategoryOfRows( rows ))
        Error( "the first argument `rows` must be a category of rows\n" );
    end;
    
    ring = UnderlyingRing( category );
    
    underlying_category = UnderlyingCategory( category );
    
    with_nf = category.with_nf;
    
    if (with_nf)
        
        sorting_function = category.sorting_function;
        
    end;
    
    ##
    AddObjectConstructor( category,
      function( cat, underlying_object )
        
        return LinearClosureObject( cat, underlying_object );
        
    end );
    
    ##
    AddObjectDatum( category,
      function( cat, object )
        
        return UnderlyingOriginalObject( object );
        
    end );

    if (with_nf)
        
        ##
        AddMorphismConstructor( category,
          function( cat, source, pair, range )
            
            return LinearClosureMorphism( cat, source, pair[1], pair[2], range );
            
        end );

    else
        
        ##
        AddMorphismConstructor( category,
          function( cat, source, pair, range )
            
            return LinearClosureMorphismNC( cat, source, pair[1], pair[2], range );
            
        end );
        
    end;
    
    ##
    AddMorphismDatum( category,
      function( cat, morphism )
        
        return PairGAP( CoefficientsList( morphism ), SupportMorphisms( morphism ) );
        
    end );
    
    ##
    AddIsEqualForObjects( category,
      function( cat, a, b )
        
        return IsEqualForObjects( UnderlyingCategory( cat ), UnderlyingOriginalObject( a ), UnderlyingOriginalObject( b ) );
        
    end );
    
    ##
    AddIsEqualForMorphisms( category,
      function( cat, alpha, beta )
        local coeffs_a, coeffs_b, supp_a, supp_b, size_coeffs_a;
        
        coeffs_a = CoefficientsList( alpha );
        
        coeffs_b = CoefficientsList( beta );
        
        size_coeffs_a = Length( coeffs_a );
        
        return size_coeffs_a == Length( coeffs_b ) &&
               ForAll( (1):(size_coeffs_a), i ->
                       IsEqualForMorphisms( UnderlyingCategory( cat ), SupportMorphisms( alpha )[i], SupportMorphisms( beta )[i] ) ) &&
               coeffs_a == coeffs_b;
        
    end );
    
    if (with_nf)
        
        ##
        AddIsCongruentForMorphisms( category,
          function( cat, alpha, beta )
            local coeffs_a, coeffs_b, supp_a, supp_b, size_coeffs_a;
            
            coeffs_a = CoefficientsList( alpha );
            
            coeffs_b = CoefficientsList( beta );
            
            size_coeffs_a = Length( coeffs_a );
            
            return size_coeffs_a == Length( coeffs_b ) &&
                   ForAll( (1):(size_coeffs_a), i ->
                           IsCongruentForMorphisms( UnderlyingCategory( cat ), SupportMorphisms( alpha )[i], SupportMorphisms( beta )[i] ) ) &&
                   coeffs_a == coeffs_b;
            
        end );
        
    else
        
        ##
        AddIsCongruentForMorphisms( category,
          function( cat, alpha, beta )
            
            return IsZeroForMorphisms( cat, SubtractionForMorphisms( cat, alpha, beta ) );
            
        end );
        
    end;
    
    ##
    AddIsWellDefinedForObjects( category,
      function( cat, x )
        
        return IsIdenticalObj( underlying_category, CapCategory( UnderlyingOriginalObject( x ) ) );
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( category,
      function( cat, alpha )
        local coeffs, supp, size, s, i;
        
        coeffs = CoefficientsList( alpha );
        
        supp = SupportMorphisms( alpha );
        
        if (IsEmpty( coeffs ))
            if (IsEmpty( supp ))
                return true;
            else
                return false;
            end;
        end;
        
        size = Length( coeffs );
        
        if (size != Length( supp ))
            return false;
        end;
        
        if (@not ForAll( coeffs, c -> c in ring ))
            return false;
        end;
        
        if (@not with_nf)
            
            return true;
            
        end;
        
        if (ForAny( coeffs, c -> IsZero( c ) ))
            return false;
        end;
        
        s = supp[1];
        
        for i in (2):(size)
            
            if (@not sorting_function( s, supp[i] ))
                return false;
            end;
            
            s = supp[i];
            
        end;
        
        return true;
        
    end );
    
    ##
    if (@not @IsBound( category.cocycle ))
        
        ##
        AddPreCompose( category,
        function( cat, alpha, beta )
            local coeffs, supp;
            
            coeffs = ListX( CoefficientsList( alpha ), CoefficientsList( beta ), ( a,b ) -> a * b );
            
            supp = ListX( SupportMorphisms( alpha ), SupportMorphisms( beta ), ( a, b ) -> PreCompose( underlying_category, a, b ) );
            
            return MorphismConstructor( cat, Source( alpha ), PairGAP( coeffs, supp ), Range( beta ) );
            
        end );
        
    else
        
        cocycle = category.cocycle;
        
        ##
        AddPreCompose( category,
        function( cat, alpha, beta )
            local coeffs_alpha, coeffs_beta, supp_alpha, supp_beta, coeffs, supp, a, b, gamma, coeff;
            
            coeffs_alpha = CoefficientsList( alpha );
            
            coeffs_beta = CoefficientsList( beta );
            
            supp_alpha = SupportMorphisms( alpha );
            
            supp_beta = SupportMorphisms( beta );
            
            coeffs = [];
            
            supp = [];
            
            for a in (1):(Length( coeffs_alpha ))
                
                for b in (1):(Length( coeffs_beta ))
                    
                    gamma = PreCompose( supp_alpha[a], supp_beta[b] );
                    
                    coeff = ( coeffs_alpha[a] * coeffs_beta[b] ) * cocycle( supp_alpha[a], supp_beta[b], gamma );
                    
                    Add( supp, gamma );
                    
                    Add( coeffs, coeff );
                    
                end;
                
            end;
            
            return MorphismConstructor( cat, Source( alpha ), PairGAP( coeffs, supp ), Range( beta ) );
            
        end );
        
    end;
    
    ##
    AddIdentityMorphism( category,
      function( cat, object )
        
        return LinearClosureMorphismNC( cat, object, [ One( ring ) ], [ IdentityMorphism( UnderlyingCategory( cat ), UnderlyingOriginalObject( object ) ) ], object );
        
    end );
    
    ##
    AddZeroMorphism( category,
      function( cat, a, b )
        
        return LinearClosureMorphismNC( cat,
                       a,
                       CapJitTypedExpression( [ ], cat -> CapJitDataTypeOfListOf( RingElementFilter( CommutativeRingOfLinearCategory( cat ) ) ) ),
                       CapJitTypedExpression( [ ], cat -> CapJitDataTypeOfListOf( CapJitDataTypeOfMorphismOfCategory( UnderlyingCategory( cat ) ) ) ),
                       b );
        
    end );
    
    if (with_nf)
        
        ##
        AddIsZeroForMorphisms( category,
          function( cat, alpha )
            
            return IsEmpty( CoefficientsList( alpha ) );
            
        end );
        
    else
        
        ##
        AddIsZeroForMorphisms( category,
        function( cat, alpha )
            
            return LINEAR_CLOSURE_MORPHISM_SIMPLIFY( alpha, true );
            
        end );
        
    end;
    
    ##
    AddAdditionForMorphisms( category,
      function( cat, alpha, beta )
        
        return MorphismConstructor( cat,
                       Source( alpha ),
                       PairGAP( @Concatenation( CoefficientsList( alpha ), CoefficientsList( beta ) ),
                             @Concatenation( SupportMorphisms( alpha ), SupportMorphisms( beta ) ) ),
                       Range( alpha ) );
        
    end );
    
    ##
    AddAdditiveInverseForMorphisms( category,
      function( cat, alpha )
        
        return MorphismConstructor( cat,
                       Source( alpha ),
                       PairGAP( List( CoefficientsList( alpha ), c -> MinusOne( ring ) * c ),
                             SupportMorphisms( alpha ) ),
                       Range( alpha ) );
        
    end );
    
    ##
    AddSubtractionForMorphisms( category,
      function( cat, alpha, beta )

        return MorphismConstructor( cat,
                       Source( alpha ),
                       PairGAP( @Concatenation( CoefficientsList( alpha ), List( CoefficientsList( beta ), c -> MinusOne( ring ) * c ) ),
                             @Concatenation( SupportMorphisms( alpha ), SupportMorphisms( beta ) ) ),
                       Range( alpha ) );
        
    end );
    
    ##
    AddMultiplyWithElementOfCommutativeRingForMorphisms( category,
      function( cat, r, alpha )
        
        return MorphismConstructor( cat,
                       Source( alpha ),
                       PairGAP( List( CoefficientsList( alpha ), c -> r * c ),
                             SupportMorphisms( alpha ) ),
                       Range( alpha ) );
        
    end );
    
    if (@not with_nf)
        
        ##
        AddSimplifyMorphism( category,
            function( cat, alpha, i )
                
                return LINEAR_CLOSURE_MORPHISM_SIMPLIFY( alpha );
                
        end );
        
    end;
    
    if (HasIsObjectFiniteCategory( underlying_category ) && IsObjectFiniteCategory( underlying_category ))
        
        ##
        AddSetOfObjectsOfCategory( category,
          function( cat )
            
            return List( SetOfObjectsOfCategory( underlying_category ),
                         obj -> LinearClosureObject( category, obj ) );
            
        end );
        
    end;
    
    ## Homomorphism structure
    
    if (with_nf &&
       HasIsEquippedWithHomomorphismStructure( underlying_category ) &&
       IsEquippedWithHomomorphismStructure( underlying_category )
       #= comment for Julia
       && IsPackageMarkedForLoading( "FinSetsForCAP", ">= 2023.07-03" )
       # =#
   )
        
        INSTALL_HOMOMORPHISM_STRUCTURE_FOR_LINEAR_CLOSURE( category, rows );
        
    end;
    
end );

####################################
##
## Functors
##
####################################

##
InstallMethodWithCache( ExtendFunctorToLinearClosureOfSource,
              [ IsCapFunctor, IsLinearClosure, IsFunction ],
  function( F, linear_closure_source, ring_map )
    local source_cat, range_cat, name, G;
    
    source_cat = SourceOfFunctor( F );
    
    range_cat = RangeOfFunctor( F );
    
    if (@not IsIdenticalObj( source_cat, UnderlyingCategory( linear_closure_source ) ))
      
      Error( "The arguments are not compatible!\n" );
      
    end;
    
    if (!( HasIsLinearCategoryOverCommutativeRing( range_cat ) && IsLinearCategoryOverCommutativeRing( range_cat ) ))
      
      Error( "The range category named ", Name( range_cat ), " should be linear over some commutative ring!\n" );
      
    end;
     
    name = @Concatenation( "Extension of ", Name( F ), " to a functor from ", Name( linear_closure_source ) );
    
    G = CapFunctor( name, linear_closure_source, range_cat );
    
    AddObjectFunction( G,
      function( a )
        local o;
        
        o = UnderlyingOriginalObject( a );
        
        return ApplyFunctor( F, o );
        
    end );
    
    AddMorphismFunction( G,
      function( s, alpha, r )
        local coeffs, non_zeros, supp;
        
        coeffs = CoefficientsList( alpha );
        
        non_zeros = PositionsProperty( coeffs, c -> @not IsZero( c ) );
        
        if (IsEmpty( non_zeros ))
          
          return ZeroMorphism( s, r );
          
        end;
        
        coeffs = List( coeffs[ non_zeros ], ring_map );
        
        supp = SupportMorphisms( alpha )[ non_zeros ];
        
        supp = List( supp, m -> ApplyFunctor( F, m ) );
        
        return LinearCombinationOfMorphisms( s, coeffs, supp, r );
        
    end );
    
    return G;
    
end );

##
InstallMethodWithCache( ExtendFunctorToLinearClosureOfSource,
              [ IsCapFunctor, IsLinearClosure ],
    ( F, linear_closure_source ) -> ExtendFunctorToLinearClosureOfSource( F, linear_closure_source, IdFunc )
);

####################################
##
## View
##
####################################

##
@InstallMethod( ViewString,
               [ IsLinearClosureMorphism ],
    
    function( alpha )
        local coeffs, support, list;
        
        coeffs = CoefficientsList( alpha );
        
        if (IsEmpty( coeffs ))
            
            return "0";
            
        end;
        
        support = SupportMorphisms( alpha );
        
        list = List( (1):(Length( coeffs )), i -> @Concatenation( "(", ViewString( coeffs[i] ), "*", ViewString( support[i] ), ")" ) );
        
        return JoinStringsWithSeparator( list, " + " );
        
end );

##
@InstallMethod( ViewString,
               [ IsLinearClosureObject ],

  function( obj )
    
    return @Concatenation( "LinearClosureObject(", ViewString( UnderlyingOriginalObject( obj ) ), ")" );
    
end );

####################################
##
## Convenience
##
####################################

@InstallMethod( *,
               [ IsLinearClosureMorphism, IsLinearClosureMorphism ],
               PreCompose );

@InstallMethod( ==,
               [ IsLinearClosureMorphism, IsLinearClosureMorphism ],
               IsCongruentForMorphisms );

@InstallMethod( /,
               [ IsCapCategoryMorphism, IsLinearClosure ],
               
    function( mor, cat )
        
        return LinearClosureMorphismNC(
            LinearClosureObject( Source( mor ), cat ),
            [ One( UnderlyingRing( cat ) ) ],
            [ mor ],
            LinearClosureObject( Range( mor ), cat )
        );
        
end );

####################################
##
## Down
##
####################################

##
@InstallMethod( Down,
               [ IsLinearClosureObject ],
  function( obj )
    
    return UnderlyingOriginalObject( obj );
    
end );

##
@InstallMethod( DownOnlyMorphismData,
               [ IsLinearClosureMorphism ],
  function( mor )
    
    return [ CoefficientsList( mor ), SupportMorphisms( mor ) ];
    
end );
