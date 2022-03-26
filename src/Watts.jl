# Watts.jl

###### watts #####
"""
    watts(v, k)

    Compute the Watts Poverty Index of a vector `v` at a specified absolute 
    poverty line `k`.

# Examples
```jldoctest
julia> using Inequality
julia> watts([8, 5, 1, 3, 5, 6, 7, 6, 3], 4)
0.217962056224828
```
"""
watts(v::Array{<:Real,1}, k::Real)::Float64 = length(v[v .< k]) == 0 ?  0. : sum(log.(k./v[v .< k]))/length(v)


###### weighted watts #####
"""
    watts(v, w, α)

Compute the Watts Poverty Index of a vector `v` at a specified absolute 
poverty line `α`, using weights given by a weight vector `w`.

Weights must not be negative, missing or NaN. The weights and data vectors must have the same length.

# Examples
```jldoctest
julia> using Inequality
julia> watts([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9), 4)
0.17552777833850716
```
"""
function watts(v::Array{<:Real,1}, w::Array{<:Real,1}, α::Real)::Float64
    
    checks_weights(v, w)

    length(v) == 0 ? (return 0) : nothing
    
    return sum( (log.(α./(v[v .< α]))) .* w[v .< α] ) / sum(w)

end


function watts(v::Array{<:Real,1}, w::AbstractWeights, α::Real)::Float64
    
    checks_weights(v, w)

    length(v) == 0 ? (return 0) : nothing
    
    return sum( (log.(α./(v[v .< α]))) .* w[v .< α] ) / sum(w)

end



"""
    wwatts(v, w, α)

Compute the Watts Poverty Index of `v` with weights `w`. See also [`watts`](@watts)
"""
wwatts(v::Array{<:Real,1}, w::Array{<:Real,1}, α::Real)::Float64 = watts(v, w, α)