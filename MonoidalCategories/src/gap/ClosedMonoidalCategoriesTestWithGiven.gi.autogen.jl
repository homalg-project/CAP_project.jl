# SPDX-License-Identifier: GPL-2.0-or-later
# MonoidalCategories: Monoidal and monoidal (co)closed categories
#
# Implementations
#

@InstallGlobalFunction( "ClosedMonoidalCategoriesTestWithGiven",
    
    function( cat, opposite, a, b, c, d, alpha, beta )
        
        local verbose,
              
              a_op, c_op,
              b_op, d_op,
              
              alpha_op, hom_alpha_beta, cohom_alpha_beta_op,
              beta_op,  hom_beta_alpha, cohom_beta_alpha_op,
              
              hom_bc, hom_bc_x_a, cohom_ad, cohom_ad_x_c,
              hom_da, hom_da_x_c, cohom_cb, cohom_cb_x_a,
              
              hom_to_tensor_adjunction_on_hom_alpha_beta, cohom_to_tensor_adjunction_on_cohom_alpha_beta_op,
              hom_to_tensor_adjunction_on_hom_beta_alpha, cohom_to_tensor_adjunction_on_cohom_beta_alpha_op;
              
        a_op = Opposite( opposite, a );
        b_op = Opposite( opposite, b );
        c_op = Opposite( opposite, c );
        d_op = Opposite( opposite, d );
        
        alpha_op = Opposite( opposite, alpha );
        beta_op = Opposite( opposite, beta );
        
        verbose = ValueOption( "verbose" ) == true;
        
        if (CanCompute( cat, "InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct" ))
            
            if (verbose)
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct' ..." );
                
            end;
            
            #####################################################
            #
            # hom_alpha_beta: Hom( b, c ) → Hom( a, d )
            # hom_beta_alpha: Hom( d, a ) → Hom( c, b )
            #
            #####################################################
            #
            # cohom_alpha_beta: coHom( a, d ) → coHom( b, c )
            # cohom_beta_alpha: coHom( c, b ) → coHom( d, a )
            #
            # cohom_alpha_beta_op: coHom( b, c ) → coHom( a, d )
            # cohom_beta_alpha_op: coHom( d, a ) → coHom( c, b )
            #
            #####################################################
            
            hom_bc = InternalHomOnObjects( b, c );
            hom_da = InternalHomOnObjects( d, a );
            
            hom_bc_x_a = TensorProductOnObjects( hom_bc, a );
            hom_da_x_c = TensorProductOnObjects( hom_da, c );
            
            cohom_ad = InternalCoHomOnObjects( a_op, d_op );
            cohom_cb = InternalCoHomOnObjects( c_op, b_op );
            
            cohom_ad_x_c = TensorProductOnObjects( cohom_ad, c_op );
            cohom_cb_x_a = TensorProductOnObjects( cohom_cb, a_op );
            
            hom_alpha_beta = InternalHomOnMorphisms( alpha, beta );
            hom_beta_alpha = InternalHomOnMorphisms( beta, alpha );
            
            cohom_alpha_beta_op = InternalCoHomOnMorphisms( alpha_op, beta_op );
            cohom_beta_alpha_op = InternalCoHomOnMorphisms( beta_op, alpha_op );
            
            # Adjoint( Hom( b, c ) → Hom( a, d ) )  ==  Hom( b, c ) ⊗ a → d
            hom_to_tensor_adjunction_on_hom_alpha_beta = InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct( a, d, hom_alpha_beta, hom_bc_x_a );
            
            # Adjoint( Hom( d, a ) → Hom( c, b ) )  ==  Hom( d, a ) ⊗ c → b
            hom_to_tensor_adjunction_on_hom_beta_alpha = InternalHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct( c, b, hom_beta_alpha, hom_da_x_c );
            
            # Adjoint( Cohom( b, c ) → Cohom( a, d ) )  ==  b → Cohom( a, d ) ⊗ c
            cohom_to_tensor_adjunction_on_cohom_alpha_beta_op = InternalCoHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct( b_op, c_op, cohom_alpha_beta_op, cohom_ad_x_c );
            
            # Adjoint( Cohom( d, a ) → Cohom( c, b ) )  ==  d → Cohom( c, b ) ⊗ a
            cohom_to_tensor_adjunction_on_cohom_beta_alpha_op = InternalCoHomToTensorProductLeftAdjunctMorphismWithGivenTensorProduct( d_op, a_op, cohom_beta_alpha_op, cohom_cb_x_a );
            
            # b → coHom( a, d ) ⊗ c  ==  op( Hom( d, a ) ⊗ c → b )
            @Assert( 0, IsCongruentForMorphisms( cohom_to_tensor_adjunction_on_cohom_alpha_beta_op, Opposite( opposite, hom_to_tensor_adjunction_on_hom_beta_alpha ) ) );
            
            # d → coHom( c, b ) ⊗ a  ==  op( Hom( b, c ) ⊗ a → d )
            @Assert( 0, IsCongruentForMorphisms( cohom_to_tensor_adjunction_on_cohom_beta_alpha_op, Opposite( opposite, hom_to_tensor_adjunction_on_hom_alpha_beta ) ) );
            
        end;
        
end );
