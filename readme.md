# The Battle of Coral Sea dataset

The dataset include fleet moving and scouting record. The data is not ensured to be very accurate, but the error will not be too large.

I build the dataset for my own research purpose.

## Examples

### Julia

#### Trace graph

```julia

using BattleOfCoralSeaUtils

fleets = load_dataset("fleets.json")
trajectories = Trajectory.(tl)

sp50 = load_shapefile()

plt = show_crop(sp50, 150, -20, 165, 0, raw=true)
show_trace!(trajectories)
plt
```

#### Interpolate

```julia
get_pos(interpolate_records(trajectories[1].seq), 6500.)
# [157.742, -4.69623]

seqs = map(x->interpolate_records(x.seq), trajectories)
names = map(x->x.name, trajectories)

# Plot trace with fleet position in timestamp 6500 ()
plt = show_crop(sp50, 150, -20, 165, 0, raw=true)
show_trace!(trajectories)
show_fleets!(seqs, names, time_stamp_to_float(5, 12, 0)) # 12:00 5 May
plt
```

#### Pluto animation

### Python

WIP

## Pitfall

Some subtle movements are just ignored. For example, IJN covering force are concentrated at Deboyne Islands for several days, with many single ship movement. I just treat them as they had docked at Deboyne Islands until 06:30 7 May. Some small detachments is also treated as they just never happened, hence fleet looks too "perfect" acting as a whole.

## References

* The First Team: Pacific Naval Air Combat from Pearl Harbor to Midway
* THE CORAL SEA 1942: the first carrier battle
* 碧血南洋: 美日珊瑚海海战
* http://www.delsjourney.com/uss_neosho/coral_sea/battle_of_coral_sea/summary.htm
* https://en.wikipedia.org/wiki/Battle_of_the_Coral_Sea
