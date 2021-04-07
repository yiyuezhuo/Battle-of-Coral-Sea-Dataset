# km
# st = start time, et = end time

scouting_plans = [
    (
        name="MO Carrier Striking force 4 May",
        sp="MO Carrier Striking force", st=(4, 8, 0), et=(4, 11, 50),
        dist=460, rot=90, rot_dist=37, # default p
        paths=Dict(130=>(;), 140=>(;), 150=>(;))
    ),
    (
        name="MO Carrier Striking force 5 May",
        sp="MO Carrier Striking force", st=(5, 4, 0), et=(5, 9, 0),
        dist=300mi, rot=90, rot_dist=25mi,
        paths=Dict(
            130=>(;), 140=>(;), 150=>(;), 160=>(;), 170=>(;), 180=>(;),
            105=>(dist=160mi, rot_dist=30mi), 120=>(dist=250mi,), 
            190=>(dist=250mi,), 200=>(dist=160mi, rot_dist=30mi)
        )
    ),
    (
        name="MO Carrier Striking force 7 May Morning",
        sp="MO Carrier Striking force", st=(7, 4, 0), et=(7, 10, 30),
        dist=463, rot=-90,
        paths=Dict(
            180=>(rot_dist=40mi,), 200=>(rot_dist=40mi,), 220=>(rot_dist=40mi,), # Shōkaku
            235=>(rot_dist=30mi,), 250=>(rot_dist=30mi,), 265=>(rot_dist=30mi,)  # Zuikaku
        )
    ),
    # scouting afternoon 7 May
    (
        name="MO Carrier Striking force 7 May Afternoon",
        sp="MO Carrier Striking force", st=(7, 12, 40), et=(7, 16, 30),
        dist=500, rot=-90, rot_dist=37,
        paths=Dict(
            270=>(;), 290=>(;), # Zuikaku
            230=>(;), 250=>(;)  # Shōkaku
        )
    ),
    # scouting & striking afternoon 7 May
    (
        name="MO Carrier Striking force 7 May Afternoon 2",
        sp="MO Carrier Striking force", st=(7, 14, 15), et=(7, 19, 0), 
        # et is "complex" due to fight and night landing, the value is selected just for "notification" purpose.
        dist=500, rot=0, rot_dist=0, # distance is "complex" as well, just like et
        path=Dict(
            277=>(;)
        )
    ),
    (
        name="MO Carrier Striking force 8 May",
        sp="MO Carrier Striking force", st=(8, 4, 0), et=(8, 9, 50),
        # Is it better to use different et for different angle?
        dist=250mi, rot=90, rot_dist=30mi, # rot=90 or -90?
        path=Dict(
            140=>(;), 155=>(;), 170=>(;), # Zuikaku
            185=>(;), 200=>(;), 215=>(;), 230=>(;) # Shōkaku, 
            # 200 will detect TF17, is it necessary to denote "tracking" state?
        )
    ),
    (
        name="Rossel 7 May", # CA Kinugasa and Furutaka's sea planes
        sp=Rossel, st=(7, 4, 0), et=(7, 10, 30), # concrete time?
        dist=150mi, rot=90, rot_dist= 100, # unknown rot_dist, make it determined automatically?
        paths=Dict(
            90=>(;), 130=>(;), 170=>(;), 210=>(;)
        )
    ),
    (
        name="Deboyne 7 May",
        sp=Deboyne, st=(7, 4, 0), et=(7, 10, 30), # concrete time?
        dist=463, rot=90, rot_dist= 200, # unknown rot_dist, make it determined automatically?
        paths=Dict(
            160=>(;), 195=>(;), 230=>(;) # squadron number?
        )
    ),
    (
        # Deboyne just duplicate plan from 7 May on 8 May
        name="Deboyne 8 May",
        sp=Deboyne, st=(7, 4, 0), et=(7, 10, 30), # concrete time?
        dist=463, rot=90, rot_dist= 200, # unknown rot_dist, make it determined automatically?
        paths=Dict(
            160=>(;), 195=>(;), 230=>(;) # squadron number?
        )
    ),
    #=
    (
        name="Rabaul 5 May",
        sp=(152.2, -4.2), st=(7, 4, 0), et=(17, 10, 30), # concrete time?
        dist=1300, rot=90, rot_dist=200,
        paths=Dict(
            165=>(;), 177=>(;), 190=>(;)
        )
    )
    =#
    (
        name="Rabaul 8 May",
        sp=Rabaul, st=(8, 4, 30), et=(8, 14, 30), 
        # et is not known. Assuming cruise speed 150kn (cruise speed of Nell) and 1490mi distance, thus almost 10 hours.
        dist=700mi, rot=-90, rot_dist=60mi,
        paths=Dict(
            170=>(;), 190=>(;), 200=>(;)
        )
    ),
    (
        name="Tulagi 8 May",
        sp=Tulagi, st=(8, 4, 30), et=(8, 15, 30),
        # st is not known, assume it follows action of Rabaul. et is inferred by 1290mi and 120kn (cruise speed of Mavis), thus 11 hours.
        # spel wrong, is it dectected? woorong thing.
        dist=600mi, rot=-90, rot_dist=60mi,
        paths=Dict(
            215=>(;), 225=>(;), 235=>(;)
        )
    ),

    # Allied scouting plans, lack of information
    #=
    (
        name="TF17 8 May, north",
        sp="TF17_3", st=(8, 4, 25), et=(),
        dist=370, 
    )
    =#
]
