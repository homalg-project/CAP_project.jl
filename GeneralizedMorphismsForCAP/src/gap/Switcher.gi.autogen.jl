# SPDX-License-Identifier: GPL-2.0-or-later
# GeneralizedMorphismsForCAP: Implementations of generalized morphisms for the CAP project
#
# Implementations
#

@BindGlobal( "CAP_INTERNAL_FIND_CORRECT_GENERALIZED_CATEGORY_TYPE",
  
  function( category )
    local generalized_morphism_standard;

    if (@IsBound( category.generalized_morphism_standard ))

        generalized_morphism_standard = category.generalized_morphism_standard;

        if (IsString( generalized_morphism_standard ))

            return generalized_morphism_standard;

        end;

    end;

    if (@IsBound( CAP_INTERNAL.generalized_morphism_standard ))

        generalized_morphism_standard = CAP_INTERNAL.generalized_morphism_standard;

        if (IsString( generalized_morphism_standard ))

            return generalized_morphism_standard;

        end;

    end;

    return "threearrow";

end );

@InstallGlobalFunction( SwitchGeneralizedMorphismStandard,
  
  function( arg... )
    local string, category;
    
    if (Length( arg ) == 1 && IsString( arg[ 1 ] ))
        
        category = CAP_INTERNAL;
        string = arg[ 1 ];
        
    elseif (Length( arg ) == 2 && IsString( arg[ 1 ] ) && IsCapCategory( arg[ 2 ] ))
        
        category = arg[ 2 ];
        string = arg[ 1 ];
        
    elseif (Length( arg ) == 2 && IsString( arg[ 2 ] ) && IsCapCategory( arg[ 1 ] ))
        
        category = arg[ 1 ];
        string = arg[ 2 ];
        
    else
        
        Error( "input must be a string or a category and a string" );
        return;
    end;
    
    if (@not string in [ "threearrow", "cospan", "span" ])
        
        Error( "string must be threearrow, cospan, or span" );
        return;
        
    end;
    
    category.generalized_morphism_standard = string;
    
end );

SwitchGeneralizedMorphismStandard( "threearrow" );

@InstallValueConst( CAP_INTERNAL_GENERALIZED_MORPHISM_TRANSLATION_LIST, [
      [ "GeneralizedMorphismObject", "GeneralizedMorphismByThreeArrowsObject", "GeneralizedMorphismByCospansObject", "GeneralizedMorphismBySpansObject", [ IsCapCategoryObject ] ],
      [ "AsGeneralizedMorphism", "AsGeneralizedMorphismByThreeArrows", "AsGeneralizedMorphismByCospan", "AsGeneralizedMorphismBySpan", [ IsCapCategoryMorphism ] ],
      [ "GeneralizedMorphism", "GeneralizedMorphismByThreeArrows", "GeneralizedMorphismByCospan", "GeneralizedMorphismBySpan", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] ],
      [ "GeneralizedMorphism", "GeneralizedMorphismByThreeArrows", "GeneralizedMorphismByCospan", "GeneralizedMorphismBySpan", [ IsCapCategoryMorphism, IsCapCategoryMorphism, IsCapCategoryMorphism ] ],
      [ "GeneralizedInverse", "GeneralizedInverseByThreeArrows", "GeneralizedInverseByCospan", "GeneralizedInverseBySpan", [ IsCapCategoryMorphism ] ],
      [ "GeneralizedMorphismFromFactorToSubobject", "GeneralizedMorphismFromFactorToSubobjectByThreeArrows", "GeneralizedMorphismFromFactorToSubobjectByCospan", "GeneralizedMorphismFromFactorToSubobjectBySpan", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] ],
      [ "IdempotentDefinedBySubobject", "IdempotentDefinedBySubobjectByThreeArrows", "IdempotentDefinedBySubobjectByCospan", "IdempotentDefinedBySubobjectBySpan", [ IsCapCategoryMorphism ] ],
      [ "IdempotentDefinedByFactorobject", "IdempotentDefinedByFactorobjectByThreeArrows", "IdempotentDefinedByFactorobjectByCospan", "IdempotentDefinedByFactorobjectBySpan", [ IsCapCategoryMorphism ] ],
      [ "GeneralizedMorphismWithRangeAid", "GeneralizedMorphismByThreeArrowsWithRangeAid", "GeneralizedMorphismByCospan", "GeneralizedMorphismBySpanWithRangeAid", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] ],
      [ "GeneralizedMorphismWithSourceAid", "GeneralizedMorphismByThreeArrowsWithSourceAid", "GeneralizedMorphismByCospanWithSourceAid", "GeneralizedMorphismBySpan", [ IsCapCategoryMorphism, IsCapCategoryMorphism ] ] ] );

