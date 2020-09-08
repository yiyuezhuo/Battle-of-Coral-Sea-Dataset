### A Pluto.jl notebook ###
# v0.11.12

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 457c5a08-f176-11ea-33ea-c99aad944d42
using BattleOfCoralSeaUtils

# ╔═╡ 650274c2-f176-11ea-344b-a7d22b16bb3e
using Plots

# ╔═╡ 6b544ae2-f176-11ea-3b54-abcdc6c0c1e1
import BattleOfCoralSeaData

# ╔═╡ 712bc8fa-f176-11ea-34c9-2ba88534b36c
BattleOfCoralSeaData.make()

# ╔═╡ 74cd0802-f176-11ea-3014-3f0b3a9f2566
fleets = load_dataset("fleets.json")

# ╔═╡ 8aacfd9e-f176-11ea-0f06-af34e63b97a0
trajectories = Trajectory.(fleets)

# ╔═╡ 9cddda74-f176-11ea-0280-c79dc0ea7843
sp50 = load_shapefile();

# ╔═╡ b18e3072-f176-11ea-1b82-b3615cba5dc5
begin
	plt = show_crop(sp50, 150, -20, 165, 0, raw=true)
	show_trace!(trajectories)
	plt
end

# ╔═╡ bb11765e-f176-11ea-1825-098d46ab5fb9
get_pos(interpolate_records(trajectories[1].seq), 6500.)


# ╔═╡ c2e983d0-f176-11ea-2af0-4197e2a2b156
seqs = map(x->interpolate_records(x.seq), trajectories)


# ╔═╡ c798e9fc-f176-11ea-3e0c-97a8b7ee7433
names = map(x->x.name, trajectories)


# ╔═╡ 5f767f64-f177-11ea-2852-f7214fc25bc1
float_to_time_stamp(t::Real) = TimeStamp(t ÷ (24 * 60), mod(t ÷ 60, 24), mod(t, 60))

# ╔═╡ ceb85e16-f176-11ea-1b03-5d9d3a612c78
@bind t html"<input type=range min=3000 max=12500 step=10>"

# ╔═╡ a02715b4-f177-11ea-0ab4-f5be7b5f2c8e
t

# ╔═╡ 00e2234a-f177-11ea-0c08-c9170cbfe7ee
float_to_time_stamp(t)

# ╔═╡ a4a0e188-f177-11ea-0b3a-e98baab08444
let
	plt = plot()
	show_crop!(sp50, 150, -20, 165, 0, raw=true)
	show_trace!(trajectories)
	show_fleets!(seqs, names, Float64(t))
	# show_fleets_haversine!(seqs, names, Float64(t))
	plt
end

# ╔═╡ Cell order:
# ╠═457c5a08-f176-11ea-33ea-c99aad944d42
# ╠═6b544ae2-f176-11ea-3b54-abcdc6c0c1e1
# ╠═650274c2-f176-11ea-344b-a7d22b16bb3e
# ╠═712bc8fa-f176-11ea-34c9-2ba88534b36c
# ╠═74cd0802-f176-11ea-3014-3f0b3a9f2566
# ╠═8aacfd9e-f176-11ea-0f06-af34e63b97a0
# ╠═9cddda74-f176-11ea-0280-c79dc0ea7843
# ╠═b18e3072-f176-11ea-1b82-b3615cba5dc5
# ╠═bb11765e-f176-11ea-1825-098d46ab5fb9
# ╠═c2e983d0-f176-11ea-2af0-4197e2a2b156
# ╠═c798e9fc-f176-11ea-3e0c-97a8b7ee7433
# ╠═5f767f64-f177-11ea-2852-f7214fc25bc1
# ╠═ceb85e16-f176-11ea-1b03-5d9d3a612c78
# ╠═a02715b4-f177-11ea-0ab4-f5be7b5f2c8e
# ╠═00e2234a-f177-11ea-0c08-c9170cbfe7ee
# ╠═a4a0e188-f177-11ea-0b3a-e98baab08444