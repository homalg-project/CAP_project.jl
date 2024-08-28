# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

######################################
##
## Reps, types, stuff.
##
######################################

# backwards compatibility
@BindGlobal( "IsCapCategoryObjectRep", IsCapCategoryObject );

#######################################
##
## Technical implications
##
#######################################

@InstallValueConst( PROPAGATION_LIST_FOR_EQUAL_OBJECTS, [ ] );

##
@InstallGlobalFunction( INSTALL_TODO_LIST_FOR_EQUAL_OBJECTS,
                       
  function( object_1, object_2 )
    local category, i, entry;
    
    category = CapCategory( object_1 );
    
    for i in PROPAGATION_LIST_FOR_EQUAL_OBJECTS
        
        AddToToDoList( ToDoListEntryForEqualAttributes( object_1, i, object_2, i ) );
        
    end;
    
    if (@IsBound( category.PROPAGATION_LIST_FOR_EQUAL_OBJECTS ))
        
        for i in category.PROPAGATION_LIST_FOR_EQUAL_OBJECTS
            
            AddToToDoList( ToDoListEntryForEqualAttributes( object_1, i, object_2, i ) );
            
        end;
        
    end;
    
end );

##
@InstallMethod( AddPropertyToMatchAtIsEqualForObjects,
               [ IsCapCategory, IsString ],
               
  function( category, name )
    
    if (@not @IsBound( category.PROPAGATION_LIST_FOR_EQUAL_OBJECTS ))
        
        category.PROPAGATION_LIST_FOR_EQUAL_OBJECTS = [ ];
        
    end;
    
    if (Position( category.PROPAGATION_LIST_FOR_EQUAL_OBJECTS, name ) == fail)
        
        Add( category.PROPAGATION_LIST_FOR_EQUAL_OBJECTS, name );
        
    end;
    
end );

#######################################
##
## Operations
##
#######################################

@InstallMethod( Add,
               [ IsCapCategory, IsCapCategoryObject ],
               
  function( category, object )
    local filter;
    
    filter = ObjectFilter( category );
    
    if (@not filter( object ))
        
        SetFilterObj( object, filter );
        
    end;
        
    if (HasCapCategory( object ))
        
        if (IsIdenticalObj( CapCategory( object ), category ))
            
            return;
            
        else
            
            Error(
                @Concatenation(
                    "an object that lies in the CAP-category with the name\n",
                    Name( CapCategory( object ) ),
                    "\n",
                    "was tried to be added to a different CAP-category with the name\n",
                    Name( category ), ".\n",
                    "(Please note that it is possible for different CAP-categories to have the same name)"
                )
            );
            
        end;
        
    end;
    
    SetCapCategory( object, category );
    
end );

@InstallMethod( AddObject,
               [ IsCapCategory, IsCapCategoryObject ],
               
  function( category, object )
    
    Add( category, object );
    
end );

@InstallMethod( AddObject,
               [ IsCapCategory, IsAttributeStoringRep ],
               
  function( category, object )
    
    SetFilterObj( object, IsCapCategoryObject );
    
    Add( category, object );
    
end );

##
@InstallGlobalFunction( CreateCapCategoryObjectWithAttributes,
                       
  function( category, additional_arguments_list... )
    local arg_list, obj;
    
    arg_list = @Concatenation(
        [ @rec( ), category.object_type, CapCategory, category ], additional_arguments_list
    );
    
    obj = CallFuncList( ObjectifyWithAttributes, arg_list );
    
    return obj;
    
end );

##
@InstallGlobalFunction( AsCapCategoryObject,
                       
  function( category, object_datum )
    local object_datum_type, obj;
    
    object_datum_type = CAP_INTERNAL_GET_DATA_TYPE_FROM_STRING( "object_datum", category );
    
    if (object_datum_type != fail)
        
        CAP_INTERNAL_ASSERT_VALUE_IS_OF_TYPE_GETTER( object_datum_type, [ "the second argument of `AsCapCategoryObject`" ] )( object_datum );
        
    end;
    
    obj = ObjectifyWithAttributes( @rec( ), category.object_type, CapCategory, category, category.object_attribute, object_datum );
    
    if (@not IsIdenticalObj( category.object_attribute( obj ), object_datum ))
        
        Print( "WARNING: <object_datum> is not identical to `", category.object_attribute_name, "( <obj> )`. You might want to make <object_datum> immutable.\n" );
        
    end;
    
    return obj;
    
end );

###########################
##
## Print
##
###########################

@InstallMethod( StringGAP,
               [ IsCapCategoryObject ],
               
  function( object )
    
    return @Concatenation( "An object in ", Name( CapCategory( object ) ) );
    
end );

# fallback methods for Julia
@InstallMethod( ViewString,
               [ IsCapCategoryObject ],
               
  function ( object )
    
    # do not reuse `StringGAP` because objects might use `StringGAP` as the attribute storing the object datum
    return @Concatenation( "<An object in ", Name( CapCategory( object ) ), ">" );
    
end );

@InstallMethod( DisplayString,
               [ IsCapCategoryObject ],
               
  function ( object )
    
    # do not reuse `StringGAP` because objects might use `StringGAP` as the attribute storing the object datum
    return @Concatenation( "An object in ", Name( CapCategory( object ) ), ".\n" );
    
end );

##
@InstallGlobalFunction( CAP_INTERNAL_CREATE_OBJECT_PRINT,
                       
  function( )
    local print_graph, object_function;
    
    object_function = function( object )
      local string;
        
        string = "object in ";
        
        Append( string, Name( CapCategory( object ) ) );
        
        return string;
        
    end;
    
    print_graph = CreatePrintingGraph( IsCapCategoryObject && HasCapCategory, object_function );
    
    AddRelationToGraph( print_graph,
                        @rec( Source = [ @rec( Conditions = "IsZeroForObjects",
                                              PrintString = "zero",
                                              Adjective = true ) ],
                             Range = [ @rec( Conditions = "IsInjective",
                                             PrintString = "injective",
                                             Adjective = true ),
                                        @rec( Conditions = "IsProjective",
                                             PrintString = "projective",
                                             Adjective = true ) ] ) );
    
    
    InstallPrintFunctionsOutOfPrintingGraph( print_graph, -1 );
    
end );

#= comment for Julia
CAP_INTERNAL_CREATE_OBJECT_PRINT( );
# =#
