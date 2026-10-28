# SPDX-License-Identifier: GPL-2.0-or-later
# LocalesForCAP: Locales, frames, coframes, meet semi-lattices of locally closed subsets, and Boolean algebras of constructible sets
#
# Implementations
#

##
@InstallValueConst( CAP_INTERNAL_METHOD_NAME_LIST_FOR_PREORDERED_SET_OF_CATEGORY,
  [
   # create_func_bool and create_func_object can only deal with operations which
   # not get morphisms as arguments, because they access data which are not set for morphisms
   "IsWellDefinedForObjects",
   "IsHomSetInhabited",
   "TensorUnit",
   "TensorProductOnObjects",
   "InternalHomOnObjects",
   #"InternalHomOnMorphismsWithGivenInternalHoms",
   "InternalCoHomOnObjects",
   #"InternalCoHomOnMorphismsWithGivenInternalCoHoms",
   # P admits the same (co)limits as C,
   # in fact, a weak (co)limit in C becomes a (co)limit in P.
   # However, we must not automatically detect these (co)limits via `universal_type`,
   # because `universal_type` is sometimes set for technical instead of mathematical reasons.
   # Additionally, we must be careful with the restrictions of create_func_bool and create_func_object
   # mentioned above.
   # DirectProduct
   "DirectProduct",
   #"ProjectionInFactorOfDirectProductWithGivenDirectProduct",
   #"UniversalMorphismIntoDirectProductWithGivenDirectProduct",
   # Coproduct
   "Coproduct",
   #"InjectionOfCofactorOfCoproductWithGivenCoproduct",
   #"UniversalMorphismFromCoproductWithGivenCoproduct",
   # DirectSum
   "DirectSum",
   #"ProjectionInFactorOfDirectSumWithGivenDirectSum",
   #"InjectionOfCofactorOfDirectSumWithGivenDirectSum",
   #"UniversalMorphismIntoDirectSumWithGivenDirectSum",
   #"UniversalMorphismFromDirectSumWithGivenDirectSum",
   # TerminalObject
   "TerminalObject",
   #"UniversalMorphismIntoTerminalObjectWithGivenTerminalObject",
   # InitialObject
   "InitialObject",
   #"UniversalMorphismFromInitialObjectWithGivenInitialObject",
   # ZeroObject
   "ZeroObject",
   #"UniversalMorphismIntoZeroObjectWithGivenZeroObject",
   #"UniversalMorphismFromZeroObjectWithGivenZeroObject",
   ] );

##
@InstallMethod( /,
        "for a CAP morphism and a proset or poset of a CAP category",
        [ IsCapCategoryMorphism, IsProsetOrPosetOfCapCategory ],
        
  function( morphism, P )
    
    return MorphismConstructor( P,
                   ObjectConstructor( P, Source( morphism ) ),
                   morphism,
                   ObjectConstructor( P, Target( morphism ) ) );
    
end );

