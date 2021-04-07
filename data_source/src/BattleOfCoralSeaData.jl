module BattleOfCoralSeaData

using JSON

export fleets, scouting_plans, make

include("constants.jl")

# pure data file
include("fleets.jl")
include("scouting_plans.jl")
include("land_based_scouting_plans.jl")

# utils
include("make.jl")

end