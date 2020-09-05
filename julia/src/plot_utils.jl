# plot utils

function filter_shape(sp, left, bottom, right, top)
    sp_new = empty(sp)
    for s in sp
        if (s.MBR.right < left) | (s.MBR.left > right) | (s.MBR.bottom > top) | (s.MBR.top < bottom)
            continue
        end
        for p in s.points
            if (p.x > left) & (p.x < right) & (p.y > bottom) & (p.y < top)
                push!(sp_new, s)
                break
            end
        end
    end
    return sp_new
end

function show_crop(sp, left, bottom, right, top; raw=false)
    sp_r = filter_shape(sp, left, bottom, right, top)
    if raw
        plot(sp_r)
    else
        plot(sp_r, fill_z = randn(length(sp_r)), lc = :white, fillcolor = :Blues)
    end
    plot!(xlims=(left, right), ylim=(bottom, top))
end

show_trace!(t::Trajectory) = plot!(map(s->s.x, t.seq), map(s->s.y, t.seq))
function show_trace!(tl::Vector{Trajectory})
    for t in tl
        show_trace!(t)
    end
end

function show_fleets!(fleets::Vector{Vector{RecordInterpolated}}, names::Vector{String}, t::Float64)
    for (fleet, name) in zip(fleets, names)
        if contains(fleet, t)
            x, y = get_pos(fleet, t)
            annotate!(x, y, text(name, :black, :center, 5))
        end
    end
end