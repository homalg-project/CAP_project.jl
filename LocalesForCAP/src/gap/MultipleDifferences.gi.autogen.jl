# SPDX-License-Identifier: GPL-2.0-or-later
# LocalesForCAP: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

##
@InstallMethod( MultipleDifference,
        "for a meet semi-lattice of multiple differences and a list",
        [ IsMeetSemilatticeOfMultipleDifferences, IsList ],
        
  function( D, L )
    local A;
    
    A = CreateCapCategoryObjectWithAttributes( D,
                 ListOfPreObjectsInMeetSemilatticeOfDifferences, L,
                 IsLocallyClosed, true );
    
    #% CAP_JIT_DROP_NEXT_STATEMENT
    @Assert( 4, IsWellDefined( A ) );
    
    return A;
    
end );

##
@InstallMethod( MeetSemilatticeOfMultipleDifferences,
        "for a CAP category",
        [ FilterIntersection( IsCapCategory, IsThinCategory ) ],
        
  function( P )
    local name, D, SD;
    
    if (!( HasIsDistributiveBicartesianProset( P ) && IsDistributiveBicartesianProset( P ) ))
        Error( "the input category `P` must be a distributive (bicartesian) proset (e.g. a distributive lattice) ",
               "for the meet-semilattice of multiple differences to be well-defined\n" );
    end;
    
    name = @Concatenation( "MeetSemilatticeOfMultipleDifferences( ", Name( P ), " )" );
    
    D = CreateCapCategory( name,
                 IsMeetSemilatticeOfMultipleDifferences,
                 IsObjectInMeetSemilatticeOfMultipleDifferences,
                 IsMorphismInMeetSemilatticeOfMultipleDifferences,
                 IsCapCategoryTwoCell );
    
    SetIsMeetSemiLattice( D, true );
    
    SetUnderlyingCategory( D, P );
    
    SD = MeetSemilatticeOfSingleDifferences( P; FinalizeCategory = true );
    
    SetUnderlyingCategoryOfSingleDifferences( D, SD );
    
    D.compiler_hints =
      @rec(
          category_attribute_names = [
                  "UnderlyingCategory",
                  "UnderlyingCategoryOfSingleDifferences",
                  ],
          );
    
    ADD_COMMON_METHODS_FOR_PREORDERED_SETS( D );
    
    ##
    AddIsWellDefinedForObjects( D,
      function( cat, A )
        local S;
        
        S = UnderlyingCategoryOfSingleDifferences( cat );
        
        return ForAll( ListOfSingleDifferences( A ), IsObjectInMeetSemilatticeOfSingleDifferences ) &&
               ForAll( ListOfSingleDifferences( A ), d -> IsWellDefinedForObjects( S, d ) );
        
    end );
    
    ##
    AddTerminalObject( D,
      function( cat )
        local T;
        
        T = TerminalObject( UnderlyingCategoryOfSingleDifferences( D ) );
        
        return MultipleDifference( cat, [ T ] );
        
    end );
    
    ##
    AddInitialObject( D,
      function( cat )
        local I;
        
        I = InitialObject( UnderlyingCategoryOfSingleDifferences( D ) );
        
        return MultipleDifference( cat, [ I ] );
        
    end );
    
    ##
    AddIsInitial( D,
      function( cat, A )
        local L, AI, AJ, S;
        
        L = ListOfSingleDifferences( A );
        
        AI = MinuendAndSubtrahendInUnderlyingLattice( L[1] )[1];
        
        AJ = Coproduct( UnderlyingCategory( cat ), List( L, d -> MinuendAndSubtrahendInUnderlyingLattice( d )[2] ) );
        
        S = UnderlyingCategoryOfSingleDifferences( cat );
        
        return IsInitial( S, SingleDifference( S, PairGAP( AI, AJ ) ) );
        
    end );
    
    ##
    AddDirectProduct( D,
      function( cat, L )
        local H, l, SD, A, A_N;
        
        H = UnderlyingCategory( cat );
        
        l = List( L, ListOfSingleDifferences );
        
        ## start unifying the minuend
        A = DirectProduct( H, List( l, ls -> MinuendAndSubtrahendInUnderlyingLattice( ls[1] )[1] ) );
        
        ## the meet semi-lattice of single differences
        SD = UnderlyingCategoryOfSingleDifferences( cat );
        
        ## make all single differences have the same minuend
        A_N = List( @Concatenation( l ),
          function( s )
            local S;
            
            S = SingleDifference( SD, PairGAP( A, MinuendAndSubtrahendInUnderlyingLattice( s )[2] ) ); # A - s.J
            
            #% CAP_JIT_DROP_NEXT_STATEMENT
            if (HasNormalizedDistinguishedSubtrahend( s ))
                SetNormalizedDistinguishedSubtrahend( S, NormalizedDistinguishedSubtrahend( s ) );
            elseif (HasPreDistinguishedSubtrahend( s ))
                SetPreDistinguishedSubtrahend( S, PreDistinguishedSubtrahend( s ) );
            end;
            
            return S;
            
        end );
        
        return MultipleDifference( cat, A_N );
        
    end );
    
    ##
    AddIsHomSetInhabited( D,
      function( cat, A, B )
        local B1, BI, S, H, mBI;
        
        B1 = ListOfSingleDifferences( B )[1];
        
        ## the minuend B.I of B
        BI = MinuendAndSubtrahendInUnderlyingLattice( B1 )[1];
        
        ## the meet semi-lattice of single differences
        S = UnderlyingCategoryOfSingleDifferences( cat );
        
        H = UnderlyingCategory( cat );
        
        ## the complement -B.I of the minuend B.I of B as a multiple difference
        mBI = MultipleDifference( cat, [ SingleDifference( S, PairGAP( TerminalObject( H ), BI ) ) ] );
        
        return IsInitial( cat, DirectProduct( cat, [ A, mBI ] ) ) && ## A - B.I
               ForAll( ListOfSingleDifferences( B ), s ->
                       IsInitial( cat,
                               DirectProduct( cat,  # A * s.J
                                       [ A,
                                         MultipleDifference( cat, [ SingleDifference( S, PairGAP( MinuendAndSubtrahendInUnderlyingLattice( s )[2], InitialObject( H ) ) ) ] ) # s.J - ∅
                                         ] ) ) );
        
    end );
    
    HandlePrecompiledTowers( D, P, "MeetSemilatticeOfMultipleDifferences" );
    
    Finalize( D );
    
    return D;
    
end );

