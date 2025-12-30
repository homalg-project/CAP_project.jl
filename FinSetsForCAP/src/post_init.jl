##
function BoolToBigInt(b::Bool)
    BigInt(b)
end

# Iterator in FinSets
function iterate(M::IsObjectInCategoryOfFiniteSets.abstract_type)
	iterate( AsList( M ) )
end

function iterate(M::IsObjectInCategoryOfFiniteSets.abstract_type, state)
	iterate( AsList( M ), state )
end

# CallFuncList in FinSets
function (phi::IsMorphismInCategoryOfFiniteSets.abstract_type)(x)
	CallFuncList( phi, [ x ] )
end

# convenience converting Int to BigInt in SkeletalFinSets

##
function FinSet(n::Int)
    FinSet(BigInt(n));
end

##
function FinSet(cat::IsSkeletalCategoryOfFiniteSets.abstract_type, n::Int)
    FinSet(cat, BigInt(n))
end

##
function /(n::Int, cat::IsSkeletalCategoryOfFiniteSets.abstract_type)
    FinSet(cat, n)
end

##
function MapOfFinSets(s::IsObjectInSkeletalCategoryOfFiniteSets.abstract_type, G::Vector{Int}, t::IsObjectInSkeletalCategoryOfFiniteSets.abstract_type)
	MapOfFinSets( s, Vector{BigInt}(G), t );
end

function MapOfFinSets(s::IsObjectInSkeletalCategoryOfFiniteSets.abstract_type, G::UnitRange{Int}, t::IsObjectInSkeletalCategoryOfFiniteSets.abstract_type)
	MapOfFinSets( s, UnitRange{BigInt}(G), t );
end

function MapOfFinSets(s::IsObjectInSkeletalCategoryOfFiniteSets.abstract_type, G::StepRange{Int}, t::IsObjectInSkeletalCategoryOfFiniteSets.abstract_type)
	MapOfFinSets( s, StepRange{BigInt}(G), t );
end

# CallFuncList in SkeletalFinSets
function (phi::IsMorphismInSkeletalCategoryOfFiniteSets.abstract_type)(x)
	CallFuncList( phi, [ x ] )
end
