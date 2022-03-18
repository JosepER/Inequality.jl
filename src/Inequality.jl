module Inequality

    using Statistics, StatsBase

    export 
        atkinson,
        watkinson,
        gini,
        wgini,
        lorenz_curve,
        wlorenz_curve,
        mld,
        wmld,
        watts,
        wwatts,
        theil,
        wtheil

    include("Atkinson.jl")
    include("Gini.jl")
    include("Lorenz.jl")
    include("Mld.jl")
    include("Watts.jl")
    include("Theil.jl")

end # module
