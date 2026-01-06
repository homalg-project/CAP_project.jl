# SPDX-License-Identifier: GPL-2.0-or-later
# FinSetsForCAP: The (skeletal) elementary topos of finite sets
#
# Implementations
#

##
@InstallMethod( SkeletalCategoryOfFiniteSetsWithCountingStartingAt1,
               [ IsSkeletalCategoryOfFiniteSets ],
               
 @FunctionWithNamedArguments(
  [ [ "cartesian_monoidal_structure", true ],
    [ "cocartesian_monoidal_structure", false ],
    [ "FinalizeCategory", true ],
    [ "no_precompiled_code", false ],
    [ "overhead", false ],
  ],
  function ( CAP_NAMED_ARGUMENTS, SkeletalFinSets )
    local category_filter, category_object_filter, category_morphism_filter,
          object_datum_type, object_constructor, object_datum,
          morphism_datum_type, morphism_constructor, morphism_datum,
          sFinSets,
          modeling_tower_object_constructor, modeling_tower_object_datum,
          modeling_tower_morphism_constructor, modeling_tower_morphism_datum,
          sFinSets1;
    
    category_filter = IsSkeletalCategoryOfFiniteSetsWithCountingStartingAt1;
    
    category_object_filter = IsObjectInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1;
    
    category_morphism_filter = IsMorphismInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1;
    
    if (no_precompiled_code == true)
        
        ##
        object_datum_type = IsBigInt;
        
        ##
        object_constructor =
          function ( sFinSets1, cardinality )
            
            return CreateCapCategoryObjectWithAttributes( sFinSets1,
                           Cardinality, cardinality );
            
        end;
        
        ##
        object_datum =
          function ( sFinSets1, M )
            
            return Cardinality( M );
            
        end;
        
        ##
        morphism_datum_type = CapJitDataTypeOfListOf( IsBigInt );
        
        ##
        morphism_constructor =
          function ( sFinSets1, source, images, target )
            
            return CreateCapCategoryMorphismWithAttributes( sFinSets1,
                           source,
                           target,
                           AsList, images );
            
        end;
    
        ##
        morphism_datum =
          function ( sFinSets1, phi )
            
            return AsList( phi );
            
        end;
        
        ## building the categorical tower:
        
        ## the skeletal category of finite sets
        sFinSets = SkeletalFinSets;
        
        ## from the raw object data to the object in the modeling category
        modeling_tower_object_constructor =
          function ( sFinSets1, cardinality )
            local sFinSets;
            
            sFinSets = ModelingCategory( sFinSets1 );
            
            return ObjectConstructor( sFinSets, cardinality );
            
        end;
        
        ## from the object in the modeling category to the raw object data
        modeling_tower_object_datum =
          function ( sFinSets1, M )
            local sFinSets;
            
            sFinSets = ModelingCategory( sFinSets1 );
            
            return ObjectDatum( sFinSets, M );
            
        end;
    
        ## from the raw morphism data to the morphism in the modeling category
        modeling_tower_morphism_constructor =
          function ( sFinSets1, source, map, target )
            local sFinSets;
            
            sFinSets = ModelingCategory( sFinSets1 );
            
            return MorphismConstructor( sFinSets,
                           source,
                           List( map, i -> -1 + i ),
                           target );
        
        end;
        
        ## from the morphism in the modeling category to the raw morphism data
        modeling_tower_morphism_datum =
          function ( sFinSets1, mor )
            local sFinSets;
            
            sFinSets = ModelingCategory( sFinSets1 );
            
            return List( MorphismDatum( sFinSets, mor ), i -> 1 + i );
            
        end;
        
        ##
        sFinSets1 =
          ReinterpretationOfCategory( sFinSets,
                  @rec( name = "SkeletalFinSets1",
                       category_filter = category_filter,
                       category_object_filter = category_object_filter,
                       category_morphism_filter = category_morphism_filter,
                       object_datum_type = object_datum_type,
                       morphism_datum_type = morphism_datum_type,
                       object_constructor = object_constructor,
                       object_datum = object_datum,
                       morphism_constructor = morphism_constructor,
                       morphism_datum = morphism_datum,
                       modeling_tower_object_constructor = modeling_tower_object_constructor,
                       modeling_tower_object_datum = modeling_tower_object_datum,
                       modeling_tower_morphism_constructor = modeling_tower_morphism_constructor,
                       modeling_tower_morphism_datum = modeling_tower_morphism_datum,
                       only_primitive_operations = true )
                 ; FinalizeCategory = false );
        
        ##
        AddExactCoverWithGlobalElements( sFinSets1,
          function ( sFinSets1, A )
            local T;
            
            T = TerminalObject( sFinSets1 );
            
            return List( (1):(Cardinality( A )), i -> MorphismConstructor( sFinSets1, T, [ i ], A ) );
            
        end );
        
    else
        
        sFinSets1 =
          CreateCapCategoryWithDataTypes(
                  "SkeletalFinSets1",
                  category_filter,
                  category_object_filter,
                  category_morphism_filter,
                  IsCapCategoryTwoCell,
                  IsBigInt,
                  CapJitDataTypeOfListOf( IsBigInt ),
                  fail
                 ; overhead = overhead );
        
        sFinSets1.category_as_first_argument = true;
        
        sFinSets1.supports_empty_limits = true;
        
        SetIsSkeletalCategory( sFinSets1, true );
        
        SetIsCategoryWithDecidableLifts( sFinSets1, true );
        SetIsCategoryWithDecidableColifts( sFinSets1, true );
        
        SetIsStrictCartesianCategory( sFinSets1, true );
        SetIsStrictCocartesianCategory( sFinSets1, true );
        
        if (cartesian_monoidal_structure && @not cocartesian_monoidal_structure)
            SetIsSymmetricMonoidalCategoryStructureGivenByDirectProduct( sFinSets1, true );
        elseif (cocartesian_monoidal_structure)
            SetIsSymmetricMonoidalCategoryStructureGivenByCoproduct( sFinSets1, true );
        end;
        
        SetIsElementaryTopos( sFinSets1, true );
        
        SetRangeCategoryOfHomomorphismStructure( sFinSets1, sFinSets1 );
        SetIsEquippedWithHomomorphismStructure( sFinSets1, true );
        
        #= comment for Julia
        AddTheoremFileToCategory( sFinSets1,
                Filename( DirectoriesPackageLibrary( "Toposes", "LogicForToposes" ), "PropositionsForToposes.tex" ) );
        # =#
        
        ADD_FUNCTIONS_FOR_SkeletalCategoryOfFiniteSetsWithMorphismsGivenByListsAndCountingStartingAt1_precompiled( sFinSets1 );
        
    end;
    
    # this is a workhorse category -> no logic and caching only via IsIdenticalObj
    CapCategorySwitchLogicOff( sFinSets1 );
    
    if (FinalizeCategory)
        Finalize( sFinSets1 );
    end;
    
    ##
    @Assert( 0, HasRangeCategoryOfHomomorphismStructure( sFinSets1 ) );
    @Assert( 0, IsIdenticalObj( sFinSets1, RangeCategoryOfHomomorphismStructure( sFinSets1 ) ) );
    
    if (IsFinalized( sFinSets1 ))
        
        @Assert( 0, [ ] == MissingOperationsForConstructivenessOfCategory( sFinSets1, "IsEquippedWithHomomorphismStructure" ) );
        
    end;
    
    return sFinSets1;
    
end ) );

