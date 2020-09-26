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

function load_shapefile()
    # require full file structure
    shape_path = joinpath(splitpath(pathof(BattleOfCoralSeaUtils))[1:end-3]..., 
                          "shape_data", "ne_50m_land.shp")
    return load_shapefile(shape_path)
end

# preprocess, mainly used to simplify pyjulia usage

function preprocess(fleets_path, scouting_plans_path)
    # load data, provide a deeper helper?
    fleets = load_dataset(fleets_path)
    scouting_plans = load_dataset(scouting_plans_path)
    trajectories = Trajectory.(fleets)
    sp50 = load_shapefile()

    seqs = map(x->interpolate_records(x.seq), trajectories)
    names = map(x->x.name, trajectories)

    name_to_record_int_vec = Dict(tra.name => seq for (tra, seq) in zip(trajectories, seqs))
    expanded_plans = expand_plans(scouting_plans, name_to_record_int_vec)
    name_to_scouting_t = Dict(name => get_scouting_t.(ep) for (name, ep) in expanded_plans)

    return (;fleets, scouting_plans, trajectories, sp50, seqs, names, name_to_record_int_vec,
            expand_plans, name_to_scouting_t)
end
