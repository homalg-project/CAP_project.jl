module CAP

@nospecialize

# define functions in DummyImplementationsOfMatricesForHomalg here to make sure they are available to the outside world
# see https://discourse.julialang.org/t/we-do-need-exportable-new-structs-and-functions-in-extension/105810 for some background
function DummyHomalgRing end
function DummyCommutativeHomalgRing end
function DummyHomalgField end

# define functions in CAPJSONExtension here to make sure they are available to the outside world
# see https://discourse.julialang.org/t/we-do-need-exportable-new-structs-and-functions-in-extension/105810 for some background
function JsonStringToGap end
function GapToJsonString end

using AbstractAlgebra

include("gap_emulation.jl")

include("init.jl")

pop!(ModulesForEvaluationStack)
@Assert( 0, IsEmpty( ModulesForEvaluationStack ) )

end # module CAP
