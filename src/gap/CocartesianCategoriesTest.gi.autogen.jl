# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian && cocartesian categories && various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



@InstallGlobalFunction( "CocartesianCategoriesTest",
    
    function( cat, a, b, c, alpha, beta )
    
        local opposite, verbose,
              
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

        opposite = Opposite( cat );
        
        a_op = Opposite( a );
        b_op = Opposite( b );
        c_op = Opposite( c );
        
        alpha_op = Opposite( alpha );
        beta_op = Opposite( beta );
        
        verbose = ValueOption( "verbose" ) == true;
        
        if CanCompute( cat, "CoproductOnMorphisms" ) then 
            
            if verbose
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CoproductOnMorphisms' ..." );
                
            end;
            
            alpha_tensor_beta = CoproductOnMorphisms( alpha, beta );
            beta_tensor_alpha = CoproductOnMorphisms( beta, alpha );
            
            alpha_tensor_beta_op = DirectProductOnMorphisms( opposite, alpha_op, beta_op );
            beta_tensor_alpha_op = DirectProductOnMorphisms( opposite, beta_op, alpha_op );
            
            @Assert( 0, IsCongruentForMorphisms( alpha_tensor_beta_op, Opposite( alpha_tensor_beta ) ) );
            @Assert( 0, IsCongruentForMorphisms( beta_tensor_alpha_op, Opposite( beta_tensor_alpha ) ) );
            
            # Opposite must be self-inverse
            
            @Assert( 0, IsCongruentForMorphisms( alpha_tensor_beta, Opposite( alpha_tensor_beta_op ) ) );
            @Assert( 0, IsCongruentForMorphisms( beta_tensor_alpha, Opposite( beta_tensor_alpha_op ) ) );
            
        end;
        
        if CanCompute( cat, "CocartesianLeftUnitor" )
            
            if verbose
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianLeftUnitor' ..." );
                
            end;
            
            left_unitor_a = CocartesianLeftUnitor( a );
            left_unitor_b = CocartesianLeftUnitor( b );
            
            left_unitor_inverse_a_op = CartesianLeftUnitorInverse( opposite, a_op );
            left_unitor_inverse_b_op = CartesianLeftUnitorInverse( opposite, b_op );
            
            @Assert( 0, IsCongruentForMorphisms( left_unitor_inverse_a_op, Opposite( left_unitor_a ) ) );
            @Assert( 0, IsCongruentForMorphisms( left_unitor_inverse_b_op, Opposite( left_unitor_b ) ) );
            
        end;
        
        if CanCompute( cat, "CocartesianRightUnitor" )
            
            if verbose
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianRightUnitor' ..." );
                
            end;
            
            right_unitor_a = CocartesianRightUnitor( a );
            right_unitor_b = CocartesianRightUnitor( b );
            
            right_unitor_inverse_a_op = CartesianRightUnitorInverse( opposite, a_op );
            right_unitor_inverse_b_op = CartesianRightUnitorInverse( opposite, b_op );
            
            @Assert( 0, IsCongruentForMorphisms( right_unitor_inverse_a_op, Opposite( right_unitor_a ) ) );
            @Assert( 0, IsCongruentForMorphisms( right_unitor_inverse_b_op, Opposite( right_unitor_b ) ) );
            
        end;
        
        if CanCompute( cat, "CocartesianLeftUnitorInverse" )
            
            if verbose
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianLeftUnitorInverse' ..." );
                
            end;
            
            left_unitor_inverse_a = CocartesianLeftUnitorInverse( a );
            left_unitor_inverse_b = CocartesianLeftUnitorInverse( b );
            
            left_unitor_a_op = CartesianLeftUnitor( opposite, a_op );
            left_unitor_b_op = CartesianLeftUnitor( opposite, b_op );
            
            @Assert( 0, IsCongruentForMorphisms( left_unitor_a_op, Opposite( left_unitor_inverse_a ) ) );
            @Assert( 0, IsCongruentForMorphisms( left_unitor_b_op, Opposite( left_unitor_inverse_b ) ) );
            
        end;
        
        if CanCompute( cat, "CocartesianRightUnitorInverse" )
            
            if verbose
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianRightUnitorInverse' ..." );
                
            end;
            
            right_unitor_inverse_a = CocartesianRightUnitorInverse( a );
            right_unitor_inverse_b = CocartesianRightUnitorInverse( b );
            
            right_unitor_a_op = CartesianRightUnitor( opposite, a_op );
            right_unitor_b_op = CartesianRightUnitor( opposite, b_op );
            
            @Assert( 0, IsCongruentForMorphisms( right_unitor_a_op, Opposite( right_unitor_inverse_a ) ) );
            @Assert( 0, IsCongruentForMorphisms( right_unitor_b_op, Opposite( right_unitor_inverse_b ) ) );
            
        end;
        
        if CanCompute( cat, "CocartesianAssociatorLeftToRight" )
            
            if verbose
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianAssociatorLeftToRight' ..." );
                
            end;
            
            associator_left_to_right_abc = CocartesianAssociatorLeftToRight( a, b, c );
            associator_left_to_right_cba = CocartesianAssociatorLeftToRight( c, b, a );
            
            associator_right_to_left_abc_op = CartesianAssociatorRightToLeft( opposite, a_op, b_op, c_op );
            associator_right_to_left_cba_op = CartesianAssociatorRightToLeft( opposite, c_op, b_op, a_op );
            
            @Assert( 0, IsCongruentForMorphisms( associator_right_to_left_abc_op, Opposite( associator_left_to_right_abc ) ) );
            @Assert( 0, IsCongruentForMorphisms( associator_right_to_left_cba_op, Opposite( associator_left_to_right_cba ) ) );
            
        end;
        
        if CanCompute( cat, "CocartesianAssociatorRightToLeft" )
            
            if verbose
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'CocartesianAssociatorRightToLeft' ..." );
                
            end;
            
            associator_right_to_left_abc = CocartesianAssociatorRightToLeft( a, b, c );
            associator_right_to_left_cba = CocartesianAssociatorRightToLeft( c, b, a );
            
            associator_left_to_right_abc_op = CartesianAssociatorLeftToRight( opposite, a_op, b_op, c_op );
            associator_left_to_right_cba_op = CartesianAssociatorLeftToRight( opposite, c_op, b_op, a_op );
            
            @Assert( 0, IsCongruentForMorphisms( associator_left_to_right_abc_op, Opposite( associator_right_to_left_abc ) ) );
            @Assert( 0, IsCongruentForMorphisms( associator_left_to_right_cba_op, Opposite( associator_right_to_left_cba ) ) );
            
        end;

end );
