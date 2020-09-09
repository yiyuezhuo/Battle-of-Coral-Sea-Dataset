# Julia package `BattleOfCoralSeaGP`

Use `Stheno` to do some Gaussian Process analysis.

## Performance of three kernel

```julia

using Stheno
using BattleOfCoralSeaGP
using BenchmarkTools

xv = range(150, 160, length=50)
yv = range(-7.5, -2.5, length=50)
gxy = ColVecs(grid_xy(xv, yv))

@benchmark begin
    f = GP(EQ(), GPC())
    rand_f = arg_grid_xy(rand(f(gxy, 1e-9)), xv, yv)
end
#=
BenchmarkTools.Trial: 
  memory estimate:  190.83 MiB
  allocs estimate:  32
  --------------
  minimum time:     183.138 ms (3.48% GC)
  median time:      184.108 ms (3.51% GC)
  mean time:        185.722 ms (4.55% GC)
  maximum time:     190.661 ms (6.92% GC)
  --------------
  samples:          27
  evals/sample:     1
=#

@benchmark begin
    f = GP(kernel(ExpHaversine(EARTH_RADIUS), l=1000), GPC())
    rand_f = arg_grid_xy(rand(f(gxy, 1e-9)), xv, yv)
end
#=
BenchmarkTools.Trial: 
  memory estimate:  190.85 MiB
  allocs estimate:  34
  --------------
  minimum time:     255.893 ms (2.84% GC)
  median time:      258.448 ms (2.52% GC)
  mean time:        259.749 ms (3.24% GC)
  maximum time:     264.604 ms (4.81% GC)
  --------------
  samples:          20
  evals/sample:     1
=#

@benchmark begin
    f = GP(kernel(ExpGeodesics(), l=1000), GPC())
    rand_f = arg_grid_xy(rand(f(gxy, 1e-9)), xv, yv)
end
#=
BenchmarkTools.Trial: 
  memory estimate:  190.85 MiB
  allocs estimate:  34
  --------------
  minimum time:     2.188 s (0.29% GC)
  median time:      2.190 s (0.30% GC)
  mean time:        2.191 s (0.31% GC)
  maximum time:     2.194 s (0.30% GC)
  --------------
  samples:          3
  evals/sample:     1
=#
```