##
@InstallMethod( CreateProsetOrPosetOfCategory,
        "for a CAP category",
        [ IsCapCategory ],
        
  @FunctionWithNamedArguments(
  [
    [ "skeletal", false ],
    [ "stable", false ],
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, C )
    local skeletal_, stable_, category_filter, category_object_filter, category_morphism_filter,
          name, create_func_morphism,
          list_of_operations_to_install, skip, func, pos,
          properties, P, object_constructor, object_datum, morphism_constructor, morphism_datum;
    
    skeletal_ = skeletal;
    
    if (IsIdenticalObj( skeletal_, true ))
        name = "PosetOfCategory";
        category_filter = IsPosetOfCapCategory;
        category_object_filter = IsObjectInPosetOfCategory;
        category_morphism_filter = IsMorphismInPosetOfCategory;
    else
        name = "ProsetOfCategory";
        category_filter = IsProsetOfCapCategory;
        category_object_filter = IsObjectInProsetOfCategory;
        category_morphism_filter = IsMorphismInProsetOfCategory;
    end;
    
    stable_ = stable;
    
    if (IsIdenticalObj( stable_, true ))
        
        if (!(HasIsThinCategory( C ) && IsThinCategory( C )))
            Error( "only compatible (co)closed monoidal structures of (co)cartesian *thin* categories can be stabilized\n" );
        end;
        
        name = @Concatenation( "Stable", name );
        category_object_filter = category_object_filter && IsCellInStableProsetOrPosetOfCategory;
        category_morphism_filter = category_morphism_filter && IsCellInStableProsetOrPosetOfCategory;
    end;
    
    name = @Concatenation( name, "( ", Name( C ), " )" );
    
    ## e.g., IdentityMorphism, PreCompose
    create_func_morphism =
        function( name, P )
            
            return """
                function( input_arguments... )
                    
                    return UniqueMorphism( cat, top_source, top_range );
                    
                end
            """;
            
        end;
    
    list_of_operations_to_install = Intersection(
        CAP_INTERNAL_METHOD_NAME_LIST_FOR_PREORDERED_SET_OF_CATEGORY,
        ListInstalledOperationsOfCategory( C )
    );
    
    skip = [ 
              ];
    
    if (IsIdenticalObj( stable_, true ))
        
        Append( list_of_operations_to_install, [ "IsTerminal" ] ); ## do @not add "IsInitial"
        
        Append( skip,
                [ "IsHomSetInhabited",
                  "InternalHomOnObjects",
                  "InternalCoHomOnObjects",
                  "AreIsomorphicForObjectsIfIsHomSetInhabited",
                  ] );
    end;
    
    for func in skip
        
        pos = Position( list_of_operations_to_install, func );
        if (@not pos == fail)
            Remove( list_of_operations_to_install, pos );
        end;
        
    end;
    
    properties = [ #"IsEnrichedOverCommutativeRegularSemigroup",
                    #"IsAbCategory",
                    "IsAdditiveCategory",
                    "IsPreAbelianCategory",
                    "IsAbelianCategory",
                    "IsMonoidalCategory",
                    "IsStrictMonoidalCategory",
                    "IsBraidedMonoidalCategory",
                    "IsSymmetricMonoidalCategory",
                    "IsClosedMonoidalCategory",
                    "IsCoclosedMonoidalCategory",
                    "IsSymmetricClosedMonoidalCategory",
                    "IsSymmetricCoclosedMonoidalCategory",
                    "IsCartesianCategory",
                    "IsStrictCartesianCategory",
                    "IsCartesianClosedCategory",
                    "IsCocartesianCategory",
                    "IsStrictCocartesianCategory",
                    "IsCocartesianCoclosedCategory",
                    ];
    
    properties = Intersection( ListKnownCategoricalProperties( C ), properties );
    
    properties = Filtered( properties, p -> ValueGlobal( p )( C ) );
    
    Add( properties, "IsThinCategory" );
    
    if (IsIdenticalObj( stable_, true ))
        Add( properties, "IsStableProset" );
        if (CanCompute( C, "InternalHomOnObjects" ))
            Add( properties, "IsCartesianClosedCategory" );
        end;
        if (CanCompute( C, "InternalCoHomOnObjects" ))
            Add( properties, "IsCocartesianCoclosedCategory" );
        end;
    end;
    
    if (IsIdenticalObj( skeletal_, true ))
        
        Add( properties, "IsSkeletalCategory" );
        
        # IsThinCategory and IsSkeletalCategory imply IsPosetCategory
        Add( properties, "IsPosetCategory" );
        
        if (HasIsCartesianCategory( C ) && IsCartesianCategory( C ))
            Add( properties, "IsStrictCartesianCategory" );
        end;
        
        if (HasIsCocartesianCategory( C ) && IsCocartesianCategory( C ))
            Add( properties, "IsStrictCocartesianCategory" );
        end;
        
    else
        
        if (HasIsCartesianCategory( C ) && IsCartesianCategory( C ))
            Add( properties, "IsCartesianCategory" );
        end;
        
        if (HasIsCocartesianCategory( C ) && IsCocartesianCategory( C ))
            Add( properties, "IsCocartesianCategory" );
        end;
        
    end;
    
    ##
    object_constructor = function( cat, underlying_object )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        CAP_INTERNAL_ASSERT_IS_OBJECT_OF_CATEGORY( underlying_object, AmbientCategory( cat ), () -> "the object datum given to the object constructor of <cat>" );
        
        return CreateCapCategoryObjectWithAttributes( cat,
                       UnderlyingGapObject, underlying_object );
        
    end;
    
    object_datum = ( cat, object ) -> UnderlyingGapObject( object );
    
    morphism_constructor = function( cat, source, underlying_morphism, target )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        CAP_INTERNAL_ASSERT_IS_MORPHISM_OF_CATEGORY( underlying_morphism, AmbientCategory( cat ), () -> "the morphism datum given to the morphism constructor of <cat>" );
        
        if (IsEqualForObjects( AmbientCategory( cat ), Source( underlying_morphism ), UnderlyingGapObject( source ) ) == false)
            
            Error( "the source of the morphism datum must be equal to <UnderlyingGapObject( source )>" );
            
        end;
        
        if (IsEqualForObjects( AmbientCategory( cat ), Target( underlying_morphism ), UnderlyingGapObject( target ) ) == false)
            
            Error( "the target of the morphism datum must be equal to <UnderlyingGapObject( target )>" );
            
        end;
        
        return CreateCapCategoryMorphismWithAttributes( cat,
                       source,
                       target,
                       UnderlyingMorphism, underlying_morphism );
        
    end;
    
    morphism_datum = ( cat, morphism ) -> UnderlyingMorphism( morphism );
    
    P = CategoryConstructor( @rec(
                 name = name,
                 category_filter = category_filter,
                 category_object_filter = category_object_filter,
                 category_morphism_filter = category_morphism_filter,
                 properties = properties,
                 object_constructor = object_constructor,
                 object_datum = object_datum,
                 morphism_constructor = morphism_constructor,
                 morphism_datum = morphism_datum,
                 list_of_operations_to_install = list_of_operations_to_install,
                 underlying_category_getter_string = "AmbientCategory",
                 underlying_category = C,
                 underlying_object_getter_string = "ObjectDatum",
                 underlying_morphism_getter_string = "MorphismDatum",
                 top_object_getter_string = "ObjectConstructor",
                 top_morphism_getter_string = "MorphismConstructor",
                 create_func_bool = "default",
                 create_func_object = "default",
                 create_func_morphism = create_func_morphism,
                 ) );
    
    if (HasIsObjectFiniteCategory( C ) && IsObjectFiniteCategory( C ))
        SetIsFiniteCategory( P, true );
    end;
    
    ADD_COMMON_METHODS_FOR_PREORDERED_SETS( P );
    
    P.compiler_hints.category_attribute_names = [
        "AmbientCategory",
    ];
    
    SetAmbientCategory( P, C );
    
    if (@not CanCompute( C, "MorphismsOfExternalHom" ))
        
        ##
        AddUniqueMorphism( P,
          function( P, source, target )
            
            return CreateCapCategoryMorphismWithAttributes( P,
                           source,
                           target );
            
        end );
        
    end;
    
    if (CanCompute( C, "IsWellDefinedForMorphisms" ))
        
        ##
        AddIsWellDefinedForMorphisms( P,
          function( P, mor )
            
            if (HasUnderlyingMorphism( mor ))
                return IsWellDefinedForMorphisms( AmbientCategory( P ), UnderlyingMorphism( mor ) );
            end;
            
            return IsHomSetInhabited( P, Source( mor ), Target( mor ) );
            
        end );
        
    end;
    
    if (@not skeletal_ && CanCompute( C, "IsEqualForObjects" ))
        
        AddIsEqualForObjects( P,
          function( P, S, T )
            
            return IsEqualForObjects( AmbientCategory( P ), UnderlyingGapObject( S ), UnderlyingGapObject( T ) );
            
        end );
        
    end;
    
    if (CanCompute( C, "SetOfObjectsOfCategory" ))
        
        if (skeletal_)
            
            AddSetOfObjectsOfCategory( P,
              function( P )
                
                return DuplicateFreeList( List( SetOfObjects( AmbientCategory( P ) ), o -> ObjectConstructor( P, o ) ) );
                
            end );
            
        else
            
            AddSetOfObjectsOfCategory( P,
              function( P )
                
                return List( SetOfObjects( AmbientCategory( P ) ), o -> ObjectConstructor( P, o ) );
                
            end );
            
        end;
        
    end;
    
    if (CanCompute( C, "MorphismsOfExternalHom" ))
        
        ##
        AddMorphismsOfExternalHom( P,
          function( P, S, T )
            local mors;
            
            mors = MorphismsOfExternalHom( AmbientCategory( P ),
                            UnderlyingGapObject( S ),
                            UnderlyingGapObject( T ) );
            
            ## a trick to avoid an if/else statement (see ?CompilerForCAP:Requirements):
            mors = mors[(1):(1 - 0 ^ Length( mors ))];
            
            return List( mors, mor ->
                         MorphismConstructor( P,
                                 S,
                                 mor,
                                 T ) );
            
        end );
        
    end;
    
    if (@not skeletal_ && CanCompute( C, "SetOfGeneratingMorphismsOfCategory" ))
        
        AddSetOfGeneratingMorphismsOfCategory( P,
          function( P )
            
            return List( SetOfGeneratingMorphisms( AmbientCategory( P ) ), m ->
                         MorphismConstructor( P,
                                 ObjectConstructor( P, Source( m ) ),
                                 m,
                                 ObjectConstructor( P, Target( m ) ) ) );
            
        end );
        
    end;
    
    if (CanCompute( C, "IsWeakTerminal" ))
        
        AddIsTerminal( P,
          function( P, S )
            
            return IsWeakTerminal( AmbientCategory( P ), UnderlyingGapObject( S ) );
            
        end );
        
    end;
    
    if (CanCompute( C, "IsWeakInitial" ))
        
        AddIsInitial( P,
          function( P, S )
            
            return IsWeakInitial( AmbientCategory( P ), UnderlyingGapObject( S ) );
            
        end );
        
    end;
    
    if (IsIdenticalObj( stable_, true ))
        if (CanCompute( C, "InternalHomOnObjects" ))
            
            if (IsIdenticalObj( skeletal_, true ))
                SetIsHeytingAlgebra( P, true );
            else
                SetIsHeytingAlgebroid( P, true );
            end;
            
            ##
            AddInternalHomOnObjects( P,
              function( P, S, T )
                
                return ObjectConstructor( P, StableInternalHom( AmbientCategory( P ), UnderlyingGapObject( S ), UnderlyingGapObject( T ) ) );
                
            end );
            
            ## InternalHomOnMorphismsWithGivenInternalHoms is passed from the ambient Heyting algebra,
            ## its source are and target are not identical but equal to above (altered) internal Hom
            
            ##
            AddExponentialOnObjects( P,
              ( P, S, T ) -> InternalHomOnObjects( P, S, T ) );
            
        end;
        
        if (CanCompute( C, "InternalCoHomOnObjects" ))
            
            if (IsIdenticalObj( skeletal_, true ))
                SetIsCoHeytingAlgebra( P, true );
            else
                SetIsCoHeytingAlgebra( P, true );
            end;
            
            ##
            AddInternalCoHomOnObjects( P,
              function( P, S, T )
                
                return ObjectConstructor( P, StableInternalCoHom( AmbientCategory( P ), UnderlyingGapObject( S ), UnderlyingGapObject( T ) ) );
                
            end );
            
            ## InternalCoHomOnMorphismsWithGivenInternalCoHoms is passed from the ambient co-Heyting algebra,
            ## its source are and target are not identical but equal to above (altered) internal CoHom
            
            ##
            AddCoexponentialOnObjects( P,
              ( P, S, T ) -> InternalCoHomOnObjects( P, S, T ) );
            
        end;
        
    end;
    
    if (FinalizeCategory)
        Finalize( P );
    end;
    
    return P;
    
end ) );

