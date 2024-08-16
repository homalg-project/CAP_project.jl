# SPDX-License-Identifier: GPL-2.0-or-later
# CAP: Categories, Algorithms, Programming
#
# Implementations
#

## dummy homalg rings

@BindGlobal( "TheFamilyOfDummyHomalgRings",
        NewFamily( "TheFamilyOfDummyHomalgRings" ) );

CAP_INTERNAL_DUMMY_HOMALG_RING_COUNTER = 1;

@InstallGlobalFunction( DummyHomalgRing, function( )
  local ring_filter, ring_element_filter, name, ring;
    
    ring_filter = NewFilter( "DummyHomalgRingFilter", IsDummyHomalgRing );
    ring_element_filter = NewFilter( "DummyHomalgRingElementFilter", IsDummyHomalgRingElement );
    
    name = @Concatenation( "Dummy homalg ring ", StringGAP( CAP_INTERNAL_DUMMY_HOMALG_RING_COUNTER ) );
    CAP_INTERNAL_DUMMY_HOMALG_RING_COUNTER = CAP_INTERNAL_DUMMY_HOMALG_RING_COUNTER + 1;
    
    ring = ObjectifyWithAttributes( @rec( ),
        NewType( TheFamilyOfDummyHomalgRings, IsAttributeStoringRep && ring_filter ),
        Name, name,
        StringGAP, name,
        RingFilter, ring_filter,
        RingElementFilter, ring_element_filter
    );
    
    return ring;
    
end );

## dummy commutative homalg rings

@BindGlobal( "TheFamilyOfDummyCommutativeHomalgRings",
        NewFamily( "TheFamilyOfDummyCommutativeHomalgRings" ) );

CAP_INTERNAL_DUMMY_COMMUTATIVE_HOMALG_RING_COUNTER = 1;

@InstallGlobalFunction( DummyCommutativeHomalgRing, function( )
  local ring_filter, ring_element_filter, name, ring;
    
    ring_filter = NewFilter( "DummyCommutativeHomalgRingFilter", IsDummyCommutativeHomalgRing );
    ring_element_filter = NewFilter( "DummyCommutativeHomalgRingElementFilter", IsDummyCommutativeHomalgRingElement );
    
    name = @Concatenation( "Dummy commutative homalg ring ", StringGAP( CAP_INTERNAL_DUMMY_COMMUTATIVE_HOMALG_RING_COUNTER ) );
    CAP_INTERNAL_DUMMY_COMMUTATIVE_HOMALG_RING_COUNTER = CAP_INTERNAL_DUMMY_COMMUTATIVE_HOMALG_RING_COUNTER + 1;
    
    ring = ObjectifyWithAttributes( @rec( ),
        NewType( TheFamilyOfDummyCommutativeHomalgRings, IsAttributeStoringRep && ring_filter ),
        Name, name,
        StringGAP, name,
        RingFilter, ring_filter,
        RingElementFilter, ring_element_filter,
        IsCommutative, true
    );
    
    return ring;
    
end );

## dummy homalg fields

@BindGlobal( "TheFamilyOfDummyHomalgFields",
        NewFamily( "TheFamilyOfDummyHomalgFields" ) );

CAP_INTERNAL_DUMMY_HOMALG_FIELD_COUNTER = 1;

@InstallGlobalFunction( DummyHomalgField, function( )
  local ring_filter, ring_element_filter, name, ring;
    
    ring_filter = NewFilter( "DummyHomalgFieldFilter", IsDummyHomalgField );
    ring_element_filter = NewFilter( "DummyHomalgFieldElementFilter", IsDummyHomalgFieldElement );
    
    name = @Concatenation( "Dummy homalg field ", StringGAP( CAP_INTERNAL_DUMMY_HOMALG_FIELD_COUNTER ) );
    CAP_INTERNAL_DUMMY_HOMALG_FIELD_COUNTER = CAP_INTERNAL_DUMMY_HOMALG_FIELD_COUNTER + 1;
    
    ring = ObjectifyWithAttributes( @rec( ),
        NewType( TheFamilyOfDummyHomalgFields, IsAttributeStoringRep && ring_filter ),
        Name, name,
        StringGAP, name,
        RingFilter, ring_filter,
        RingElementFilter, ring_element_filter,
        IsField, true,
        IsFieldForHomalg, true
    );
    
    return ring;
    
end );
