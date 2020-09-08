
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