##
@InstallGlobalFunction( AsMultipleDifference,
  function( arg... )
    local S, D, A_N;
    
    S = CapCategory( arg[1] );
    
    if (@not ForAll( arg, IsObjectInMeetSemilatticeOfSingleDifferences ))
        Error( "not all arguments are formal single differences\n" );
    elseif (@not ForAll( arg[[ 2.. Length( arg ) ]], d -> IsIdenticalObj( CapCategory( d ), S ) ))
        Error( "not all arguments lie in the same category\n" );
    end;
    
    D = MeetSemilatticeOfMultipleDifferences( UnderlyingCategory( S ) );
    
    A_N = DirectProduct( D, List( arg, s -> MultipleDifference( D, [ s ] ) ) );
    
    @Assert( 4, IsWellDefined( A_N ) );
    
    return A_N;
    
end );

##
@InstallMethod( -,
        "for an object in a meet-semilattice of formal multiple differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsObjectInThinCategory ],
        
  function( A, B )
    
    if (IsObjectInMeetSemilatticeOfSingleDifferences( B ) ||
       IsObjectInMeetSemilatticeOfMultipleDifferences( B ))
        TryNextMethod( );
    end;
    
    A = List( A );
    
    A = ShallowCopy( A );
    
    Add( A, -B );
    
    return CallFuncList( AsMultipleDifference, A );
    
end );