##
@InstallMethod( ProsetOfCategory,
        "for a CAP category",
        [ IsCapCategory ],
        
  CreateProsetOrPosetOfCategory );

##
@InstallMethod( PosetOfCategory,
        "for a CAP category",
        [ IsCapCategory ],
        
  function( C )
    
    return CreateProsetOrPosetOfCategory( C; skeletal = true );
    
end );

##
@InstallMethod( StableProsetOfCategory,
        "for a CAP category",
        [ IsCapCategory ],
        
  function( C )
    
    return ProsetOfCategory( C; stable = true );
    
end );

##
@InstallMethod( StablePosetOfCategory,
        "for a CAP category",
        [ IsCapCategory ],
        
  function( C )
    
    return PosetOfCategory( C; stable = true );
    
end );

##
@InstallMethod( SetOfObjects,
        "for a proset or poset of a CAP category",
        [ IsProsetOrPosetOfCapCategory ],
        
  function( cat )
    
    return SetOfObjectsOfCategory( cat );
    
end );

##
@InstallMethod( SetOfGeneratingMorphisms,
        "for a proset or poset of a CAP category",
        [ IsProsetOrPosetOfCapCategory ],
        
  function( cat )
    
    return SetOfGeneratingMorphismsOfCategory( cat );
    
end );

