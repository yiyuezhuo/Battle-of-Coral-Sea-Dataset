

plan_PQRYZ_KOO = (
	P=(base="Rabaul", bearing=(45, 75), distance=600mi, num=2), 
	# While other source gives distance = 1100km, but the KOO radius is not given in that source,
	#  so I use 600mi and 650mi
	Q=(base="Rabaul", bearing=(75, 105), distance=600mi, num=2),
	R=(base="Rabaul", bearing=(135, 165), distance=600mi, num=2),
	Y=(base="Lae", bearing=(130, 160), distance=600mi, num=2),
	Z=(base="Lae", bearing=(160, 190), distance=600mi, num=2),
	KOO=(base="Rabaul", bearing=(170, 210), distance=650mi, num=3)
)

# The order was issuesd on 29 April, but Tulagi was occupied on 3 May (the patrol started from 5 May)
# It may be inferred that distance=600mi as well from other source.
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
plan_ABCDEFGI_short = (;zip(keys(plan_ABCDEFGI), [(;t..., distance=600mi) for t in plan_ABCDEFGI])...)

plan_allied_late = (
	Moresby=(base="Moresby", bearing=(45, 115), distance=480mi, num=5), # Num is unknown, should be range from 3~7.
	Townsville=(base="Townsville", bearing=(20,90), distance=500mi, num=7), # num unknown, TODO: way to denote twice a day
	Noumea_late_wn = (base="Noumea", bearing=(305, 360), distance=1100, num=6),
	Noumea_late_en = (base="Noumea", bearing=(11, 30), distance=600, num=1)
)

# before 5 May
plan_allied_early = (
    Moresby=plan_allied_late.Moresby,
    Townsville=plan_allied_late.Townsville,
	Noumea_early=(base="Noumea", bearing=340, distance=700mi, edge=[-50mi, 50mi]), 
)
