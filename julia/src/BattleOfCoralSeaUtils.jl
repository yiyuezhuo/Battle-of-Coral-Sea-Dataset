module BattleOfCoralSeaUtils

export load_dataset, Trajectory, interpolate_records, load_shapefile, show_crop, show_crop!,
    show_trace!, show_fleets!, get_pos, time_stamp_to_float, TimeStamp, expand_plans,
    get_scouting, forward_deg, inverse_deg, plot_circle!, plot_expanded_plans!, float_to_time_stamp,
    GeodesicsDistance

using Shapefile, Plots
using JSON
using Distances
using Geodesics

include("geodesics_utils.jl")

include("load_utils.jl")
include("interpolate_utils.jl")
include("plot_utils.jl")

end # module
