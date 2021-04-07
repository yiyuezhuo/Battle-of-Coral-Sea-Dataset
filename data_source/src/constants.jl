const mi = 1.852 # 1 nautical miles = 1.852km

# We will use something like `300mi` to match literature.
# Note in Naval Battle literature, `mi` denote nautical mile instead of mile.

const Rabaul = (152.1, -4.1)
const Lae = (147., -6.6)
const Shortland = (155.8, -7.1)
const Tulagi = (160.2, -9.1)
const Moresby = (147.15, -9.3)
const Cooktown = (145.2, -15.4)
const Townsville = (146.45, -19.1)
const Efate = (168.4, -17.5)
const Noumea = (166.2, -22.0)
const Deboyne = (152.4, -10.6)
const Rossel = (154.1, -11.3)

const locs = (;Rabaul, Lae, Shortland, Tulagi, Moresby, Cooktown, Townsville, Efate, Noumea,
    Deboyne, Rossel)
const locs_dict = Dict([string(key)=>loc for (key, loc) in zip(keys(locs), locs)])
