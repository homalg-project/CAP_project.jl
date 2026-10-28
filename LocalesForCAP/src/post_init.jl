# Add iterator methods
function iterate(A::IsConstructibleObject.abstract_type)
	iterate( List( A ) )
end

function iterate(A::IsConstructibleObjectAsUnionOfSingleDifferences.abstract_type)
	iterate( List( A ) )
end

function iterate(A::IsObjectInMeetSemilatticeOfMultipleDifferences.abstract_type)
	iterate( List( A ) )
end

@InstallMethod( NormalizedMinuendAndSubtrahendInUnderlyingHeytingOrCoHeytingAlgebroid,
        "for an object in a meet-semilattice of formal single differences",
        [ IsCapCategory, IsCapCategoryObject, IsCapCategoryObject ],
  function( L, minued, subtrahend )
    
    if (HasIsHeytingAlgebroid( L ) && IsHeytingAlgebroid( L ))
        return NORMALIZED_MINUEND_AND_SUBTRAHEND_IN_UNDERLYING_HEYTING_ALGEBROID( L, minued, subtrahend );
    elseif (HasIsCoHeytingAlgebroid( L ) && IsCoHeytingAlgebroid( L ))
        return NORMALIZED_MINUEND_AND_SUBTRAHEND_IN_UNDERLYING_COHEYTING_ALGEBROID( L, minued, subtrahend );
    else
        TryNextMethod( );
    end;
    
end );
