# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

##
@InstallMethod( ReinterpretationOfCategory,
        "for a CAP category and a record of options",
        [ IsCapCategory, IsRecord ],
        
  function( C, options )
    local known_options_with_filters, filter, mandatory_options, category_constructor_options, list_of_operations_to_install, D, operations_of_homomorphism_structure, HC, object_function, morphism_function, object_function_inverse, morphism_function_inverse, option_name, option;
    
    ## check given options
    known_options_with_filters = @rec(
        name = IsString,
        category_filter = IsFilter,
        category_object_filter = IsFilter,
        category_morphism_filter = IsFilter,
        object_datum_type = IsObject, # IsFilter || IsRecord
        morphism_datum_type = IsObject, # IsFilter || IsRecord
        object_constructor = IsFunction,
        object_datum = IsFunction,
        morphism_constructor = IsFunction,
        morphism_datum = IsFunction,
        modeling_tower_object_constructor = IsFunction,
        modeling_tower_object_datum = IsFunction,
        modeling_tower_morphism_constructor = IsFunction,
        modeling_tower_morphism_datum = IsFunction,
        only_primitive_operations = IsBool,
    );
    
    for option_name in RecNames( options )
        
        if (@IsBound( known_options_with_filters[option_name] ))
            
            filter = known_options_with_filters[option_name];
            
            if (@not filter( options[option_name] ))
                
                # COVERAGE_IGNORE_NEXT_LINE
                Error( "The value of the option `", option_name, "` must lie in the filter ", filter );
                
            end;
            
        else
            
            # COVERAGE_IGNORE_NEXT_LINE
            Error( "The following option is not known to `ReinterpretationOfCategory`: ", option_name );
            
        end;
        
    end;
    
    mandatory_options = [
        "name",
        "category_filter",
        "category_object_filter",
        "category_morphism_filter",
        "object_constructor",
        "object_datum",
        "morphism_constructor",
        "morphism_datum",
        "modeling_tower_object_constructor",
        "modeling_tower_object_datum",
        "modeling_tower_morphism_constructor",
        "modeling_tower_morphism_datum",
    ];
    
    for option in mandatory_options
        
        if (@not @IsBound( options[option] ))
            
            Error( "mandatory option ", option, " is not set" );
            
        end;
        
    end;
    
    # the methods for ModelingObject et al. will be installed later once we have a category instance filter
    category_constructor_options = @rec(
        underlying_category_getter_string = "ModelingCategory",
        underlying_object_getter_string = "ModelingObject",
        underlying_morphism_getter_string = "ModelingMorphism",
        top_object_getter_string = "ReinterpretationOfObject",
        top_morphism_getter_string = "ReinterpretationOfMorphism",
        generic_output_source_getter_string = "ReinterpretationOfObject( cat, Source( underlying_result ) )",
        generic_output_range_getter_string = "ReinterpretationOfObject( cat, Range( underlying_result ) )",
        create_func_bool = "default",
        create_func_object = "default",
        create_func_object_or_fail = "default",
        create_func_morphism = "default",
        create_func_morphism_or_fail = "default",
        create_func_list_of_objects = "default",
        name = options.name,
        category_filter = options.category_filter,
        category_object_filter = options.category_object_filter,
        category_morphism_filter = options.category_morphism_filter,
        object_constructor = options.object_constructor,
        object_datum = options.object_datum,
        morphism_constructor = options.morphism_constructor,
        morphism_datum = options.morphism_datum,
        is_computable = C.is_computable,
    );
    
    if (@IsBound( options.object_datum_type ))
        
        category_constructor_options.object_datum_type = options.object_datum_type;
        
    end;
    
    if (@IsBound( options.morphism_datum_type ))
        
        category_constructor_options.morphism_datum_type = options.morphism_datum_type;
        
    end;
    
    if (HasCommutativeRingOfLinearCategory( C ))
        
        category_constructor_options.commutative_ring_of_linear_category = CommutativeRingOfLinearCategory( C );
        
    end;
    
    category_constructor_options.properties = ListKnownCategoricalProperties( C );
    
    if (@IsBound( options.only_primitive_operations ) && options.only_primitive_operations)
        
        list_of_operations_to_install = ListPrimitivelyInstalledOperationsOfCategory( C );
        
    else
        
        list_of_operations_to_install = ListInstalledOperationsOfCategory( C );
        
    end;
    
    category_constructor_options.list_of_operations_to_install = list_of_operations_to_install;
    
    if (@IsBound( C.supports_empty_limits ))
        
        category_constructor_options.supports_empty_limits = C.supports_empty_limits;
        
    end;
    
    D = CategoryConstructor( category_constructor_options );
    
    D.compiler_hints.category_attribute_names = [
        "ModelingCategory",
    ];
    
    SetModelingCategory( D, C );
    
    # install methods
    InstallMethodForCompilerForCAP( ModelingTowerObjectConstructor,
        [ CategoryFilter( D ), IsObject ],
        options.modeling_tower_object_constructor
    );
    
    InstallMethodForCompilerForCAP( ModelingTowerObjectDatum,
        [ CategoryFilter( D ), ObjectFilter( C ) ],
        options.modeling_tower_object_datum
    );
    
    InstallMethodForCompilerForCAP( ModelingTowerMorphismConstructor,
        [ CategoryFilter( D ), ObjectFilter( C ), IsObject, ObjectFilter( C ) ],
        options.modeling_tower_morphism_constructor
    );
    
    InstallMethodForCompilerForCAP( ModelingTowerMorphismDatum,
        [ CategoryFilter( D ), MorphismFilter( C ) ],
        options.modeling_tower_morphism_datum
    );
    
    
    InstallMethodForCompilerForCAP( ModelingObject,
        [ CategoryFilter( D ), ObjectFilter( D ) ],
        
      function ( cat, obj )
        
        return ModelingTowerObjectConstructor( cat, ObjectDatum( cat, obj ) );
        
    end );
    
    InstallMethodForCompilerForCAP( ReinterpretationOfObject,
        [ CategoryFilter( D ), ObjectFilter( C ) ],
        
      function ( cat, obj )
        
        return ObjectConstructor( cat, ModelingTowerObjectDatum( cat, obj ) );
        
    end );
    
    InstallMethodForCompilerForCAP( ModelingMorphism,
        [ CategoryFilter( D ), MorphismFilter( D ) ],
        
      function ( cat, mor )
        
        return ModelingTowerMorphismConstructor( cat, ModelingObject( cat, Source( mor ) ), MorphismDatum( cat, mor ), ModelingObject( cat, Range( mor ) ) );
        
    end );
    
    InstallMethodForCompilerForCAP( ReinterpretationOfMorphism,
        [ CategoryFilter( D ), ObjectFilter( D ), MorphismFilter( C ), ObjectFilter( D ) ],
        
      function ( cat, source, mor, range )
        
        return MorphismConstructor( cat, source, ModelingTowerMorphismDatum( cat, mor ), range );
        
    end );
    
    if ("MorphismsOfExternalHom" in list_of_operations_to_install)
        
        AddMorphismsOfExternalHom( D,
          function( cat, a, b )
            
            return List( MorphismsOfExternalHom( ModelingCategory( cat ), ModelingObject( cat, a ), ModelingObject( cat, b ) ),
                         mor -> ReinterpretationOfMorphism( cat, a, mor, b ) );
            
        end );
        
    end;
    
    if ("BasisOfExternalHom" in list_of_operations_to_install)
        
        AddBasisOfExternalHom( D,
          function( cat, a, b )
            
            return List( BasisOfExternalHom( ModelingCategory( cat ), ModelingObject( cat, a ), ModelingObject( cat, b ) ),
                         mor -> ReinterpretationOfMorphism( cat, a, mor, b ) );
            
        end );
        
    end;
    
    if ("CoefficientsOfMorphism" in list_of_operations_to_install)
        
        AddCoefficientsOfMorphism( D,
          function( cat, alpha )
            
            return CoefficientsOfMorphism( ModelingCategory( cat ), ModelingMorphism( cat, alpha ) );
            
        end );
        
    end;
    
    operations_of_homomorphism_structure = [
        "DistinguishedObjectOfHomomorphismStructure",
        "HomomorphismStructureOnObjects",
        "HomomorphismStructureOnMorphisms",
        "HomomorphismStructureOnMorphismsWithGivenObjects",
        "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
        "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects",
        "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
    ];
    
    if (HasRangeCategoryOfHomomorphismStructure( C ) && @not IsEmpty( Intersection( list_of_operations_to_install, operations_of_homomorphism_structure ) ))
        
        HC = RangeCategoryOfHomomorphismStructure( C );
        
        if (IsIdenticalObj( C, HC ))
            
            # The range of the homomorphism structure of C is C itself,
            # so the range of the homomorphism structure of D should be D itself.
            # This prevents infinite recursions.
            HC = D;
            
            # prepare for ExtendRangeOfHomomorphismStructureByFullEmbedding
            object_function = function ( C, HC, object )
                #% CAP_JIT_RESOLVE_FUNCTION
                
                return ReinterpretationOfObject( HC, object );
                
            end;
            
            morphism_function = function ( C, HC, source, morphism, range )
                #% CAP_JIT_RESOLVE_FUNCTION
                
                return ReinterpretationOfMorphism( HC,
                    source,
                    morphism,
                    range
                );
                
            end;
            
            object_function_inverse = function ( C, HC, object )
                #% CAP_JIT_RESOLVE_FUNCTION
                
                return ModelingObject( HC, object );
                
            end;
            
            morphism_function_inverse = function ( C, HC, source, morphism, range )
                #% CAP_JIT_RESOLVE_FUNCTION
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                @Assert( 0, IsEqualForObjects( source, Source( ModelingMorphism( HC, morphism ) ) ) );
                
                #% CAP_JIT_DROP_NEXT_STATEMENT
                @Assert( 0, IsEqualForObjects( source, Source( ModelingMorphism( HC, morphism ) ) ) );
                
                return ModelingMorphism( HC, morphism );
                
            end;
            
            ExtendRangeOfHomomorphismStructureByFullEmbedding( C, HC, object_function, morphism_function, object_function_inverse, morphism_function_inverse );
            
        else
            
            ExtendRangeOfHomomorphismStructureByIdentityAsFullEmbedding( C );
            
        end;
        
        SetRangeCategoryOfHomomorphismStructure( D, HC );
        SetIsEquippedWithHomomorphismStructure( D, true );
        
        if ("DistinguishedObjectOfHomomorphismStructure" in list_of_operations_to_install)
            AddDistinguishedObjectOfHomomorphismStructure( D,
              function( cat )
                
                return DistinguishedObjectOfHomomorphismStructureExtendedByFullEmbedding( ModelingCategory( cat ), HC );
                
            end );
        end;
        
        if ("HomomorphismStructureOnObjects" in list_of_operations_to_install)
            AddHomomorphismStructureOnObjects( D,
              function( cat, a, b )
                
                return HomomorphismStructureOnObjectsExtendedByFullEmbedding( ModelingCategory( cat ), HC, ModelingObject( cat, a ), ModelingObject( cat, b ) );
                
            end );
        end;
        
        if ("HomomorphismStructureOnMorphisms" in list_of_operations_to_install)
            AddHomomorphismStructureOnMorphisms( D,
              function( cat, alpha, beta )
                
                return HomomorphismStructureOnMorphismsExtendedByFullEmbedding( ModelingCategory( cat ), HC, ModelingMorphism( cat, alpha ), ModelingMorphism( cat, beta ) );
                
            end );
        end;
        
        if ("HomomorphismStructureOnMorphismsWithGivenObjects" in list_of_operations_to_install)
            AddHomomorphismStructureOnMorphismsWithGivenObjects( D,
              function( cat, s, alpha, beta, r )
                
                return HomomorphismStructureOnMorphismsWithGivenObjectsExtendedByFullEmbedding( ModelingCategory( cat ), HC, s, ModelingMorphism( cat, alpha ), ModelingMorphism( cat, beta ), r );
                
            end );
        end;
        
        if ("InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure" in list_of_operations_to_install)
            AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure( D,
              function( cat, alpha )
                
                return InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureExtendedByFullEmbedding( ModelingCategory( cat ), HC, ModelingMorphism( cat, alpha ) );
                
            end );
        end;
        
        if ("InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects" in list_of_operations_to_install)
            AddInterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects( D,
              function( cat, s, alpha, r )
                
                return InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjectsExtendedByFullEmbedding( ModelingCategory( cat ), HC, s, ModelingMorphism( cat, alpha ), r );
                
            end );
        end;
        
        if ("InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism" in list_of_operations_to_install)
            AddInterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism( D,
              function( cat, a, b, iota )
                
                return ReinterpretationOfMorphism( cat, a, InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphismExtendedByFullEmbedding( ModelingCategory( cat ), HC, ModelingObject( cat, a ), ModelingObject( cat, b ), iota ), b );
                
            end );
        end;
        
    end;
    
    Finalize( D );
    
    return D;
    
end );

