# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

InstallTrueMethod( IsDiscreteCategory, IsTerminalCategory );

####################################
#
# Constructor
#
####################################

##
@InstallGlobalFunction( FiniteSkeletalDiscreteCategory,
                       
  @FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
  ],
  function( CAP_NAMED_ARGUMENTS, list_of_gap_objects )
    local name, D;
    
    name = @Concatenation( "FiniteSkeletalDiscreteCategory( ", StringGAP( list_of_gap_objects ), " )" );
    
    D = CreateCapCategoryWithDataTypes( name,
                                         IsFiniteSkeletalDiscreteCategory,
                                         IsObjectInFiniteSkeletalDiscreteCategory,
                                         IsMorphismInFiniteSkeletalDiscreteCategory,
                                         IsCapCategoryTwoCell,
                                         @rec( category = false,
                                              filter = IsObject ),
                                         fail,
                                         fail );
    
    D.compiler_hints = @rec( category_attribute_names = [ "UnderlyingListOfGapObjects" ] );
    
    SetUnderlyingListOfGapObjects( D, list_of_gap_objects );
    
    SetIsFiniteCategory( D, true );
    
    SetIsSkeletalCategory( D, true );
    
    SetIsDiscreteCategory( D, true );
    
    ####################################
    #
    # Primitive operations
    #
    ####################################
    
    ##
    AddObjectConstructor( D,
      function( D, gap_object )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        @Assert( 0, gap_object in UnderlyingListOfGapObjects( D ) );
        
        return CreateCapCategoryObjectWithAttributes( D,
                                                      UnderlyingGapObject, gap_object );
        
    end );
    
    ##
    AddObjectDatum( D,
      function( D, object )
        
        return UnderlyingGapObject( object );
        
    end );
    
    ##
    AddMorphismConstructor( D,
      function( D, source, m, target )
        
        #% CAP_JIT_DROP_NEXT_STATEMENT
        @Assert( 0, IsEqualForObjects( D, source, target ) );
        
        return CreateCapCategoryMorphismWithAttributes( D, source, target );
        
    end );
    
    ##
    AddMorphismDatum( D,
      function( D, morphism )
        
        return fail;
        
    end );
    
    ##
    AddIsWellDefinedForObjects( D,
      function( D, object )
        
        return UnderlyingGapObject( object ) in UnderlyingListOfGapObjects( D );
        
    end );
    
    ##
    AddIsWellDefinedForMorphisms( D,
      function( D, morphism )
        
        return IsEndomorphism( D, morphism ) && IsOne( D, morphism );
        
    end );
    
    AddIsEqualForObjects( D,
      function( D, object_1, object_2 )
        
        return UnderlyingGapObject( object_1 ) == UnderlyingGapObject( object_2 );
        
    end );
    
    ##
    AddIsEqualForMorphisms( D,
      function( D, morphism_1, morphism_2 )
        
        return true;
        
    end );
    
    ##
    AddIdentityMorphism( D,
      function( D, object )
        
        return MorphismConstructor( D, object, fail, object );
        
    end );
    
    ##
    AddPreCompose( D,
      function( D, morphism_1, morphism_2 )
        
        return morphism_1;
        
    end );
    
    ##
    AddSetOfObjectsOfCategory( D,
      function( D )
        
        return List( UnderlyingListOfGapObjects( D ), obj -> ObjectConstructor( D, obj ) );
        
    end );
    
    ##
    AddSetOfMorphismsOfFiniteCategory( D,
      function( D )
        
        return List( SetOfObjectsOfCategory( D ), obj -> IdentityMorphism( D, obj ) );
        
    end );
    
    if (FinalizeCategory)
        
        Finalize( D );
        
    end;
    
    return D;
    
end ) );

#################################
#
# Operators
#
#################################

##
@InstallMethod( /,
               "for a string and a finite skeletal discrete category",
               [ IsStringRep, IsFiniteSkeletalDiscreteCategory ],
               
  function ( string, D )
    local index, objects;
    
    index = IntGAP( string );
    
    objects = SetOfObjectsOfCategory( D );
    
    if (index <= 0 || index > Length( objects ))
        
        # COVERAGE_IGNORE_NEXT_LINE
        Error( "out of bounds access\n" );
        
    end;
    
    return objects[index];
    
end );

#= comment for Julia
@InstallMethod( \.,
               "for a finite skeletal discrete category and a positive integer",
               [ IsFiniteSkeletalDiscreteCategory, IsInt ],
               
  function ( D, index_as_string )
    
    return NameRNam( index_as_string )  / D;
    
end );
# =#

#################################
#
# View & Display
#
#################################

##
@InstallMethod( DisplayString,
        [ IsObjectInFiniteSkeletalDiscreteCategory ],

  function( object )
    
    return @Concatenation( StringGAP( UnderlyingGapObject( object ) ), "\n" );
    
end );

##
@InstallMethod( DisplayString,
        [ IsMorphismInFiniteSkeletalDiscreteCategory ],

  function( morphism )
    
    return @Concatenation( DisplayString( Source( morphism ) ),
                          "|\n| ",
                          StringGAP( morphism ),
                          "\nv\n",
                          DisplayString( Target( morphism ) ) );
    
end );

