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
    plt = plot()
    show_crop!(sp, left, bottom, right, top, raw=raw)
end

function show_crop!(sp, left, bottom, right, top; raw=false)
    sp_r = filter_shape(sp, left, bottom, right, top)
    if raw
        plot!(sp_r)
    else
        plot!(sp_r, fill_z = randn(length(sp_r)), lc = :white, fillcolor = :Blues)
    end
    plot!(xlims=(left, right), ylim=(bottom, top))
end


show_trace!(t::Trajectory) = plot!(map(s->s.x, t.seq), map(s->s.y, t.seq))
function show_trace!(tl::Vector{Trajectory})
    for t in tl
        show_trace!(t)
    end
end

function show_fleets!(fleets::Vector{Vector{RecordInterpolated}}, 
                      names::Vector{String}, t::Float64)
    for (fleet, name) in zip(fleets, names)
        if contains(fleet, t)
            x, y = get_pos(fleet, t)
            annotate!(x, y, text(name, :black, :center, 5))
        end
    end
end

"""
    plot_circle!(x, y, r; particles=100)

It is just pure circle plotting helper, without considering projection distorture.
"""
function plot_circle!(x, y, r; particles=100)
    pts = Plots.partialcircle(0, 2π, particles, r)
    pts_x, pts_y = Plots.unzip(pts)
    pts_x .+= x
    pts_y .+= y
    plot!(pts_x, pts_y)
end

function plot_expanded_plans!(expanded_plans::Dict{String, Vector{ScoutingPlan}})
    for (name, plans) in expanded_plans
        for plan in plans
            sf = get_scouting(plan)
            x, y = take_xy(sf.(range(1e-6, 1, length=30)))
            plot!(x, y)
            scatter!(x, y, markersize=1)
        end
    end
end

function make_sector_shape(base_x, base_y, deg_start, deg_end, radius; particles=100)
	rad_start = deg_start / 180 * π
	rad_end = deg_end / 180 * π
	rad_vec = range(rad_start, rad_end, length=particles)
	x_vec = base_x .+ radius * cos.(rad_vec)
	y_vec = base_y .+ radius * sin.(rad_vec)
	Shape([base_x; x_vec], [base_y; y_vec])
end

function make_sector_shape_geo(base_long, base_lat, deg_start, deg_end, radius; particles=100)
	deg_vec = range(deg_start, deg_end, length=particles)
	long_lat_vec = forward_deg.(base_long, base_lat, deg_vec, radius)
	long_vec = map(long_lat->long_lat[1], long_lat_vec)
	lat_vec = map(long_lat->long_lat[2], long_lat_vec)
	Shape([base_long; long_vec], [base_lat; lat_vec])
end
