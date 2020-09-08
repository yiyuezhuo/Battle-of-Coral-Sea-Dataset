module BattleOfCoralSeaGP

using Stheno
using BattleOfCoralSeaUtils
using Geodesics
using Distances

using Stheno: BaseKernel, AV
import Stheno: ew, pw
using BattleOfCoralSeaUtils: earth_dist_geodesics

export ExpGeodesics, ExpHaversine, grid_xy, grid_xyt, arg_grid_xy, arg_grid_xyt

include("exp_geodesics.jl")
include("exp_haversine.jl")
include("grid.jl")

end # module