##
#InstallMethod( -,
#        "for an object in a meet-semilattice of formal single differences and an object in a thin category",
#        [ IsObjectInMeetSemilatticeOfSingleDifferences, IsObjectInThinCategory ],
#        
#  function( A, B )
#    local U;
#    
#    if IsObjectInMeetSemilatticeOfSingleDifferences( B ) or
#       IsObjectInMeetSemilatticeOfMultipleDifferences( B ))
#        TryNextMethod( );
#    end;
#    
#    return AsMultipleDifference( A ) - B;
#    
#end );

##
@InstallMethod( ListOfNormalizedObjectsInMeetSemilatticeOfDifferences,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local T_new, T, pos;
    
    T_new = DirectProduct( List( A, a -> a.I ) );
    
    while true
        
        T = T_new;
        
        # avoid searching for maximal objects too early
        # avoid excluding exmpty sets too early
        
        A = List( A,
          function( d )
            local D;
            
            D = T - d.J;
            
            NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid( D );
            
            if (HasNormalizedDistinguishedSubtrahend( d ))
                SetNormalizedDistinguishedSubtrahend( D, NormalizedDistinguishedSubtrahend( d ) );
            elseif (HasPreDistinguishedSubtrahend( d ))
                SetPreDistinguishedSubtrahend( D, PreDistinguishedSubtrahend( d ) );
            end;
            
            return D;
            
        end );
        
        T_new = DirectProduct( List( A, a -> a.I ) );
        
        if (AreIsomorphicForObjectsIfIsHomSetInhabited( T_new, T ))
            break;
        end;
        
    end;
    
    pos = PositionsOfMaximalObjects( List( A, d -> d.J ), IsHomSetInhabited );
    
    return A[pos];
    
end );

##
@InstallMethod( ListOfStandardObjectsInMeetSemilatticeOfDifferences,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    
    A = ListOfNormalizedObjectsInMeetSemilatticeOfDifferences( A );
    
    List( A, StandardMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid );
    
    return A;
    
end );

##
@InstallMethod( ListOfSingleDifferences,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  ListOfPreObjectsInMeetSemilatticeOfDifferences );

##
@InstallMethod( ListOfSingleDifferences,
        "for an object in a meet-semilattice of formal multiple differences",
        [ FilterIntersection( IsObjectInMeetSemilatticeOfMultipleDifferences, HasListOfNormalizedObjectsInMeetSemilatticeOfDifferences ) ],
        
  ListOfNormalizedObjectsInMeetSemilatticeOfDifferences );

##
@InstallMethod( ListOfSingleDifferences,
        "for an object in a meet-semilattice of formal multiple differences",
        [ FilterIntersection( IsObjectInMeetSemilatticeOfMultipleDifferences, HasListOfStandardObjectsInMeetSemilatticeOfDifferences ) ],
        
  ListOfStandardObjectsInMeetSemilatticeOfDifferences );

##
@InstallMethod( EquivalenceToMeetSemilatticeOfDifferences,
        "for a CAP category",
        [ FilterIntersection( IsCapCategory, IsThinCategory ) ],
        
  function( P )
    local S, T, squash;
    
    S = MeetSemilatticeOfMultipleDifferences( P );
    T = MeetSemilatticeOfSingleDifferences( P );
    
    squash = CapFunctor( "Equivalence from the meet-semilattice of formal multiple differences to the meet-semilattice of formal single differences", S, T );
    
    AddObjectFunction( squash,
      function( obj )
        local U, T, S;
        
        U = List( obj, MinuendAndSubtrahendInUnderlyingLattice );
        
        T = DirectProduct( List( U, a -> a[1] ) );
        S = Coproduct( List( U, a -> a[2] ) );
        
        return T - S;
        
    end );
    
    AddMorphismFunction( squash,
      function( new_source, mor, new_range )
        
        return UniqueMorphism( T, new_source, new_range );
        
    end );
    
    return squash;
    
end );

##
@InstallMethod( AsSingleDifference,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local P, F;
    
    P = UnderlyingCategory( CapCategory( A ) );
    
    F = EquivalenceToMeetSemilatticeOfDifferences( P );
    
    return ApplyFunctor( F, A );
    
end );

