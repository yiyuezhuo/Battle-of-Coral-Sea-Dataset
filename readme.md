# The Battle of Coral Sea dataset

The dataset include fleet moving and scouting record. The data is not ensured to be very accurate, but the error will not be too large.

I build the dataset for my own research.

## Examples

### Julia

#### Trace graph

```julia

using BattleOfCoralSeaUtils

tl = load_dataset("fleets.json")
tra_l = Trajectory.(tl)

plt = show_crop(sp50, 150, -20, 165, 0, raw=true)
show_trace!(tra_l)
plt
```

#### Interpolate

```julia
get_pos(interpolate_records(tra_l[1].seq), 6500.)
# [157.742, -4.69623]
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
