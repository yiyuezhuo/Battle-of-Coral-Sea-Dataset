module BattleOfCoralSeaUtils

export load_dataset, Trajectory, interpolate_records, load_shapefile, show_crop, 
    show_trace!, show_fleets!, get_pos, TimeStampToFloat, TimeStamp

using Shapefile, Plots
using JSON
using Distances
using Geodesics

include("geodesics_utils.jl")

include("load_utils.jl")
include("interpolate_utils.jl")
include("plot_utils.jl")

end # module
