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

function plot_land_base_scouting!(plan, locs_dict; color=:yellow)
	for (name, loc) in locs_dict
		longitude, latitude = loc
		annotate!(longitude, latitude, text(name, :black, :center, 10))
	end
	for (area_name, area) in zip(keys(plan), plan)
		base_longitude, base_latitude = locs_dict[area.base]
		s = make_sector_shape_geo(base_longitude, base_latitude, area.bearing[1], area.bearing[2], area.distance)
		plot!(s, fillcolor=plot_color(color, 0.1))
	end
end

function make_parallel_line_points(base_long, base_lat, deg, radius, turn_deg, edge; visible_radius=40.2336, rendezvous_percent=0.1, visible_band=true)
	long_start, lat_start, _ = forward_deg(base_long, base_lat, turn_deg, edge)
	long_rend, lat_rend, _ = forward_deg(long_start, lat_start, deg, radius * rendezvous_percent)
	if visible_band
		long_rend, lat_rend, _ = forward_deg(long_rend, lat_rend, turn_deg, visible_radius)
	end
	long_end, lat_end, _ = forward_deg(long_rend, lat_rend, deg, radius * (1-rendezvous_percent))
	return long_rend, lat_rend, long_end, lat_end
end

function make_parallel_search_line_shape(base_long, base_lat, deg, radius, edge_list; visible_radius=40.2336, rendezvous_percent=0.1, visible_band=true)
	# 25mi ≈ 40.2336km
	# Here we will just assume that the parallel search lines make a "completed" scouting area, thus extrene edge one is considered only.
	right_deg = (deg+90) % 360
	left_deg = (deg-90) % 360
	
	right_edge = maximum(edge_list)
	left_edge = minimum(edge_list)
	@assert left_edge < 0
	left_edge = -left_edge
	
	long_rend_left, lat_rend_left, long_end_left, lat_end_left = make_parallel_line_points(base_long, base_lat, deg, radius, left_deg, left_edge; visible_radius, rendezvous_percent, visible_band)
	long_rend_right, lat_rend_right, long_end_right, lat_end_right = make_parallel_line_points(base_long, base_lat, deg, radius, right_deg, right_edge; visible_radius, rendezvous_percent, visible_band)
	long_list = [base_long, long_rend_left, long_end_left, long_end_right, long_rend_right]
	lat_list = [base_lat, lat_rend_left, lat_end_left, lat_end_right, lat_rend_right]
	return Shape(long_list, lat_list)
end