@InstallMethod( GeneralizedMorphismCategory,
               [ IsCapCategory ],
               
  function( category )
    local generalized_type;
    
    generalized_type = CAP_INTERNAL_FIND_CORRECT_GENERALIZED_CATEGORY_TYPE( category );
    
    if (generalized_type == "threearrow")
        
        return GeneralizedMorphismCategoryByThreeArrows( category );
        
    elseif (generalized_type == "cospan")
        
        return GeneralizedMorphismCategoryByCospans( category );
        
    elseif (generalized_type == "span")
        
        return GeneralizedMorphismCategoryBySpans( category );
        
    else
        
        Error( "generalized morphism type unrecognized" );
        
    end;
    
end );

#= comment for Julia
@InstallMethod( SerreQuotientCategory,
               [ IsCapCategory, IsFunction ],
               
  function( category, func )
    local generalized_type;
    
    generalized_type = CAP_INTERNAL_FIND_CORRECT_GENERALIZED_CATEGORY_TYPE( category );
    
    if (generalized_type == "threearrow")
        
        return SerreQuotientCategoryByThreeArrows( category, func );
        
    elseif (generalized_type == "cospan")
        
        return SerreQuotientCategoryByCospans( category, func );
        
    elseif (generalized_type == "span")
        
        return SerreQuotientCategoryBySpans( category, func );
        
    else
        
        Error( "generalized morphism type unrecognized" );
        
    end;
    
end );
# =#

@BindGlobal( "CAP_INTERNAL_INSTALL_METHODS_FOR_GENERALIZED_MORPHISM_SWITCHER",
    
    function( )
    local method_for_switcher, current_method;
    
    method_for_switcher = function( three_arrow, cospan, span )
        
        return function( arg... )
            local generalized_type;
            
            generalized_type = CAP_INTERNAL_FIND_CORRECT_GENERALIZED_CATEGORY_TYPE( CapCategory( arg[ 1 ] ) );
            
            if (generalized_type == "threearrow")
                
                return CallFuncList( three_arrow, arg );
                
            elseif (generalized_type == "cospan")
                
                return CallFuncList( cospan, arg );
                
            elseif (generalized_type == "span")
                
                return CallFuncList( span, arg );
                
            else
                
                Error( "generalized morphism type unrecognized" );
                
            end;
            
        end;
        
    end;
    
    for current_method in CAP_INTERNAL_GENERALIZED_MORPHISM_TRANSLATION_LIST
        
        InstallMethod( ValueGlobal( current_method[ 1 ] ),
                       current_method[ 5 ],
                       method_for_switcher( ValueGlobal( current_method[ 2 ] ), ValueGlobal( current_method[ 3 ] ), ValueGlobal( current_method[ 4 ] ) ) );
                       
    end;
    
end );

CAP_INTERNAL_INSTALL_METHODS_FOR_GENERALIZED_MORPHISM_SWITCHER();

#= comment for Julia
@InstallGlobalFunction( "SwitchGeneralizedMorphismStandardHARDCODE",
  
  function( type )
    local generalized_morphism_translation_list, i;
    
    if (IsString( type ))
        if (LowercaseString( type ) == "threearrow")
            type = 2;
        elseif (LowercaseString( type ) == "cospan")
            type = 3;
        elseif (LowercaseString( type ) == "span")
            type = 4;
        end;
    end;
    
    if (!(IsInt( type )) || @not type in [ 2, 3, 4 ])
        Error( "input must be threearrow, cospan, or span" );
    end;
    
    for i in CAP_INTERNAL_GENERALIZED_MORPHISM_TRANSLATION_LIST
        
        if (IsBoundGlobal( i[ 1 ] ))
            MakeReadWriteGlobal( i[ 1 ] );
            UnbindGlobal( i[ 1 ] );
        end;
        
        if (@IsBound( i[ type ] ))
            @BindGlobal( i[ 1 ], ValueGlobal( i[ type ] ) );
        end;
        
    end;
    
end );
# =#
