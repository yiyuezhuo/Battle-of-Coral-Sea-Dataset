# interpolate utils

struct RecordInterpolated
    x::Float64
    y::Float64
    t::Float64
    d::Float64
end

const EARTH_RADIUS = 6372.8

time_stamp_to_float(t::TimeStamp) = time_stamp_to_float(t.day, t.hour, t.minute)
time_stamp_to_float(day::Int, hour::Int, minute::Int) = Float64(day * 24 * 60 + hour * 60 + minute)
time_stamp_to_float(t::Tuple{Int, Int, Int}) = time_stamp_to_float(t[1], t[2], t[3])

float_to_time_stamp(t::Real) = TimeStamp(t ÷ (24 * 60), mod(t ÷ 60, 24), mod(t, 60))

earth_dist_haversine(x1, y1, x2, y2) = haversine([y1, x1], [y2, x2], EARTH_RADIUS)
earth_dist_geodesics(x1, y1, x2, y2) = inverse_deg(x1, y1, x2, y2)[1]

# const earth_dist = earth_dist_haversine
# earth_dist(x1, y1, x2, y2) = earth_dist_geodesics(x1, y1, x2, y2)

function gen_interpolate_records(earth_dist)

    function interpolate_records(records::Vector{Record})
        stack = Record[]
        
        r_seq = RecordInterpolated[
            RecordInterpolated(records[1].x, records[1].y, time_stamp_to_float(records[1].t), 0)]
        for record in records[2:end]
            if record.t === nothing
                push!(stack, record)
            else
                last_key_record = r_seq[end]
                # key_record = RecordInterpolated(record.x, record.y, time_stamp_to_float(record.t), 0)
                key_record_t = time_stamp_to_float(record.t)
                if length(stack) > 0
                    dist_l = Vector{Float64}(undef, length(stack))
                    last_record = stack[1]
                    dist_l[1] = earth_dist(last_key_record.x, last_key_record.y,
                                        last_record.x, last_record.y)
                    for (i, record_nothing) in enumerate(stack[2:end])
                        d = earth_dist(record_nothing.x, record_nothing.y, 
                                    last_record.x, last_record.y)
                        dist_l[i+1] = d
                        last_record = record_nothing
                    end
                    last_dist = earth_dist(
                        last_record.x, last_record.y, record.x, record.y)
                    cum_sum_plus = sum(dist_l) + last_dist
                    delta_range = key_record_t - last_key_record.t
                    p_l = cumsum(dist_l) / cum_sum_plus * delta_range .+ last_key_record.t
                    for (record_nothing, t_it, d) in zip(stack, p_l, dist_l)
                        record_it = RecordInterpolated(record_nothing.x, record_nothing.y, t_it, d)
                        push!(r_seq, record_it)
                    end
                    empty!(stack)
                    key_record = RecordInterpolated(record.x, record.y, key_record_t, last_dist)
                    push!(r_seq, key_record)
                else
                    key_record_dist = earth_dist(
                        last_key_record.x, last_key_record.y, record.x, record.y)
                    key_record = RecordInterpolated(record.x, record.y, key_record_t, key_record_dist)
                    push!(r_seq, key_record)
                end
            end
        end
        @assert length(stack) == 0
        return r_seq
    end

    return interpolate_records
end

const interpolate_records_haversine = gen_interpolate_records(earth_dist_haversine)
const interpolate_records_geodesics = gen_interpolate_records(earth_dist_geodesics)
const interpolate_records = interpolate_records_geodesics

function contains(records::Vector{RecordInterpolated}, t::Float64)
    return (t >= records[1].t) & (t <= records[end].t)
end

function interpolate_record_haversine(t, left_record, right_record)
    left_w = 1 - (t - left_record.t) / (right_record.t - left_record.t)
    x = left_record.x * left_w + right_record.x * (1-left_w)
    y = left_record.y * left_w + right_record.y * (1-left_w)
    return [x, y]
end

function interpolate_record_geodesics(t, left_record, right_record)
    p = (t - left_record.t) / (right_record.t - left_record.t)
    _dist, azu, _azu_back = inverse_deg(left_record.x, left_record.y, right_record.x, right_record.y)
    lon1, lat1, backazimuth = forward_deg(left_record.x, left_record.y, azu, _dist * p)
    return [lon1, lat1]
end

# interpolate_record(t, left_record, right_record) = interpolate_record_geodesics(t, left_record, right_record)

