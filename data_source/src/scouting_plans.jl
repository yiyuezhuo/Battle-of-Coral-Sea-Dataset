
scouting_plans = [
    (
        name="MO Carrier Striking force 4 May",
        sp="MO Carrier Striking force", st=(4, 8, 0), et=(4, 11, 50),
        dist=460*1000, rot=90, rot_dist=37 * 1000, # default p
        paths=Dict(130=>(;), 140=>(;), 150=>(;))
    ),
    (
        name="MO Carrier Striking force 5 May",
        sp="MO Carrier Striking force", st=(5, 4, 0), et=(5, 9, 0),
        dist=560*1000, rot=90, rot_dist=46 * 1000,
        paths=Dict(
            130=>(;), 140=>(;), 150=>(;), 160=>(;), 170=>(;), 180=>(;),
            105=>(dist=290*1000,), 120=>(dist=460*1000,), 190=>(dist=460*1000,), 200=>(dist=290*1000,)
        )
    ),
    (
        name="MO Carrier Striking force 7 May Morning",
        sp="MO Carrier Striking force", st=(7, 4, 0), et=(7, 10, 30),
        dist=463*1000, rot=90,
        paths=Dict(
            180=>(rot_dist=55560,), 200=>(rot_dist=55560,), 220=>(rot_dist=55560,), # Zuikaku
            235=>(rot_dist=74*1000,), 250=>(rot_dist=74*1000,), 265=>(rot_dist=74*1000,) # Shōkaku
        )
    ),
    #= scouting afternoon 7 May, lack of infomation?
    (
        name="MO Carrier Striking force 7 May Afternoon",
        sp="MO Carrier Striking force", st=(7, 4, 0), et=(7, 10, 30),
        dist=463*1000, rot=90,
        paths=Dict(
            130=>(rot_dist=55560), 180=>(55560), 200=>(55560), # Zuikaku
            235=>(rot_dist=74*1000), 250=>(rot_dist=74*1000), 265=>(rot_dist=74*1000) # Shōkaku
        )
    ),
    =#
    (
        name="Rossel 7 May",
        sp=(154, -11), st=(7, 4, 0), et=(7, 10, 30), # concrete time?
        dist=277800, rot=90, rot_dist= 100 * 1000, # unknown rot_dist, make it determined automatically?
        paths=Dict(
            90=>(;), 130=>(;), 170=>(;), 210=>(;)
        )
    ),
    (
        name="Deboyne 7 May",
        sp=(152.4, -10.6), st=(7, 4, 0), et=(7, 10, 30), # concrete time?
        dist=463000, rot=90, rot_dist= 200 * 1000, # unknown rot_dist, make it determined automatically?
        paths=Dict(
            160=>(;), 195=>(;), 230=>(;) # squadron number?
        )
    ),
    (
        name="Rabual 5 May",
        sp=(152.2, -4.2), st=(7, 4, 0), et=(17, 10, 30), # concrete time?
        dist=1300*1000, rot=90, rot_dist=200*1000,
        paths=Dict(
            165=>(;), 177=>(;), 190=>(;)
        )
    )
]
