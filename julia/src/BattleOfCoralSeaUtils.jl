module BattleOfCoralSeaUtils

export load_dataset, Trajectory, interpolate_records, load_shapefile, show_crop, 
    show_trace!, show_fleets!, get_pos

using Shapefile, Plots
using JSON
using Distances

include("load_utils.jl")
include("interpolate_utils.jl")
include("plot_utils.jl")

end # module