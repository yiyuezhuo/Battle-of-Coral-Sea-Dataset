
function make(output_root=".")

    fleets_path = joinpath(output_root, "fleets.json")
    scouting_plans_path = joinpath(output_root, "scouting_plans.json")

    open(fleets_path, "w") do f
        write(f, json(fleets))
    end

    open(scouting_plans_path, "w") do f
        write(f, json(scouting_plans))
    end

    println("Write $(abspath(fleets_path))")
    println("Write $(abspath(scouting_plans_path))")
end