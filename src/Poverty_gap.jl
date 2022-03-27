# Poverty_gap.jl

###### poverty_gap #####
"""
    poverty_gap(v, z)

Compute the Poverty Gap of a vector `v` at a specified poverty threshold `z`.

# Examples
```julia
julia> using Inequality
julia> poverty_gap([8, 5, 1, 3, 5, 6, 7, 6, 3], 4)
0.1388888888888889
```
"""
poverty_gap(v::Array{<:Real,1}, z::Real)::Float64 = sum((z .- v[v .< z])/z)/length(v)


###### weighted poverty_gap #####
"""
    poverty_gap(v, w, z)

Compute the Poverty Gap of a vector `v` at a specified poverty threshold `z`, 
using weights given by a weight vector `w`.

Weights must not be negative, missing or NaN. The weights and data vectors must have the same length.

# Examples
```julia
julia> using Inequality
julia> poverty_gap([8, 5, 1, 3, 5, 6, 7, 6, 3], [0.1,0.5,0.3,0.8,0.1,0.5,0.3,0.8,0.2], 4)
0.13194444444444445
```
"""
function poverty_gap(v::Array{<:Real,1}, w::Array{<:Real,1}, z::Real)::Float64
    checks_weights(v, w)

    return sum((z .- v[v .< z])/z .* w[v .< z])/sum(w)
end


function poverty_gap(v::Array{<:Real,1}, w::AbstractWeights, z::Real)::Float64
    checks_weights(v, w)

    return sum((z .- v[v .< z])/z .* w[v .< z])/w.sum
end


wpoverty_gap(v::Array{<:Real,1}, w::Array{<:Real,1}, z::Real)::Float64 = poverty_gap(v, w, z)

wpoverty_gap(v::Array{<:Real,1}, w::AbstractWeights, z::Real)::Float64 = poverty_gap(v, w, z)