##
@InstallMethod( NormalizeObject,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    
    List( ListOfNormalizedObjectsInMeetSemilatticeOfDifferences( A ), IsInitial );
    
    return A;
    
end );

##
@InstallMethod( StandardizeObject,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    
    List( ListOfStandardObjectsInMeetSemilatticeOfDifferences( A ), IsInitial );
    
    return A;
    
end );

##
@InstallMethod( FactorsAttr,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local Ac, facAc, facAp;
    
    StandardizeObject( A );
    
    Ac = Closure( A );
    
    facAc = Factors( Ac );
    
    facAp = @Concatenation( List( A, D -> Factors( D.J ) ) );
    
    if (facAp == [ ])
        facAp = [ InitialObject( CapCategory( Ac ) ) ];
    end;
    
    A = List( facAc, T -> CallFuncList( AsMultipleDifference, List( facAp, S -> T - S ) ) );
    
    List( A, StandardizeObject );
    
    Perform( A, function( a ) SetFactorsAttr( a, [ a ] ); end );
    
    return A;
    
end );

##
@InstallMethod( IsClosedSubobject,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local H;
    
    H = UnderlyingCategory( CapCategory( A ) );
    
    if (( HasIsCoHeytingAlgebroid( H ) && IsCoHeytingAlgebroid( H ) ) ||
       ( HasIsHeytingAlgebroid( H ) && IsHeytingAlgebroid( H ) ))
        return ForAll( ListOfNormalizedObjectsInMeetSemilatticeOfDifferences( A ), IsClosedSubobject );
    end;
    
    TryNextMethod( );
    
end );

##
@InstallMethod( Closure,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local H;
    
    H = UnderlyingCategory( CapCategory( A ) );
    
    if (HasIsCoHeytingAlgebroid( H ) && IsCoHeytingAlgebroid( H ))
        return ListOfNormalizedObjectsInMeetSemilatticeOfDifferences( A )[1].I;
    end;
    
    TryNextMethod( );
    
end );

##
@InstallMethod( *,
        "for an object in a thin category and an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences, IsObjectInMeetSemilatticeOfMultipleDifferences ],

  function( A, B )
    
    if (IsObjectInMeetSemilatticeOfMultipleDifferences( A ))
        TryNextMethod( );
    end;
    
    return AsMultipleDifference( A ) * B;
    
end );

##
@InstallMethod( *,
        "for an object in a meet-semilattice of formal multiple differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsObjectInMeetSemilatticeOfSingleDifferences ],

  function( A, B )
    
    if (IsObjectInMeetSemilatticeOfMultipleDifferences( B ))
        TryNextMethod( );
    end;
    
    return A * AsMultipleDifference( B );
    
end );

##
@InstallMethod( ==,
        "for an object in a thin category and an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfSingleDifferences, IsObjectInMeetSemilatticeOfMultipleDifferences ],

  function( A, B )
    
    if (IsObjectInMeetSemilatticeOfMultipleDifferences( A ))
        TryNextMethod( );
    end;
    
    return AsMultipleDifference( A ) == B;
    
end );

##
@InstallMethod( ==,
        "for an object in a meet-semilattice of formal multiple differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsObjectInMeetSemilatticeOfSingleDifferences ],

  function( A, B )
    
    if (IsObjectInMeetSemilatticeOfMultipleDifferences( B ))
        TryNextMethod( );
    end;
    
    return A == AsMultipleDifference( B );
    
end );

##
@InstallMethod( *,
        "for an object in a thin category and an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInThinCategory, IsObjectInMeetSemilatticeOfMultipleDifferences ],

  function( A, B )
    
    if (IsObjectInMeetSemilatticeOfMultipleDifferences( A ))
        TryNextMethod( );
    end;
    
    return ( A - 0 ) * B;
    
end );

