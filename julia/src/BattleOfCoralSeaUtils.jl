module BattleOfCoralSeaUtils

export load_dataset, Trajectory, interpolate_records, load_shapefile, show_crop, show_crop!,
    show_trace!, show_fleets!, get_pos, TimeStamp, expand_plans, ScoutingPlan,
    get_scouting, get_scouting_t, forward_deg, inverse_deg, plot_circle!, plot_expanded_plans!,
    GeodesicsDistance, EARTH_RADIUS, time_stamp_to_float, float_to_time_stamp, RecordInterpolated

using Shapefile, Plots
using JSON
using Distances
using Geodesics

include("geodesics_utils.jl")

include("load_utils.jl")
include("interpolate_utils.jl")
include("plot_utils.jl")

end # module
