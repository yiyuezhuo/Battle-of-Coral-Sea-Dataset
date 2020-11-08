Rabaul = (152.1, -4.1)
Lae = (147., -6.6)
Shortland = (155.8, -7.1)
Tulagi = (160.2, -9.1)
Moresby = (147.15, -9.3)
Cooktown = (145.2, -15.4)
Townsville = (146.45, -19.1)
Efate = (168.4, -17.5)
Noumea = (166.2, -22.0)
Deboyne = (152.4, -10.6)

locs = (;Rabaul, Lae, Shortland, Tulagi, Moresby, Cooktown, Townsville, Efate, Noumea,
    Deboyne)
locs_dict = Dict([string(key)=>loc for (key, loc) in zip(keys(locs), locs)])

plan_PQRYZ_KOO = (
	P=(base="Rabaul", bearing=(45, 75), distance=965.6, num=2), 
	# 600 mi ≈ 965.6km, other source gives distance = 1100km, but the KOO distance is not given, so I use 600mi and 650mi
	Q=(base="Rabaul", bearing=(75, 105), distance=965.6, num=2),
	R=(base="Rabaul", bearing=(135, 165), distance=965.6, num=2),
	Y=(base="Lae", bearing=(130, 160), distance=965.6, num=2),
	Z=(base="Lae", bearing=(160, 190), distance=965.6, num=2),
	KOO=(base="Rabaul", bearing=(170, 210), distance=1046.07, num=3)
)

# The order was issuesd on 29 April, but Tulagi was occupied on 3 May (the patrol started from 5 May)
# It may be infered that distance=965.6 as well from other source.
plan_ABCDEFGI = (
	A=(base="Lae", bearing=(124, 190), distance=1100, num=5),
	B=(base="Rabaul", bearing=(135, 172), distance=1100, num=4),
	C=(base="Rabaul", bearing=(53, 115), distance=1100, num=4),
	D=(base="Shortland", bearing=(100, 194), distance=1100, num=4),
	E=(base="Shortland", bearing=(45, 100), distance=1100, num=4), # unknown num, use 4 as a trade-off between other average value
	F=(base="Tulagi", bearing=(95, 225), distance=1100, num=11),
	G=(base="Tulagi", bearing=(45, 95), distance=1100, num=5),
	I=(base="Deboyne", bearing=(155, 180), distance=1100, num=2)
)

# Altnative distance record
plan_ABCDEFGI_short = (;zip(keys(plan_ABCDEFGI), [(;t..., distance=965.6) for t in plan_ABCDEFGI])...)

plan_allied_late = (
	Moresby=(base="Moresby", bearing=(45, 115), distance=772.485, num=5), # 480miles ≈ 772.485km. Num is unknown, should be range from 3~7.
	Townsville=(base="Townsville", bearing=(20,90), distance=804.672, num=7), # num unknown, , 500miles ≈ 804.672. TODO: twice a day
	Noumea_late_wn = (base="Noumea", bearing=(305, 360), distance=1100, num=6),
	Noumea_late_en = (base="Noumea", bearing=(11, 30), distance=600, num=1)
)

# before 5 May
plan_allied_early = (
    Moresby=plan_allied_late.Moresby,
    Townsville=plan_allied_late.Townsville,
    # Noumea_early=(base="Noumea", bearing=340, distance=1126.54, edge=[-80.4672, 80.4672]), # 700mi ≈ 1126.53km, 50mi ≈ 80.4672km
    Noumea_early=(base="Noumea", bearing=340, distance=1250., edge=[-80.4672, 80.4672]), # This distance match the refered figure better anyway...
)
