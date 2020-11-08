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

