module BattleOfCoralSeaData

using JSON

export fleets, scouting_plans, make

# pure data file
include("fleets.jl")
include("scouting_plans.jl")

# utils
include("make.jl")

end