##
@InstallMethod( /,
        "for a string and a proset or poset of a CAP category",
        [ IsString, IsProsetOrPosetOfCapCategory ],
        
  function( name, P )
    local C, cell;
    
    C = AmbientCategory( P );
    
    cell = C[name];
    
    if (IsCapCategoryObject( cell ))
        
        return ObjectConstructor( P, cell );
        
    elseif (IsCapCategoryMorphism( cell ))
        
        return MorphismConstructor( P,
                       ObjectConstructor( P, Source( cell ) ),
                       cell,
                       ObjectConstructor( P, Target( cell ) ) );
        
    end;
    
    Error( "<cell> is neither an object nor a morphism in the ambient category <C>" );
    
end );

#= comment for Julia
##
INSTALL_DOT_METHOD( IsProsetOrPosetOfCapCategory );
# =#

##
@InstallMethod( DefiningTripleOfUnderlyingQuiver,
        "for a proset or poset of a CAP category",
        [ IsProsetOrPosetOfCapCategory ],
        
  function( P )
    
    return DefiningTripleOfUnderlyingQuiver( AmbientCategory( P ) );
    
end );

##################################
##
## View & Display
##
##################################

##
@InstallMethod( ViewString,
        [ IsObjectInProsetOfCategory ],
        
  function( a )
    
    if (IsCellInStableProsetOrPosetOfCategory( a ))
      
      return @Concatenation( "An object in the stable proset given by: ",
                   StringView( UnderlyingGapObject( a ) ) );
    else
      
      return @Concatenation( "An object in the proset given by: ",
                   StringView( UnderlyingGapObject( a ) ) );
    end;
    
end );

