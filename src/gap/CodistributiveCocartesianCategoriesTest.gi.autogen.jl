# SPDX-License-Identifier: GPL-2.0-or-later
# CartesianCategories: Cartesian && cocartesian categories && various subdoctrines
#
# Implementations
#
# THIS FILE WAS AUTOMATICALLY GENERATED



@InstallGlobalFunction( "CodistributiveCocartesianCategoriesTest",
    
    function( cat, a, L )
        
        local opposite, verbose,
              
              a_op, left_expanding_a_L, left_expanding_a_L_op, left_factoring_a_L, left_factoring_a_L_op, 
              L_op, right_expanding_L_a, right_expanding_L_a_op, right_factoring_L_a, right_factoring_L_a_op;
        
        opposite = Opposite( cat );
        
        a_op = Opposite( a );
        L_op = List( L, l -> Opposite( l ) );
        
        verbose = ValueOption( "verbose" ) == true;
        
        if CanCompute( cat, "LeftCocartesianCodistributivityExpanding" )
            
            if verbose
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCocartesianCodistributivityExpanding' ..." );
                
            end;
            
            left_expanding_a_L = LeftCocartesianCodistributivityExpanding( a, L );
            left_factoring_a_L_op = LeftCartesianDistributivityFactoring( opposite, a_op, L_op );
            
            @Assert( 0, IsCongruentForMorphisms( left_expanding_a_L, Opposite( left_factoring_a_L_op ) ) );
            
        end;
        
        if CanCompute( cat, "LeftCocartesianCodistributivityFactoring" )
            
            if verbose
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'LeftCocartesianCodistributivityFactoring' ..." );
                
            end;
            
            left_factoring_a_L = LeftCocartesianCodistributivityFactoring( a, L );
            left_expanding_a_L_op = LeftCartesianDistributivityExpanding( opposite, a_op, L_op );
            
            @Assert( 0, IsCongruentForMorphisms( left_factoring_a_L, Opposite( left_expanding_a_L_op ) ) );
            
        end;
        
        if CanCompute( cat, "RightCocartesianCodistributivityExpanding" )
            
            if verbose
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightCocartesianCodistributivityExpanding' ..." );
                
            end;
            
            right_expanding_L_a = RightCocartesianCodistributivityExpanding( L, a );
            right_factoring_L_a_op = RightCartesianDistributivityFactoring( opposite, L_op, a_op );
            
            @Assert( 0, IsCongruentForMorphisms( right_expanding_L_a, Opposite( right_factoring_L_a_op ) ) );
            
        end;
        
        if CanCompute( cat, "RightCocartesianCodistributivityFactoring" )
            
            if verbose
                
                # COVERAGE_IGNORE_NEXT_LINE
                Display( "Testing 'RightCocartesianCodistributivityFactoring' ..." );
                
            end;
            
            right_factoring_L_a = RightCocartesianCodistributivityFactoring( L, a );
            right_expanding_L_a_op = RightCartesianDistributivityExpanding( opposite, L_op, a_op );
            
            @Assert( 0, IsCongruentForMorphisms( right_factoring_L_a, Opposite( right_expanding_L_a_op ) ) );
            
        end;
        
end );
