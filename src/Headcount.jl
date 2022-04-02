# Headcount.jl

###### headcount #####
"""
    headcount(v, z)

Compute the Headcount Ratio of a vector `v` at a specified poverty threshold `z`.

# Examples
```julia
julia> using Inequality
julia> headcount([8, 5, 1, 3, 5, 6, 7, 6, 3], 4)
0.3333333333333333
```
"""
headcount(v::AbstractVector{<:Real}, z::Real)::Float64 = length(v[v .< z]) / length(v)


###### weighted headcount #####
"""
    headcount(v, w, z)

Compute the Headcount Ratio of a vector `v` at a specified poverty threshold `z`, 
using weights given by a weight vector `w`.

Weights must not be negative, missing or NaN. The weights and data vectors must have the same length.

# Examples
```julia
julia> using Inequality
julia> headcount([8, 5, 1, 3, 5, 6, 7, 6, 3], [0.1,0.5,0.3,0.8,0.1,0.5,0.3,0.8,0.2], 4)
0.36111111111111116
```
"""
function headcount(v::AbstractVector{<:Real}, w::AbstractVector{<:Real}, z::Real)::Float64
    
    checks_weights(v, w)

    return sum(w[v .< z]) / sum(w)
end


function headcount(v::AbstractVector{<:Real}, w::AbstractWeights, z::Real)::Float64
    
    checks_weights(v, w)

    return sum(w[v .< z]) / w.sum

end


wheadcount(v::AbstractVector{<:Real}, w::AbstractVector{<:Real}, z::Real)::Float64 = headcount(v, w, z)

wheadcount(v::AbstractVector{<:Real}, w::AbstractWeights, z::Real)::Float64 = headcount(v, w, z)