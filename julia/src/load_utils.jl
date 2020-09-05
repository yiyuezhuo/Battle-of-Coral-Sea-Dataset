# load_utils

struct TimeStamp
    day::Int
    hour::Int
    minute::Int
end

struct Record
    x::Float64
    y::Float64
    t::Union{Nothing, TimeStamp}
end

struct Trajectory
    name::String
    seq::Vector{Record}
    level::String
end

TimeStamp(tt::Tuple{Int, Int, Int}) = TimeStamp(tt...)
Record(tt::Tuple{Float64, Float64, Union{Nothing, TimeStamp}}) = Record(tt...)
Trajectory(dic::Dict) = Trajectory(dic["name"], dic["seq"], dic["level"])

Base.convert(::Type{TimeStamp}, tt::Vector) = TimeStamp(tt...)
Base.convert(::Type{Record}, tt::Vector) = Record(tt...)
Base.convert(::Type{Trajectory}, dic::Dict) = Trajectory(dic["name"], dic["seq"], dic["level"])

function load_dataset(path)
    tl = open(path, "r") do f
        JSON.parse(String(read(f)))
    end
    return tl
end

function load_shapefile(path)
    return Shapefile.shapes(Shapefile.Table(path))
end
