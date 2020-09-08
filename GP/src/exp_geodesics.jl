

# Define Distances.Metric

struct GeodesicsDistance <: Metric end

function (::GeodesicsDistance)(a::AbstractArray, b::AbstractArray)
    return earth_dist_geodesics(a[1], a[2], b[1], b[2])
end

# Add distance adaptor

ew(h::GeodesicsDistance, x::ColVecs{<:Real}, x′::ColVecs{<:Real}) = colwise(h, x.X, x′.X)
pw(h::GeodesicsDistance, x::ColVecs{<:Real}, x′::ColVecs{<:Real}) = pw(h, x.X, x′.X)

# Unary methods.
ew(h::GeodesicsDistance, x::ColVecs{<:Real}) = colwise(h, x.X, x.X) # zero
pw(h::GeodesicsDistance, x::ColVecs{<:Real}) = pw(h, x.X)

# Define kernel

struct ExpGeodesics <: BaseKernel end

ew(::ExpGeodesics, x::AV, x′::AV) = exp.(.-ew(GeodesicsDistance(), x, x′) ./ 2)
pw(::ExpGeodesics, x::AV, x′::AV) = exp.(.-pw(GeodesicsDistance(), x, x′) ./ 2)

# Unary methods.
ew(::ExpGeodesics, x::AV) = exp.(.-ew(GeodesicsDistance(), x) ./ 2)
pw(::ExpGeodesics, x::AV) = exp.(.-pw(GeodesicsDistance(), x) ./ 2)

