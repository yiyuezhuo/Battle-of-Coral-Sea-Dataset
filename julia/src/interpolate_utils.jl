# interpolate utils

struct RecordInterpolated
    x::Float64
    y::Float64
    t::Float64
    d::Float64
end

const EARTH_RADIUS = 6372.8

TimeStampToFloat(t::TimeStamp) = TimeStampToFloat(t.day, t.hour, t.minute)
TimeStampToFloat(day::Int, hour::Int, minute::Int) = Float64(day * 24 * 60 + hour * 60 + minute)
TimeStampToFloat(t::Tuple{Int, Int, Int}) = TimeStampToFloat(t[1], t[2], t[3])

earth_dist_haversine(x1, y1, x2, y2) = haversine([y1, x1], [y2, x2], EARTH_RADIUS)
earth_dist_geodesics(x1, y1, x2, y2) = inverse_deg(x1, y1, x2, y2)[1] / 1000 # m to km

# const earth_dist = earth_dist_haversine
# earth_dist(x1, y1, x2, y2) = earth_dist_geodesics(x1, y1, x2, y2)

function gen_interpolate_records(earth_dist)

    function interpolate_records(records::Vector{Record})
        stack = Record[]
        
        r_seq = RecordInterpolated[
            RecordInterpolated(records[1].x, records[1].y, TimeStampToFloat(records[1].t), 0)]
        for record in records[2:end]
            if record.t === nothing
                push!(stack, record)
            else
                last_key_record = r_seq[end]
                # key_record = RecordInterpolated(record.x, record.y, TimeStampToFloat(record.t), 0)
                key_record_t = TimeStampToFloat(record.t)
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
                        last_key_record.x, last_key_record.y, record.x, record.y)
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
    left_w = 1 - (t - left_record.t) / (right_record.t - left_record.t)
    _dist, azu, _azu_back = inverse_deg(left_record.x, left_record.y, right_record.x, right_record.y)
    lon1, lat1, backazimuth = forward_deg(left_record.x, left_record.y, azu, _dist * left_w)
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
