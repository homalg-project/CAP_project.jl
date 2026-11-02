# SPDX-License-Identifier: GPL-2.0-or-later
# LocalesForCAP: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

##
@InstallMethod( SingleDifference,
        "for a meet semi-lattice of single differences and a pair",
        [ IsMeetSemilatticeOfSingleDifferences, IsList ],

  function( D, minuend_subtrahend_pair )
    local C;
    
    C = CreateCapCategoryObjectWithAttributes( D,
                 PreMinuendAndSubtrahendInUnderlyingLattice, minuend_subtrahend_pair,
                 IsLocallyClosed, true );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 4, IsWellDefinedForObjects( C ) );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    if (HasIsInitial( minuend_subtrahend_pair[1] ) && IsInitial( minuend_subtrahend_pair[1] ))
        SetIsInitial( C, true );
    end;
    
    return C;
    
end );

##
@InstallMethod( MeetSemilatticeOfSingleDifferences,
        "for a CAP category",
        [ FilterIntersection( IsCapCategory, IsThinCategory ) ],
        
  function( P )
    local name, D, L;
    
    if (!( HasIsDistributiveBicartesianProset( P ) && IsDistributiveBicartesianProset( P ) ))
        Error( "the input category `P` must be a distributive (bicartesian) proset (e.g. a distributive lattice) ",
               "for the meet-semilattice of single differences to be well-defined\n" );
    end;
    
    name = @Concatenation( "MeetSemilatticeOfSingleDifferences( ", Name( P ), " )" );
    
    D = CreateCapCategoryWithDataTypes( name,
                 IsMeetSemilatticeOfSingleDifferences,
                 IsObjectInMeetSemilatticeOfSingleDifferences,
                 IsMorphismInMeetSemilatticeOfSingleDifferences,
                 IsCapCategoryTwoCell,
                 CapJitDataTypeOfNTupleOf( 2,
                         CapJitDataTypeOfObjectOfCategory( P ),
                         CapJitDataTypeOfObjectOfCategory( P ) ),
                 fail,
                 fail );
    
    SetIsMeetSemiLattice( D, true );
    
    SetUnderlyingCategory( D, P );
    
    D.compiler_hints = @rec(
        category_attribute_names = [
            "UnderlyingCategory",
        ],
    );
    
    if (HasIsFiniteCategory( P ) && IsFiniteCategory( P ))
        SetIsFiniteCategory( D, true );
        SetIsFinitelyPresentedCategory( D, true );
    end;
    
    ADD_COMMON_METHODS_FOR_PREORDERED_SETS( D );
    
    ##
    AddObjectConstructor( D,
      function( D, minuend_subtrahend_pair )
        
        return SingleDifference( D, minuend_subtrahend_pair );
        
    end );
    
    ##
    AddIsWellDefinedForObjects( D,
      function( D, A )
        local pair, C;
        
        pair = MinuendAndSubtrahendInUnderlyingLattice( A );
        
        C = UnderlyingCategory( D );
        
        return IsIdenticalObj( CapCategory( pair[1] ), C ) &&
               IsIdenticalObj( CapCategory( pair[2] ), C ) &&
               IsWellDefinedForObjects( C, pair[1] ) &&
               IsWellDefinedForObjects( C, pair[2] );
        
    end );
    
    ## the following is independent of the representatives of the single differences when the given bicartesian proset is (co)distributive
    ## (A - A') ≤_D (B - B') ⟺  ( A ≤_C ( A' ∨ B ) ) and ( ( A ∧ B' ) ≤_C A' )
    AddIsHomSetInhabited( D,
      function( D, A, B )
        local A_pair, B_pair, C;
        
        A_pair = MinuendAndSubtrahendInUnderlyingLattice( A );
        B_pair = MinuendAndSubtrahendInUnderlyingLattice( B );
        
        C = UnderlyingCategory( D );
        
        return IsHomSetInhabited( C, A_pair[1], Coproduct( C, [ A_pair[2], B_pair[1] ] ) ) &&
               IsHomSetInhabited( C, DirectProduct( C, [ A_pair[1], B_pair[2] ] ), A_pair[2] );
        
    end );
    
    L = ListInstalledOperationsOfCategory( P );
    
    if (!( HasIsSkeletalCategory( P ) && IsSkeletalCategory( P ) ))
        Error( "the category is not known to be skeletal\n" );
    elseif (!( "DirectProduct" in L && "Coproduct" in L ))
        Error( "the category does not seem to be a lattice\n" );
    end;
    
    ##
    AddTerminalObject( D,
      function( D )
        local T, I;
        
        T = TerminalObject( UnderlyingCategory( D ) );
        I = InitialObject( UnderlyingCategory( D ) );
        
        return SingleDifference( D, PairGAP( T, I ) );
        
    end );
    
    ##
    AddInitialObject( D,
      function( D )
        local I;
        
        I = InitialObject( UnderlyingCategory( D ) );
        
        return SingleDifference( D, PairGAP( I, I ) );
        
    end );
    
    ##
    AddIsInitial( D,
      function( D, A )
        local pair;
        
        pair = MinuendAndSubtrahendInUnderlyingLattice( A );
        
        return IsHomSetInhabited( UnderlyingCategory( D ), pair[1], pair[2] );
        
    end );
    
    ##
    AddDirectProduct( D,
      function( D, L )
        local L_pairs, C, T, S;
        
        L_pairs = List( L, MinuendAndSubtrahendInUnderlyingLattice );
        
        C = UnderlyingCategory( D );
        
        T = DirectProduct( C, List( L_pairs, a -> a[1] ) );
        S = Coproduct( C, List( L_pairs, a -> a[2] ) );
        
        return SingleDifference( D, PairGAP( T, S ) );
        
    end );
    
    if (CanCompute( P, "SetOfObjectsOfCategory" ))
        
        AddSetOfObjectsOfCategory( D,
          function( D )
            local P, objects, empty, objects_nonempty, L;
            
            P = UnderlyingCategory( D );
            
            objects = SetOfObjects( P );
            
            empty = InitialObject( P );
            
            objects_nonempty = Filtered( objects, o -> @not IsInitial( P, o ) );
            
            L = @Concatenation(
                         ## the original objects are listed first
                         List( objects, m -> ObjectConstructor( D, PairGAP( m, empty ) ) ),
                         @Concatenation( List( objects, m ->
                                 List( objects_nonempty, s ->
                                       ObjectConstructor( D, PairGAP( m, s ) ) ) ) ) );
            
            return DuplicateFreeList( L );
            
        end );
        
    end;
    
    HandlePrecompiledTowers( D, P, "MeetSemilatticeOfDifferences" );
    
    Finalize( D );
    
    return D;
    
end );

