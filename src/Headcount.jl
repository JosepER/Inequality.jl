# Headcount.jl

###### headcount #####
"""
headcount(v, z)

Compute the headcount ratio of a vector `v` at a specified poverty threshold `z`.

# Examples
```jldoctest
julia> headcount([8, 5, 1, 3, 5, 6, 7, 6, 3], 4)
0.3333333333333333
```
"""
headcount(v::Array{<:Real,1}, z::Real)::Float64 = length(v[v .< z]) / length(v)


###### weighted headcount #####
"""
    headcount(v, w, z)

Compute the headcount ratio of a vector `v` at a specified poverty threshold `z`, 
using weights given by a weight vector `w`.

Weights must not be negative, missing or NaN. The weights and data vectors must have the same length.

# Examples
```jldoctest
julia> headcount([8, 5, 1, 3, 5, 6, 7, 6, 3], [0.1,0.5,0.3,0.8,0.1,0.5,0.3,0.8,0.2], 4)
0.36111111111111116
```
"""
function headcount(v::Array{<:Real,1}, w::Array{<:Real,1}, z::Real)::Float64
    
    checks_weights(v, w)

    return sum(w[v .< z]) / sum(w)
end


function headcount(v::Array{<:Real,1}, w::AbstractWeights, z::Real)::Float64
    
    checks_weights(v, w)

    return sum(w[v .< z]) / w.sum

end


wheadcount(v::Array{<:Real,1}, w::Array{<:Real,1}, z::Real)::Float64 = headcount(v, w, z)

wheadcount(v::Array{<:Real,1}, w::AbstractWeights, z::Real)::Float64 = headcount(v, w, z)