##
@InstallMethod( ReinterpretationFunctor,
        "for a reinterpretaton of a category",
        [ IsCapCategory ],
        
  function( R )
    local C, name, F;
    
    C = ModelingCategory( R );
    
    name = @Concatenation( "Reinterpretation functor from ", Name( C ), " to its reinterpretation ", Name( R ) );
    
    F = CapFunctor( name, C, R );
    
    AddObjectFunction( F,
      function ( objC )
        
        return ReinterpretationOfObject( R, objC );
        
    end );
    
    AddMorphismFunction( F,
      function ( s, morC, r )
        
        return ReinterpretationOfMorphism( R, s, morC, r );
        
    end );
    
    return F;
    
end );

##
@InstallMethod( ModelingObject,
        "for a CAP object",
        [ IsCapCategoryObject ],
        
  function( obj )
    
    Display( "WARNING: calling `ModelingObject` without the category as first argument should only be done for debugging purposes." );
    
    return ModelingObject( CapCategory( obj ), obj );
    
end );

##
@InstallMethod( ModelingMorphism,
        "for a CAP morphism",
        [ IsCapCategoryMorphism ],
        
  function( mor )
    
    Display( "WARNING: calling `ModelingMorphism` without the category as first argument should only be done for debugging purposes." );
    
    return ModelingMorphism( CapCategory( mor ), mor );
    
end );
