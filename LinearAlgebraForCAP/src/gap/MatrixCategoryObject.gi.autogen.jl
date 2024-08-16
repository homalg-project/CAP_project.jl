# SPDX-License-Identifier: GPL-2.0-or-later
# LinearAlgebraForCAP: Category of Matrices over a Field for CAP
#
# Implementations
#

####################################
##
## Constructors
##
####################################

##
@InstallMethod( VectorSpaceObject,
               [ IsInt, IsFieldForHomalg ],
                
  function( dimension, homalg_field )
    
    if (@not @IsBound( homalg_field.MatrixCategory ))
        
        homalg_field.MatrixCategory = MatrixCategory( homalg_field );
        
    end;
    
    return MatrixCategoryObject( homalg_field.MatrixCategory, dimension );
    
end );

##
@InstallMethod( MatrixCategoryObjectOp,
                                [ IsMatrixCategory, IsInt ],
                                
  function( cat, dimension )
    local category;
    
    if (!(IsInt( dimension )) || dimension < 0)
        
        Error( "the object datum must be a non-negative integer" );
        
    end;
    
    return AsCapCategoryObject( cat, dimension );
    
end );

##
# backwards compatibility
@InstallMethod( MatrixCategoryObject,
                    [ IsFieldForHomalg, IsInt ],
                    
  function( homalg_field, dimension )
    
    return MatrixCategoryObject( MatrixCategory( homalg_field ), dimension );
    
end );

####################################
##
## Attributes
##
####################################

##
@InstallMethod( UnderlyingFieldForHomalg,
               [ IsVectorSpaceObject ],
               
  function( object )
    
    return UnderlyingRing( CapCategory( object ) );
    
end );

##
@InstallMethod( Dimension,
               [ IsVectorSpaceObject ],
               
  function( object )
    
    return AsInteger( object );
    
end );

####################################
##
## View
##
####################################

##
@InstallMethod( StringGAP,
              [ IsVectorSpaceObject ],
              
  function( vector_space_object )
    
    return @Concatenation( "A vector space object over ",
                          RingName( UnderlyingRing( CapCategory( vector_space_object ) ) ),
                          " of dimension ", StringGAP( AsInteger( vector_space_object ) ) );
    
end );

##
@InstallMethod( ViewString,
               [ IsVectorSpaceObject ],

  function( vector_space_object )

    return @Concatenation( "<", StringGAP( vector_space_object ), ">" );

end );

##
@InstallMethod( DisplayString,
               [ IsVectorSpaceObject ],
               
  function( vector_space_object )
    
    return @Concatenation( StringGAP( vector_space_object ), "\n" );
    
end );

##
@InstallMethod( LaTeXOutput,
               [ IsVectorSpaceObject ],
               
  function( vector_space_object )
    
    return @Concatenation( LaTeXOutput( UnderlyingRing( CapCategory( vector_space_object ) ) ), "^[1 \\times ", StringGAP( AsInteger( vector_space_object ) ), "]" );
    
end );
