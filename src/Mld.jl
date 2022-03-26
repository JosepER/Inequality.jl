# Mld.jl


###### mld #####
"""
    mld(v)

Compute the Mean log deviation of a vector `v`.

# Examples
```jldoctest
julia> using Inequality
julia> mld([8, 5, 1, 3, 5, 6, 7, 6, 3])
0.1397460530936332
```
"""
mld(v::Array{<:Real,1})::Float64 = log(Statistics.mean(v[v .!= 0])) - Statistics.mean(log.(v[v .!= 0]))


###### weighted mld #####
"""
    mld(v, w)

Compute the weighted Mean log deviation of a vector `v` using weights given by a weight vector `w`.

Weights must not be negative, missing or NaN. The weights and data vectors must have the same length.

# Examples
```jldoctest
julia> using Inequality
julia> mld([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9))
0.10375545537468206
```
"""
function mld(v::Array{<:Real,1}, w::Array{<:Real,1})::Float64
    checks_weights(v, w)
    w = w[v .!= 0]
    v = v[v .!= 0]

    return -sum(w .* log.(v/mean(v, weights(w))) ) / sum(w)
end


function mld(v::Array{<:Real,1}, w::AbstractWeights)::Float64
    checks_weights(v, w)
    w = w[v .!= 0]
    v = v[v .!= 0]

    return -sum(w .* log.(v/mean(v, weights(w))))/ sum(w)
end

"""
    wmld(v, w)

Compute the Mean log deviationof `v` with weights `w`. See also [`mld`](@mld)
"""
wmld(v::Array{<:Real,1}, w::Array{<:Real,1}) = mld(v, w)