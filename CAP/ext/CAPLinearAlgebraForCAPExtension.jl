module CAPLinearAlgebraForCAPExtension

@nospecialize

using CAP

using LinearAlgebraForCAP

@IMPORT_THE_WORLD()

CAP.IS_PRECOMPILING = true

include("../src/gap/DummyImplementationsOfMatricesForHomalg.gd.autogen.jl")
include("../src/gap/DummyImplementationsOfMatricesForHomalg.gi.autogen.jl")

CAP.IS_PRECOMPILING = false

end # module CAPLinearAlgebraForCAPExtension
