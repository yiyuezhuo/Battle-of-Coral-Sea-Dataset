
# Add distance adaptor

ew(h::Haversine, x::ColVecs{<:Real}, x′::ColVecs{<:Real}) = colwise(h, x.X, x′.X)
pw(h::Haversine, x::ColVecs{<:Real}, x′::ColVecs{<:Real}) = pw(h, x.X, x′.X)

# Unary methods.
ew(h::Haversine, x::ColVecs{<:Real}) = colwise(h, x.X, x.X) # zero
pw(h::Haversine, x::ColVecs{<:Real}) = pw(h, x.X)

# define kernel

struct ExpHaversine{T} <: BaseKernel
    r::T
end

ew(eh::ExpHaversine, x::AV, x′::AV) = exp.(.-ew(Haversine(eh.r), x, x′) ./ 2)
pw(eh::ExpHaversine, x::AV, x′::AV) = exp.(.-pw(Haversine(eh.r), x, x′) ./ 2)

# Unary methods.
ew(eh::ExpHaversine, x::AV) = exp.(.-ew(Haversine(eh.r), x) ./ 2)
pw(eh::ExpHaversine, x::AV) = exp.(.-pw(Haversine(eh.r), x) ./ 2)

# define kernel

struct ExpHaversineScale{T} <: BaseKernel
    r::T
    s::T
end

ew(eh::ExpHaversineScale, x::AV, x′::AV) = exp.(.-ew(Haversine(eh.r), x, x′) ./ 2 ./ eh.s)
pw(eh::ExpHaversineScale, x::AV, x′::AV) = exp.(.-pw(Haversine(eh.r), x, x′) ./ 2 ./ eh.s)

# Unary methods.
ew(eh::ExpHaversineScale, x::AV) = exp.(.-ew(Haversine(eh.r), x) ./ 2 ./ eh.s)
pw(eh::ExpHaversineScale, x::AV) = exp.(.-pw(Haversine(eh.r), x) ./ 2 ./ eh.s)

# define kernel

struct XytHaversineScale{T} <: BaseKernel
    r::T
    s_xy::T
    s_t::T
end

function ew(eh::XytHaversineScale, x::AV, x′::AV)
    d_xy = ew(Haversine(eh.r), ColVecs(x.X[1:2,:]), ColVecs(x′.X[1:2, :]))
    d_t = ew(SqEuclidean(), x.X[3,:], x′.X[3,:])
    return exp.(-(d_xy ./ eh.s_xy + d_t ./ eh.s_t))
end
function pw(eh::XytHaversineScale, x::AV, x′::AV)
    d_xy = pw(Haversine(eh.r), ColVecs(x.X[1:2,:]), ColVecs(x′.X[1:2, :]))
    d_t = pw(SqEuclidean(), x.X[3,:], x′.X[3,:])
    return exp.(.-(d_xy ./ eh.s_xy + d_t ./ eh.s_t))
end

# Unary methods.
ew(eh::XytHaversineScale, x::AV) = ew(eh, x, x) # slow, but it's just a prototype
pw(eh::XytHaversineScale, x::AV) = pw(eh, x, x)