##
@InstallMethod( SetOfObjects,
        "for a meet-semilattice of single differences",
        [ IsMeetSemilatticeOfSingleDifferences ],
        
  function( D )
    
    return SetOfObjectsOfCategory( D );
    
end );

##
@InstallMethod( SetOfGeneratingMorphisms,
        "for a meet-semilattice of single differences",
        [ IsMeetSemilatticeOfSingleDifferences ],
        
  function( D )
    
    return SetOfGeneratingMorphismsOfCategory( D );
    
end );

##
@InstallMethod( SetOfGeneratingObjects,
        "for a meet-semilattice of single differences",
        [ IsMeetSemilatticeOfSingleDifferences ],
        
  function( D )
    local Dist;
    
    Dist = UnderlyingCategory( D );
    
    return List( SetOfObjects( Dist ), minued ->
                 SingleDifference( D, PairGAP( minued, InitialObject( Dist ) ) ) );
    
end );

##
@InstallMethod( -,
        "for two objects in a thin category",
        [ IsObjectInThinCategory, IsObjectInThinCategory ],
        
  function( A, B )
    local H, D;
    
    H = CapCategory( A );
    
    if (@not IsIdenticalObj( H, CapCategory( B ) ))
        Error( "the arguments A and B are in different categories\n" );
    end;
    
    D = MeetSemilatticeOfSingleDifferences( H );
    
    return SingleDifference( D, PairGAP( A, B ) );
    
end );

##
@InstallMethod( -,
        "for an object in a meet-semilattice of formal single differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfSingleDifferences, IsObjectInThinCategory ],
        
  function( A, B )
    
    A = MinuendAndSubtrahendInUnderlyingLattice( A );
    
    return A[1] - ( A[2] + B );
    
end );

##
@InstallMethod( -,
        "for an object in a thin category and the zero integer",
        [ IsObjectInThinCategory, IsInt ],
        
  function( A, B )
    
    if (!( HasIsZero( B ) && IsZero( B ) ))
        TryNextMethod( );
    end;
    
    return A - InitialObject( CapCategory( A ) );
    
end );

##
@InstallMethod( -,
        "for an object in a meet-semilattice of formal single differences and the zero integer",
        [ IsObjectInMeetSemilatticeOfSingleDifferences, IsInt ],
        
  function( A, B )
    
    if (!( HasIsZero( B ) && IsZero( B ) ))
        TryNextMethod( );
    end;
    
    return A;
    
end );