##
@InstallMethod( FinSetOp,
        "for a skeletal category of finite sets with counting starting at 1 and a positive integer",
        [ IsSkeletalCategoryOfFiniteSetsWithCountingStartingAt1, IsBigInt ],
        
  function ( cat, n )
    
    return ObjectConstructor( cat, n );
    
end );

##
@InstallMethod( FinSet1,
        "for a positive integer",
        [ IsBigInt ],
        
  function ( n )
    
    return FinSet( SkeletalFinSets1, n );
    
end );

##
@InstallMethod( AsList,
        "for an object in a skeletal category of finite sets with counting starting at 1",
        [ IsObjectInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1 ],
        
  function ( s )
    
    return (1):(Cardinality( s ));
    
end );

##
@InstallMethod( ListOp,
        "for an object in a skeletal category of finite sets with counting starting at 1 and a function",
        [ IsObjectInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1, IsFunction ],
        
  function ( s, f )
    
    return List( AsList( s ), x -> f(x) );
    
end );

## Morphisms

##
@InstallMethod( MapOfFinSets,
        "for two objects in a skeletal category of finite sets with counting starting at 1 and a list",
        [ IsObjectInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1, IsList, IsObjectInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1 ],
        
  function ( s, G, t )
    
    return MapOfFinSets( CapCategory( s ), s, G, t );
    
end );

##
@InstallMethod( MapOfFinSets,
        "for a skeletal category of finite sets with counting starting at 1, two objects therein and a list",
        [ IsSkeletalCategoryOfFiniteSetsWithCountingStartingAt1, IsObjectInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1, IsList, IsObjectInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1 ],
        
  function ( cat, s, G, t )
    
    return MorphismConstructor( cat, s, G, t );
    
end );

##
@InstallMethod( EmbeddingOfFinSets,
        "for two objects in a skeletal category of finite sets with counting starting at 1",
        [ IsObjectInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1, IsObjectInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1 ],
        
  function ( s, t )
    local iota;
    
    iota = MapOfFinSets( s, AsList( s ), t );
    
    @Assert( 3, IsMonomorphism( iota ) );
    SetIsMonomorphism( iota, true );
    
    return iota;
    
end );

##
@InstallMethod( Preimage,
        "for a morphism in a skeletal category of finite sets with counting starting at 1 and a list",
        [ IsMorphismInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1, IsList ],
        
  function ( phi, t )
    
    return 1 + Preimage( AsList( phi ), t );
    
end );

