# The Battle of Coral Sea dataset

The dataset include fleet moving and scouting record. The data is not ensured to be very accurate, but the error will not be too large.

I build the dataset for my own research purpose.

## `make` data

Raw data is written in Julia to make editing easier. Further DSL may be employed.

```julia
using BattleOfCoralSeaData

make() # generate `*.json` files into workspace.
```

## Usage examples

### Julia

#### Trace graph

```julia

using BattleOfCoralSeaUtils

fleets = load_dataset("fleets.json")
trajectories = Trajectory.(fleets)

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

#### Scouting plans

`Plan` means path if scouting unit doesn't find any target.

```julia
scouting_plans = load_dataset("scouting_plans.json")
name_to_record_int_vec = Dict(tra.name => seq for (tra, seq) in zip(trajectories, seqs))
expanded_plans = expand_plans(scouting_plans, name_to_record_int_vec)

expanded_plans["MO Carrier Striking force 4 May"]
#=
3-element Array{BattleOfCoralSeaUtils.ScoutingPlan,1}:
 BattleOfCoralSeaUtils.ScoutingPlan(6240.0, (157.77770745902433, -3.777813966196954), 6470.0, (158.09957154727985, -5.30227744276514), 140.0, 460.0, 90.0, 37.0)
 BattleOfCoralSeaUtils.ScoutingPlan(6240.0, (157.77770745902433, -3.777813966196954), 6470.0, (158.09957154727985, -5.30227744276514), 130.0, 460.0, 90.0, 37.0)
 BattleOfCoralSeaUtils.ScoutingPlan(6240.0, (157.77770745902433, -3.777813966196954), 6470.0, (158.09957154727985, -5.30227744276514), 150.0, 460.0, 90.0, 37.0)
=#

# It may looks quite messy :< .

using Plots

r = forward_deg(160, -9, 90, 370)[1] - 160

plt = plot() 
show_crop!(sp50, 147.5, -20, 167.5, 0, raw=true)
show_trace!(trajectories)
plot_expanded_plans!(expanded_plans)
plot_circle!(160, -9, r)
plt
```

#### Pluto animation

### Python

WIP

## Pitfall

Some subtle movements are just ignored. For example, IJN covering force were being concentrated at Deboyne Islands for several days, with many sole ship movement. I just treat them as they had docked at Deboyne Islands until 06:30 7 May. Some small detachments, such as destroyer used to rescue pilot, is also treated as they just never happened, hence fleet looks too "perfect" acting as a whole.


## References

* [THE BATTLE OF THE CORAL SEA, MAY 1 TO MAY 11 INCLUSIVE, 1942. STRATEGICAL AND TACTICAL ANALYSIS](https://apps.dtic.mil/dtic/tr/fulltext/u2/a003053.pdf)
* [Army operations in the South Pacific area: Papua campaigns, 1942–1943](http://ajrp.awm.gov.au/ajrp/ajrp2.nsf/translat-print/0975972E51CE4820CA257057001AEF9B?OpenDocument#con6.1)
* [North Eastern Area Headquarters - Report on Coral Sea battle
](https://recordsearch.naa.gov.au/SearchNRetrieve/Interface/ViewImage.aspx?B=703383)
* [戦史叢書第014巻　南太平洋陸軍作戦＜1＞ポートモレスビー・ガ島初期作戦](http://www.nids.mod.go.jp/military_history_search/CrossSearch)
* [戦史叢書第049巻　南東方面海軍作戦＜1＞ガ島奪回作戦開始まで](http://www.nids.mod.go.jp/military_history_search/CrossSearch)
* Black Shoe Carrier Admiral: Frank Jack Fletcher at Coral Sea, Midway & Guadalcanal
* The First Team: Pacific Naval Air Combat from Pearl Harbor to Midway
* THE CORAL SEA 1942: the first carrier battle
* 碧血南洋: 美日珊瑚海海战
* http://www.delsjourney.com/uss_neosho/coral_sea/battle_of_coral_sea/summary.htm
* https://en.wikipedia.org/wiki/Battle_of_the_Coral_Sea