function gen_get_pos(interpolate_record)

    function get_pos(records::Vector{RecordInterpolated}, t::Float64)
        if t < records[1].t
            error("t = $t < first element time")
        end
        if t > records[end].t
            error("t = $t > last element time")
        end
        left = 1
        right = length(records)
        
        while (right-left) > 1
            test = (left + right) ÷ 2
            test_record = records[test]
            if test_record.t > t
                right = test
            elseif test_record.t < t
                left = test
            else
                return [test_record.x, test_record.y]
            end
        end
        
        left_record = records[left]
        right_record = records[right]

        return interpolate_record(t, left_record, right_record)
    end

    return get_pos
end

const get_pos_haversine = gen_get_pos(interpolate_record_haversine)
const get_pos_geodesics = gen_get_pos(interpolate_record_geodesics)
const get_pos = get_pos_geodesics

#=
raw example

Dict{String,Any} with 8 entries:
  "name"     => "MO Carrier Striking force 1"
  "st"       => Any[4, 8, 0]
  "sp"       => "MO Carrier Striking force"
  "rot_dist" => 37
  "paths"    => Dict{String,Any}("140"=>Dict{String,Any}(),"130"=>Dict{String,A…
  "dist"     => 460
  "rot"      => 90
  "et"       => Any[4, 11, 50]

paths will be expanded to multiple path with similar parameter (mapped value define
unique overrided value).
=#

struct ScoutingPlan
    # name::String, name is the key of the map which value is a collection of ScoutingPlan 
    st::Float64 # start time
    sp::Tuple{Float64, Float64} # start point
    et::Float64 # end time
    ep::Tuple{Float64, Float64} # end point
    azimuth::Float64 # degree
    dist::Float64 # km, while the data of previous version is encoded as m
    rot::Float64 # degree
    rot_dist::Float64 # km
end

function expand_plans(scouting_plans, 
                      name_to_record_int_vec::Dict{String, Vector{RecordInterpolated}})
    rd = Dict{String, Vector{ScoutingPlan}}()

    for plan in scouting_plans
        pl = ScoutingPlan[]

        plan = copy(plan)

        name = pop!(plan, "name")
        paths = pop!(plan, "paths")
        for (azumuth, path) in paths
            d = Dict(plan..., path...)

            st = time_stamp_to_float(d["st"]...)
            et = time_stamp_to_float(d["et"]...)
            if typeof(d["sp"]) == String
                spv = name_to_record_int_vec[d["sp"]]
                sp = get_pos(spv, st)
                ep = get_pos(spv, et)
            else
                sp = d["sp"]
                if haskey(d, "ep")
                    ep = d["ep"]
                else
                    ep = sp
                end
            end

            p = ScoutingPlan(st, Tuple(sp), et, Tuple(ep), Meta.parse(azumuth), 
                             d["dist"], d["rot"], d["rot_dist"])
            push!(pl, p)
        end
        rd[name] = pl
    end

    return rd
end

function get_scouting(sp, ep, azimuth, dist, rot, rot_dist)
    xy = forward_deg(sp[1], sp[2], azimuth, dist)
    xy2 = forward_deg(xy[1], xy[2], azimuth + rot, rot_dist)
    d3, azimuth_back, azimuth_back_inv = inverse_deg(xy2[1], xy2[2], ep[1], ep[2])
    sum_dist = dist + rot_dist + d3
    pt1 = dist / sum_dist
    pt2 = (dist + rot_dist) / sum_dist

    function scouting(p)
        if p < pt1
            rxy = forward_deg(sp[1], sp[2], azimuth,  dist * p / pt1)
        elseif p < pt2
            rxy = forward_deg(xy[1], xy[2], azimuth + rot, rot_dist * (p-pt1)/(pt2-pt1))
        else
            rxy = forward_deg(xy2[1], xy2[2], azimuth_back, d3 * (p-pt2) / (1-pt2))
        end
        return rxy
    end
    return scouting
end


function get_scouting_t(st, et, sp, ep, azimuth, dist, rot, rot_dist)
    scouting = get_scouting(sp, ep, azimuth, dist, rot, rot_dist)
    function _scouting(t)
        # @show st et sp ep azimuth dist rot rot_dist
        if (t <= st) | (t >= et)
            return nothing # type instability? Anyway it's not the bottleneck.
        end
        p = (t - st) / (et - st)
        return scouting(p)
    end
    return _scouting
end

function get_scouting(sp::ScoutingPlan)
    return get_scouting(sp.sp, sp.ep, sp.azimuth, sp.dist, sp.rot, sp.rot_dist)
end

function get_scouting_t(sp::ScoutingPlan)
    return get_scouting_t(sp.st, sp.et, sp.sp, sp.ep, sp.azimuth, sp.dist, sp.rot, sp.rot_dist)
end


function take_xy(xya_l)
    x = [xya[1] for xya in xya_l]
    y = [xya[2] for xya in xya_l]
    return x, y
end