##
@InstallMethod( ImageObject,
        "for a morphism and an object in a skeletal category of finite sets with counting starting at 1",
        [ IsMorphismInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1, IsObjectInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1 ],
        
  function ( phi, s_ )
    
    return ImageObject( PreCompose( EmbeddingOfFinSets( s_, Source( phi ) ), phi ) );
    
end );

##
@InstallMethod( CallFuncList,
        "for a morphism in a skeletal category of finite sets with counting starting at 1 and a list",
        [ IsMorphismInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1, IsList ],
        
  function ( phi, L )
    local x;
    
    x = L[1];
    
    return AsList( phi )[x];
    
end );

##
AddDerivationToCAP( IsHomSetInhabited,
        "IsHomSetInhabited using IsInitial when the range category of the homomorphism structure is the skeletal category of finite sets",
        [ [ HomomorphismStructureOnObjects, 1 ],
          [ IsInitial, 1, RangeCategoryOfHomomorphismStructure ] ],
        
  function ( cat, a, b )
    local range_cat;
    
    range_cat = RangeCategoryOfHomomorphismStructure( cat );
    
    return @not IsInitial( range_cat,
                   HomomorphismStructureOnObjects( cat, a, b ) );
    
end; CategoryGetters = @rec( range_cat = RangeCategoryOfHomomorphismStructure ),
CategoryFilter =
  function ( cat )
    return HasRangeCategoryOfHomomorphismStructure( cat ) &&
           IsSkeletalCategoryOfFiniteSetsWithCountingStartingAt1( RangeCategoryOfHomomorphismStructure( cat ) );
end );

##
@InstallMethod( StringGAP,
        "for an object in a skeletal category of finite sets with counting starting at 1",
        [ IsObjectInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1 ],
        
  function ( s )
    
    return @Concatenation( "FinSet( SkeletalFinSets1, ", StringGAP( Cardinality( s ) ), " )" );
    
end );

##
@InstallMethod( StringGAP,
        "for a morphism in a skeletal category of finite sets with counting starting at 1",
        [ IsMorphismInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1 ],
        
  function ( phi )
    
    return @Concatenation( "MapOfFinSets( SkeletalFinSets1, ", StringGAP( Source( phi ) ), ", ", StringGAP( AsList( phi ) ), ", ", StringGAP( Range( phi ) ), " )" );
    
end );

##
@InstallMethod( ViewString,
        "for an object in a skeletal category of finite sets with counting starting at 1",
        [ IsObjectInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1 ],
        
  function ( s )
    
    return @Concatenation( "|", StringGAP( Cardinality( s ) ), "|" );
    
end );

##
@InstallMethod( ViewString,
        "for a morphism in a skeletal category of finite sets with counting starting at 1",
        [ IsMorphismInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1 ],
        
  function ( phi )
    local arrow;
    
    if (HasIsIsomorphism( phi ) && IsIsomorphism( phi ))
        
        arrow = "⭇";
        
    elseif (HasIsMonomorphism( phi ) && IsMonomorphism( phi ))
        
        arrow = "↪";
        
    elseif (HasIsEpimorphism( phi ) && IsEpimorphism( phi ))
        
        arrow = "↠";
        
    else
        
        arrow = "→";
        
    end;
    
    return @Concatenation( ViewString( Source( phi ) ), " ", arrow, " ", ViewString( Range( phi ) ) );
    
end );

# We want lists of skeletal finite sets and maps to be displayed in a "fancy" way.
# Since `Display` of list redirects to `Print`, we have to make `PrintString` "fancy",
# even if the documentation of `PrintString` suggests that it should not be "fancy".

##
@InstallMethod( PrintString,
        "for an object in a skeletal category of finite sets with counting starting at 1",
        [ IsObjectInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1 ],
        
  function ( s )
    local l, string;
    
    l = Cardinality( s );
    
    if (l == 0)
        return "∅";
    elseif (l == 1)
        return "[ 1 ]";
    elseif (l == 2)
        return "[ 1, 2 ]";
    elseif (l == 3)
        return "[ 1, 2, 3 ]";
    end;
    
    return @Concatenation( "[ 1,..., ", StringGAP( l ), " ]" );
    
end );

##
@InstallMethod( PrintString,
        "for a morphism in a skeletal category of finite sets with counting starting at 1",
        [ IsMorphismInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1 ],
        
  function ( phi )
    
    return @Concatenation(
                   PrintString( Source( phi ) ),
                   " ⱶ", PrintString( AsList( phi ) ), "→ ",
                   PrintString( Range( phi ) ) );
    
end );

##
@InstallMethod( DisplayString,
        "for an object in a skeletal category of finite sets with counting starting at 1",
        [ IsObjectInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1 ],
        
  function ( s )
    
    return @Concatenation( PrintString( s ), "\n" );
    
end );

##
@InstallMethod( DisplayString,
        "for a morphism in a skeletal category of finite sets with counting starting at 1",
        [ IsMorphismInSkeletalCategoryOfFiniteSetsWithCountingStartingAt1 ],
        
  function ( phi )
    
    return @Concatenation( PrintString( phi ), "\n" );
    
end );
