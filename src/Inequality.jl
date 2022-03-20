module Inequality

    using Statistics 
    using StatsBase: mean, weights

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
        wtheil,
        entropy,
        wentropy

    include("Atkinson.jl")
    include("Gini.jl")
    include("Lorenz.jl")
    include("Mld.jl")
    include("Watts.jl")
    include("Theil.jl")
    include("Entropy.jl")

end # module