##
@InstallMethod( PrintString,
        [ IsObjectInProsetOfCategory ],
        
  StringView );

##
@InstallMethod( ViewString,
        [ IsMorphismInProsetOfCategory ],
        
  function( mor )
    
    if (@not HasUnderlyingMorphism( mor ))
        TryNextMethod( );
    end;
    
    if (IsCellInStableProsetOrPosetOfCategory( mor ))
      return @Concatenation( "A morphism in the stable proset given by: ",
                   StringView( UnderlyingMorphism( mor ) ) );
    else
      return @Concatenation( "A morphism in the proset given by: ",
                   StringView( UnderlyingMorphism( mor ) ) );
    end;
    
end );

##
@InstallMethod( PrintString,
        [ IsMorphismInProsetOfCategory ],
        
  StringView );

##
@InstallMethod( DisplayString,
        [ IsObjectInProsetOfCategory ],
        
  function( a )
    
    if (IsCellInStableProsetOrPosetOfCategory( a ))
      
      return @Concatenation( StringDisplay( UnderlyingGapObject( a ) ),
                   "\nAn object in the stable proset given by the above data\n" );
    else
      
      return @Concatenation( StringDisplay( UnderlyingGapObject( a ) ),
                   "\nAn object in the proset given by the above data\n" );
    end;
    
end );

##
@InstallMethod( ViewString,
        [ IsObjectInPosetOfCategory ],
        
  function( a )
    
    if (IsCellInStableProsetOrPosetOfCategory( a ))
      
      return @Concatenation( "An object in the stable poset given by: ",
                   StringView( UnderlyingGapObject( a ) ) );
    else
    
      return @Concatenation( "An object in the poset given by: ",
                   StringView( UnderlyingGapObject( a ) ) );
    end;
    
end );

##
@InstallMethod( PrintString,
        [ IsObjectInPosetOfCategory ],
        
  StringView );

##
@InstallMethod( ViewString,
        [ IsMorphismInPosetOfCategory ],
        
  function( mor )
    
    if (@not HasUnderlyingMorphism( mor ))
        TryNextMethod( );
    end;
    
    if (IsCellInStableProsetOrPosetOfCategory( mor ))
      
      return @Concatenation( "A morphism in the stable poset given by: ",
                   StringView( UnderlyingMorphism( mor ) ) );
    else
    
      return @Concatenation( "A morphism in the poset given by: ",
                   StringView( UnderlyingMorphism( mor ) ) );
    end;
    
end );

##
@InstallMethod( PrintString,
        [ IsMorphismInPosetOfCategory ],
        
  StringView );

##
@InstallMethod( DisplayString,
        [ IsObjectInPosetOfCategory ],
        
  function( a )
    
    if (IsCellInStableProsetOrPosetOfCategory( a ))
      
      return @Concatenation( StringDisplay( UnderlyingGapObject( a ) ),
                   "\nAn object in the stable poset given by the above data\n" );
      
    else
      
      return @Concatenation( StringDisplay( UnderlyingGapObject( a ) ),
                   "\nAn object in the poset given by the above data\n" );
      
    end;
    
end );