##
@InstallMethod( *,
        "for an object in a meet-semilattice of formal multiple differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsObjectInThinCategory ],

  function( A, B )
    
    if (IsObjectInMeetSemilatticeOfMultipleDifferences( B ))
        TryNextMethod( );
    end;
    
    return A * ( B - 0 );
    
end );

##
@InstallMethod( ==,
        "for an object in a thin category and an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInThinCategory, IsObjectInMeetSemilatticeOfMultipleDifferences ],

  function( A, B )
    
    if (IsObjectInMeetSemilatticeOfMultipleDifferences( A ))
        TryNextMethod( );
    end;
    
    return ( A - 0 ) == B;
    
end );

##
@InstallMethod( ==,
        "for an object in a meet-semilattice of formal multiple differences and an object in a thin category",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsObjectInThinCategory ],

  function( A, B )
    
    if (IsObjectInMeetSemilatticeOfMultipleDifferences( B ))
        TryNextMethod( );
    end;
    
    return A == ( B - 0 );
    
end );

##
@InstallMethod( ListOp,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
   ListOfSingleDifferences );

##
@InstallMethod( ListOp,
        "for an object in a meet-semilattice of formal multiple differences and a function",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsFunction ],
        
  function( A, f )
    
    return List( List( A ), f );
    
end );

#= comment for Julia
##
@InstallMethod( Iterator,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  A -> Iterator( List( A ) ) );
# =#

##
@InstallMethod( ForAllOp,
        "for an object in a meet-semilattice of formal multiple differences and a function",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsFunction ],
        
  function( A, f )
    
    return ForAll( List( A ), f );
    
end );

##
@InstallMethod( ForAnyOp,
        "for an object in a meet-semilattice of formal multiple differences and a function",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsFunction ],
        
  function( A, f )
    
    return ForAny( List( A ), f );
    
end );

##
@InstallMethod( getindex,
        "for an object in a meet-semilattice of formal multiple differences and a positive integer",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences, IsPosInt ],
        
  function( A, pos )
    
    return List( A )[pos];
    
end );

##
@InstallMethod( /,
        "for a string and an object in a meet-semilattice of formal multiple differences",
        [ IsString, IsObjectInMeetSemilatticeOfMultipleDifferences ],

  function( name, A )
    
    if (name[1] == 'I')
        return A[1].I;
    elseif (name[1] == 'J')
        return A[EvalString( name[(2):(Length( name ))] )].J;
    end;
    
    Error( "no component with this name available\n" );
    
end );

#= comment for Julia
##
INSTALL_DOT_METHOD( IsObjectInMeetSemilatticeOfMultipleDifferences );
# =#

##
@InstallMethod( ViewString,
        "for an object in a meet-semilattice of formal mutliple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local n, str, i, j;
    
    A = List( A );
    
    n = ValueOption( "Locales_number" );
    
    if (n == fail)
        n = "";
    end;
    
    str = ViewString( A[1].I; Locales_name = "I", Locales_number = n );
    
    str = @Concatenation( str, " \\ " );
    
    str = @Concatenation( str, ViewString( A[1].J; Locales_name = "J", Locales_number = n, Locales_counter = 1 ) );
    
    j = Length( A );
    
    if (j > 1)
        
        str = @Concatenation( str, " \\ " );
        
        if (j > 2)
            str = @Concatenation( str, ".. \\ " );
        end;
        
        str = @Concatenation( str, ViewString( A[1].J; Locales_name = "J", Locales_number = n, Locales_counter = j ) );
        
    end;
    
    return str;
    
end );

##
@InstallMethod( StringGAP,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  ViewString );

##
@InstallMethod( DisplayString,
        "for an object in a meet-semilattice of formal multiple differences",
        [ IsObjectInMeetSemilatticeOfMultipleDifferences ],
        
  function( A )
    local str, i;
    
    str = DisplayString( A.I );
    
    A = List( A );
    
    for i in (1):(Length( A ))
        str = @Concatenation( str, @Concatenation( "\n\n\\ ", DisplayString( A[i].J ) ) );
    end;
    
    return @Concatenation( str, "\n" );
    
end );
