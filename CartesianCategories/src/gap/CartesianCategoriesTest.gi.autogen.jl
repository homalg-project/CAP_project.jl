# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian and cocartesian categories and various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



@InstallGlobalFunction( "CartesianCategoriesTest",
    
    function( cat, opposite, a, b, c, alpha, beta )
    
        local verbose,
              
              a_op,
              b_op,
              c_op,
              
              alpha_op,
              beta_op,
              
              a_tensor_b,    alpha_tensor_beta,
              b_tensor_a,    beta_tensor_alpha,
              a_tensor_b_op, alpha_tensor_beta_op,
              b_tensor_a_op, beta_tensor_alpha_op,
              
              left_unitor_a,    left_unitor_inverse_a,    right_unitor_a,    right_unitor_inverse_a,
              left_unitor_b,    left_unitor_inverse_b,    right_unitor_b,    right_unitor_inverse_a_op,
              left_unitor_a_op, left_unitor_inverse_a_op, right_unitor_a_op, right_unitor_inverse_b,
              left_unitor_b_op, left_unitor_inverse_b_op, right_unitor_b_op, right_unitor_inverse_b_op,
              
              associator_left_to_right_abc, associator_left_to_right_abc_op, associator_right_to_left_abc, associator_right_to_left_abc_op,
              associator_left_to_right_cba, associator_left_to_right_cba_op, associator_right_to_left_cba, associator_right_to_left_cba_op;
        
        a_op = Opposite( opposite, a );
        b_op = Opposite( opposite, b );
        c_op = Opposite( opposite, c );
        
        alpha_op = Opposite( opposite, alpha );
        beta_op = Opposite( opposite, beta );
        
        verbose = ValueOption( "verbose" ) == true;
        
        if (CanCompute( cat, "DirectProductOnMorphisms" ))
            
            if (verbose)
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'DirectProductOnMorphisms' ..." );
                
            end;
            
            alpha_tensor_beta = DirectProductOnMorphisms( alpha, beta );
            beta_tensor_alpha = DirectProductOnMorphisms( beta, alpha );
            
            alpha_tensor_beta_op = CoproductOnMorphisms( opposite, alpha_op, beta_op );
            beta_tensor_alpha_op = CoproductOnMorphisms( opposite, beta_op, alpha_op );
            
            @Assert( 0, IsCongruentForMorphisms( alpha_tensor_beta_op, Opposite( opposite, alpha_tensor_beta ) ) );
            @Assert( 0, IsCongruentForMorphisms( beta_tensor_alpha_op, Opposite( opposite, beta_tensor_alpha ) ) );
            
            # Opposite must be self-inverse
            
            @Assert( 0, IsCongruentForMorphisms( alpha_tensor_beta, Opposite( alpha_tensor_beta_op ) ) );
            @Assert( 0, IsCongruentForMorphisms( beta_tensor_alpha, Opposite( beta_tensor_alpha_op ) ) );
            
        end;
        
        if (CanCompute( cat, "CartesianLeftUnitor" ))
            
            if (verbose)
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianLeftUnitor' ..." );
                
            end;
            
            left_unitor_a = CartesianLeftUnitor( a );
            left_unitor_b = CartesianLeftUnitor( b );
            
            left_unitor_inverse_a_op = CocartesianLeftUnitorInverse( opposite, a_op );
            left_unitor_inverse_b_op = CocartesianLeftUnitorInverse( opposite, b_op );
            
            @Assert( 0, IsCongruentForMorphisms( left_unitor_inverse_a_op, Opposite( opposite, left_unitor_a ) ) );
            @Assert( 0, IsCongruentForMorphisms( left_unitor_inverse_b_op, Opposite( opposite, left_unitor_b ) ) );
            
        end;
        
        if (CanCompute( cat, "CartesianRightUnitor" ))
            
            if (verbose)
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianRightUnitor' ..." );
                
            end;
            
            right_unitor_a = CartesianRightUnitor( a );
            right_unitor_b = CartesianRightUnitor( b );
            
            right_unitor_inverse_a_op = CocartesianRightUnitorInverse( opposite, a_op );
            right_unitor_inverse_b_op = CocartesianRightUnitorInverse( opposite, b_op );
            
            @Assert( 0, IsCongruentForMorphisms( right_unitor_inverse_a_op, Opposite( opposite, right_unitor_a ) ) );
            @Assert( 0, IsCongruentForMorphisms( right_unitor_inverse_b_op, Opposite( opposite, right_unitor_b ) ) );
            
        end;
        
        if (CanCompute( cat, "CartesianLeftUnitorInverse" ))
            
            if (verbose)
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianLeftUnitorInverse' ..." );
                
            end;
            
            left_unitor_inverse_a = CartesianLeftUnitorInverse( a );
            left_unitor_inverse_b = CartesianLeftUnitorInverse( b );
            
            left_unitor_a_op = CocartesianLeftUnitor( opposite, a_op );
            left_unitor_b_op = CocartesianLeftUnitor( opposite, b_op );
            
            @Assert( 0, IsCongruentForMorphisms( left_unitor_a_op, Opposite( opposite, left_unitor_inverse_a ) ) );
            @Assert( 0, IsCongruentForMorphisms( left_unitor_b_op, Opposite( opposite, left_unitor_inverse_b ) ) );
            
        end;
        
        if (CanCompute( cat, "CartesianRightUnitorInverse" ))
            
            if (verbose)
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianRightUnitorInverse' ..." );
                
            end;
            
            right_unitor_inverse_a = CartesianRightUnitorInverse( a );
            right_unitor_inverse_b = CartesianRightUnitorInverse( b );
            
            right_unitor_a_op = CocartesianRightUnitor( opposite, a_op );
            right_unitor_b_op = CocartesianRightUnitor( opposite, b_op );
            
            @Assert( 0, IsCongruentForMorphisms( right_unitor_a_op, Opposite( opposite, right_unitor_inverse_a ) ) );
            @Assert( 0, IsCongruentForMorphisms( right_unitor_b_op, Opposite( opposite, right_unitor_inverse_b ) ) );
            
        end;
        
        if (CanCompute( cat, "CartesianAssociatorLeftToRight" ))
            
            if (verbose)
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianAssociatorLeftToRight' ..." );
                
            end;
            
            associator_left_to_right_abc = CartesianAssociatorLeftToRight( a, b, c );
            associator_left_to_right_cba = CartesianAssociatorLeftToRight( c, b, a );
            
            associator_right_to_left_abc_op = CocartesianAssociatorRightToLeft( opposite, a_op, b_op, c_op );
            associator_right_to_left_cba_op = CocartesianAssociatorRightToLeft( opposite, c_op, b_op, a_op );
            
            @Assert( 0, IsCongruentForMorphisms( associator_right_to_left_abc_op, Opposite( opposite, associator_left_to_right_abc ) ) );
            @Assert( 0, IsCongruentForMorphisms( associator_right_to_left_cba_op, Opposite( opposite, associator_left_to_right_cba ) ) );
            
        end;
        
        if (CanCompute( cat, "CartesianAssociatorRightToLeft" ))
            
            if (verbose)
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CartesianAssociatorRightToLeft' ..." );
                
            end;
            
            associator_right_to_left_abc = CartesianAssociatorRightToLeft( a, b, c );
            associator_right_to_left_cba = CartesianAssociatorRightToLeft( c, b, a );
            
            associator_left_to_right_abc_op = CocartesianAssociatorLeftToRight( opposite, a_op, b_op, c_op );
            associator_left_to_right_cba_op = CocartesianAssociatorLeftToRight( opposite, c_op, b_op, a_op );
            
            @Assert( 0, IsCongruentForMorphisms( associator_left_to_right_abc_op, Opposite( opposite, associator_right_to_left_abc ) ) );
            @Assert( 0, IsCongruentForMorphisms( associator_left_to_right_cba_op, Opposite( opposite, associator_right_to_left_cba ) ) );
            
        end;

end );
