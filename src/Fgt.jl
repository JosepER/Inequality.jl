# Fgt.jl



###### Foster–Greer–Thorbecke indices #####
"""
    fgt(v, α, z)

Compute the Foster–Greer–Thorbecke Index of a vector `v` at a specified `α`
and a given poverty threshold `z`.

# Examples
```julia
julia> using Inequality
julia> fgt([8, 5, 1, 3, 5, 6, 7, 6, 3], 2, 4)
0.0763888888888889
```
"""
function fgt(v::AbstractVector{<:Real}, α::Real, z::Real)::Float64
    
    if α == 0
        return headcount(v, z)
    elseif α == 1
        return poverty_gap(v, z)
    else 
        return sum( ((1 .- (v[v .< z]/z)).^α) )/ length(v)
    end 
end 


###### Weighted Foster–Greer–Thorbecke indices #####
"""
    fgt(v, w, α, z)

Compute the Foster–Greer–Thorbecke Index of a vector `v` at a specified `α` and 
a given poverty threshold `z`, using weights given by a weight vector `w`.

Weights must not be negative, missing or NaN. The weights and data vectors must have the same length.

# Examples
```julia
julia> using Inequality
julia> fgt([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9), 2, 4)
0.05555555555555555
```
"""
function fgt(v::AbstractVector{<:Real}, w::AbstractVector{<:Real}, α::Real, z::Real)::Float64
    
    if α == 0
        return headcount(v, w, z)
    elseif α == 1
        return poverty_gap(v, w, z)
    else 
        checks_weights(v, w)

        return sum(((1 .- (v[v .< z] /z)).^α) .* w[v .< z])/ sum(w)
    end
end


function fgt(v::AbstractVector{<:Real}, w::AbstractWeights, α::Real, z::Real)::Float64
    
    if α == 0
        return headcount(v, w, z)
    elseif α == 1
        return poverty_gap(v, w, z)
    else 
        checks_weights(v, w)

        return sum(((1 .- (v[v .< z] /z)).^α) .* w[v .< z] )/ w.sum
    end
end


"""
wfgt(v, w)

Compute the Foster–Greer–Thorbecke Index of `v` with weights `w`. See also [`fgt`](@fgt)
"""
wfgt(v::AbstractVector{<:Real}, w::AbstractVector{<:Real}, α::Real, z::Real)::Float64 = fgt(v, w, α, z)

wfgt(v::AbstractVector{<:Real}, w::AbstractWeights, α::Real, z::Real)::Float64 = fgt(v, w, α, z)