##
@InstallMethod( AdditiveInverseMutable,
        "for an object in a thin category",
        [ IsObjectInThinCategory ],
        
  function( A )
    
    return TerminalObject( CapCategory( A ) ) - A;
    
end );

##
@InstallMethod( FormalDifferenceOfNormalizedObjects,
        "for two objects in a thin category",
        [ IsObjectInThinCategory, IsObjectInThinCategory ],
        
  function( A, B )
    local D, C;
    
    D = MeetSemilatticeOfSingleDifferences( CapCategory( A ) );
    
    C = CreateCapCategoryObjectWithAttributes( D,
                 NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid, [ A, B ],
                 IsLocallyClosed, true );
    
    @Assert( 4, IsWellDefined( C ) );
    
    return C;
    
end );

##
@InstallMethod( NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid,
        "for a Heyting algebroid and two objects in it",
        [ FilterIntersection( IsCapCategory, IsHeytingAlgebroid ), IsCapCategoryObject, IsCapCategoryObject ],
        
  function( L, minuend, subtrahend )
    local H;
    
    # H = ExponentialOnObjects( L, minuend, subtrahend );
    # the following line performed better than the previous one
    H = ExponentialOnObjects( L, Coproduct( minuend, subtrahend ), subtrahend );
    
    return PairGAP( Coproduct( H, minuend ), H );
    
end );

##
@InstallMethod( NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid,
        "for a co-Heyting algebroid and two objects in it",
        [ FilterIntersection( IsCapCategory, IsCoHeytingAlgebroid ), IsCapCategoryObject, IsCapCategoryObject ],
        
  function( L, minuend, subtrahend )
    local H;
    
    # H = CoexponentialOnObjects( L, minuend, subtrahend );
    # the following line performed better than the previous one
    H = CoexponentialOnObjects( L, minuend, DirectProduct( subtrahend, minuend ) );
    
    return PairGAP( H, DirectProduct( subtrahend, H ) );
    
end );

##
@InstallMethod( NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid,
        "for an object in a meet-semilattice of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A )
    local minuend_subtrahend_pair, minuend, subtrahend, L;
    
    minuend_subtrahend_pair = MinuendAndSubtrahendInUnderlyingLattice( A );
    
    minuend = minuend_subtrahend_pair[1];
    subtrahend = minuend_subtrahend_pair[2];
    
    L = CapCategory( minuend );
    
    return NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid( L, minuend, subtrahend );
    
end );

##
@InstallMethod( NormalizeObject,
        "for an object in a meet-semilattice of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A )
    
    List( NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid( A ), IsInitial );
    
    return A;
    
end );

##
@InstallMethod( StandardizeObject,
        "for an object in a meet-semilattice of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A )
    
    List( StandardMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid( A ), IsInitial );
    
    return A;
    
end );

##
@InstallMethod( FactorsAttr,
        "for an object in a meet-semilattice of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A )
    local Ac, facAc, facAp;
    
    StandardizeObject( A );
    
    Ac = Closure( A );
    
    facAc = Factors( Ac );
    
    facAp = Factors( A.J );
    
    if (facAp == [ ])
        facAp = [ InitialObject( CapCategory( Ac ) ) ];
    end;
    
    A = List( facAc, T -> CallFuncList( AsMultipleDifference, List( facAp, S -> T - S ) ) );
    
    List( A, StandardizeObject );
    
    Perform( A, function( a ) SetFactorsAttr( a, [ a ] ); end );
    
    return A;
    
end );

