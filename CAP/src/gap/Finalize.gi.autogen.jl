# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#
@InstallMethod( Finalize,
               [ IsCapCategory ],
 
 @FunctionWithNamedArguments(
  [
    [ "FinalizeCategory", true ],
    [ "disable_derivations", false ],
  ],
  function( CAP_NAMED_ARGUMENTS, category )
    local installed_operations_of_homomorphism_structure, properties_with_logic, original_REORDER_METHODS_SUSPENSION_LEVEL, property, property_name;
    
    if (IsFinalized( category ))
        
        return true;
        
    end;
    
    if (@not FinalizeCategory)
        
        return false;
        
    end;
    
    if (@not disable_derivations)
        
        InstallDerivations( category );
        
    end;
    
    installed_operations_of_homomorphism_structure =
      Intersection( ListInstalledOperationsOfCategory( category ),
              [ "DistinguishedObjectOfHomomorphismStructure",
                "HomomorphismStructureOnObjects",
                "HomomorphismStructureOnMorphisms",
                "HomomorphismStructureOnMorphismsWithGivenObjects",
                "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructure",
                "InterpretMorphismAsMorphismFromDistinguishedObjectToHomomorphismStructureWithGivenObjects",
                "InterpretMorphismFromDistinguishedObjectToHomomorphismStructureAsMorphism",
                ] );
    
    if (@not IsEmpty( installed_operations_of_homomorphism_structure ) &&
       @not HasRangeCategoryOfHomomorphismStructure( category ))
        
        Error( "<category> has operations related to the homomorphism structure but no range category is set. This is not supported." );
        
    end;
    
    SetIsFinalized( category, true );
    
    if (category.overhead)
        
        properties_with_logic = RecNames( category.logical_implication_files.Propositions );
        
        # INSTALL_PREDICATE_IMPLICATION (part of INSTALL_LOGICAL_IMPLICATIONS_HELPER) calls `InstallTrueMethod` many times, so in principle methods have to be reordered.
        # However, all implications are of the form `property and Object/MorphismFilter => property2 and Object/MorphismFilter`.
        # CAP does not install methods with filters of the form `property and Object/MorphismFilter` and we assume that neither does the user.
        # Hence, we can skip the method reordering completely.
        
        #= comment for Julia
        original_REORDER_METHODS_SUSPENSION_LEVEL = REORDER_METHODS_SUSPENSION_LEVEL;
        
        REORDER_METHODS_SUSPENSION_LEVEL = 1;
        # =#
        
        for property_name in properties_with_logic
            
            property = ValueGlobal( property_name );
            
            if (Tester( property )( category ) && property( category ))
                
                INSTALL_LOGICAL_IMPLICATIONS_HELPER( category, property_name );
                
            end;
            
        end;
        
        #= comment for Julia
        REORDER_METHODS_SUSPENSION_LEVEL = original_REORDER_METHODS_SUSPENSION_LEVEL;
        # =#
        
    end;
    
    if (category.is_computable && @not CanCompute( category, "IsCongruentForMorphisms" ))
        
        Print( "WARNING: The category with name \"", Name( category ), "\" is marked as being computable but has no implementation of `IsCongruentForMorphisms`.\n" );
        
    end;
    
    if (@not category.is_computable && CanCompute( category, "IsCongruentForMorphisms" ))
        
        Print( "WARNING: The category with name \"", Name( category ), "\" is marked as being not computable but has an implementation of `IsCongruentForMorphisms`.\n" );
        
    end;
    
    return true;
    
end ) );
