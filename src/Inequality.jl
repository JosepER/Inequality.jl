module Inequality

    using Statistics 
    using StatsBase: mean, AbstractWeights, weights

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
        gen_entropy,
        wgen_entropy

    include("Atkinson.jl")
    include("Gini.jl")
    include("Lorenz.jl")
    include("Mld.jl")
    include("Watts.jl")
    include("Theil.jl")
    include("Entropy.jl")
    include("Misc.jl")

end # module