##
@InstallMethod( MinuendAndSubtrahendInUnderlyingLattice,
        "for an object in a meet-semilattice of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  PreMinuendAndSubtrahendInUnderlyingLattice );

##
@InstallMethod( MinuendAndSubtrahendInUnderlyingLattice,
        "for an object in a meet-semilattice of formal single differences",
        [ FilterIntersection( IsObjectInMeetSemilatticeOfSingleDifferences, HasNormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid ) ],
        
  NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid );

##
@InstallMethod( MinuendAndSubtrahendInUnderlyingLattice,
        "for an object in a meet-semilattice of formal single differences",
        [ FilterIntersection( IsObjectInMeetSemilatticeOfSingleDifferences, HasStandardMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid ) ],
        
  StandardMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid );

##
@InstallMethod( NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid,
        "for an object in a meet-semilattice of formal single differences",
        [ FilterIntersection( IsObjectInMeetSemilatticeOfSingleDifferences, HasStandardMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid ) ],
        
  StandardMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid );

##
@InstallMethod( DistinguishedSubtrahend,
        "for an object in a meet-semilattice of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  PreDistinguishedSubtrahend );

##
@InstallMethod( DistinguishedSubtrahend,
        "for an object in a meet-semilattice of formal single differences",
        [ FilterIntersection( IsObjectInMeetSemilatticeOfSingleDifferences, HasNormalizedDistinguishedSubtrahend ) ],
        
  NormalizedDistinguishedSubtrahend );

##
@InstallMethod( IsClosedSubobject,
        "for an object in a meet-semilattice of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A )
    local H;
    
    H = UnderlyingCategory( CapCategory( A ) );
    
    if (HasIsCoHeytingAlgebroid( H ) && IsCoHeytingAlgebroid( H ))
        return IsInitial( H, NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid( A )[2] );
    elseif (HasIsHeytingAlgebroid( H ) && IsHeytingAlgebroid( H ))
        return IsTerminal( H, NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid( A )[1] );
    end;
    
    TryNextMethod( );
    
end );

##
@InstallMethod( Closure,
        "for an object in a meet-semilattice of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A )
    local H;
    
    H = UnderlyingCategory( CapCategory( A ) );
    
    if (HasIsCoHeytingAlgebroid( H ) && IsCoHeytingAlgebroid( H ))
        return NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid( A )[1];
    end;
    
    TryNextMethod( );
    
end );

##
@InstallMethod( *,
        "for an object in a thin category and an object in a meet-semilattice of formal single differences",
        [ IsObjectInThinCategory, IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A, B )
    
    if (IsObjectInMeetSemilatticeOfSingleDifferences( A ))
        TryNextMethod( );
    end;
    
    return ( A - 0 ) * B;
    
end );

##
@InstallMethod( *,
        "for an object in a meet-semilattice of formal single differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfSingleDifferences, IsObjectInThinCategory ],
        
  function( A, B )
    
    if (IsObjectInMeetSemilatticeOfSingleDifferences( B ))
        TryNextMethod( );
    end;
    
    return A * ( B - 0 );
    
end );

##
@InstallMethod( ==,
        "for an object in a thin category and an object in a meet-semilattice of formal single differences",
        [ IsObjectInThinCategory, IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A, B )
    
    if (IsObjectInMeetSemilatticeOfSingleDifferences( A ))
        TryNextMethod( );
    end;
    
    return ( A - 0 ) == B;
    
end );

##
@InstallMethod( ==,
        "for an object in a meet-semilattice of formal single differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfSingleDifferences, IsObjectInThinCategory ],
        
  function( A, B )
    
    if (IsObjectInMeetSemilatticeOfSingleDifferences( B ))
        TryNextMethod( );
    end;
    
    return A == ( B - 0 );
    
end );

##
@InstallMethod( /,
        "for an object in a meet-semilattice of formal single differences and a positive integer",
        [ IsString, IsObjectInMeetSemilatticeOfSingleDifferences ],

  function( name, A )
    
    A = MinuendAndSubtrahendInUnderlyingLattice( A );
    
    if (name[1] == 'I')
        return A[1];
    elseif (name[1] == 'J')
        return A[2];
    end;
    
    Error( "no component with this name available\n" );
    
end );

#= comment for Julia
##
INSTALL_DOT_METHOD( IsObjectInMeetSemilatticeOfSingleDifferences );
# =#

##
@InstallMethod( /,
        "for a meet-semilattice of formal single differences and a positive integer",
        [ IsString, IsMeetSemilatticeOfSingleDifferences ],

  function( name, D )
    local Dist;
    
    Dist = UnderlyingCategory( D );
    
    return SingleDifference( D, PairGAP( Dist[name], InitialObject( Dist ) ) );
    
end );

#= comment for Julia
##
INSTALL_DOT_METHOD( IsMeetSemilatticeOfSingleDifferences );
# =#

##
@InstallMethod( ViewString,
        "for an object in a meet-semilattice of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A )
    local n, str;
    
    A = MinuendAndSubtrahendInUnderlyingLattice( A );
    
    n = ValueOption( "Locales_number" );
    
    if (n == fail)
        n = "";
    end;
    
    str = ViewString( A[1]; Locales_name = "I", Locales_number = n );
    str = @Concatenation( str, " \\ " );
    str = @Concatenation( str, ViewString( A[2]; Locales_name = "J", Locales_number = n ) );
    
    return str;
    
end );

##
@InstallMethod( StringGAP,
        "for an object in a meet-semilattice of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  ViewString );
    
##
@InstallMethod( DisplayString,
        "for an object in a meet-semilattice of formal single differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences ],
        
  function( A )
    
    A = MinuendAndSubtrahendInUnderlyingLattice( A );
    
    return @Concatenation(
                   DisplayString( A[1] ),
                   "\n\n\\ ",
                   DisplayString( A[2] ),
                   "\n" );
    
end );
