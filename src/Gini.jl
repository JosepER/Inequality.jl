# Gini.jl



###### gini #####
"""
    gini(v)

Compute the Gini Coefficient of a vector `v` .

# Examples
```julia
julia> using Inequality
julia> gini([8, 5, 1, 3, 5, 6, 7, 6, 3])
0.2373737373737374
```
"""
gini(v::AbstractVector{<:Real})::Float64 = (2 * sum([x*i for (i,x) in enumerate(sort(v))]) / sum(sort(v)) - (length(v)+1))/(length(v))


###### weighted gini #####
"""
    gini(v, w)

Compute the weighted Gini Coefficient of a vector `v` using weights given by a weight vector `w`.

Weights must not be negative, missing or NaN. The weights and data vectors must have the same length.

# Examples
```julia
julia> using Inequality
julia> gini([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9))
0.20652395514780775
```
"""
function gini(v::AbstractVector{<:Real}, w::AbstractVector{<:Real})::Float64

    checks_weights(v, w)

    w = w[sortperm(v)]/sum(w)
    v = sort(v)
    p = cumsum(w)
    n = length(v)
    nᵤ = cumsum(w .* v)/cumsum(w .* v)[end]
    sum(nᵤ[2:end] .* p[1:(end-1)]) - sum(nᵤ[1:(end-1)] .* p[2:end])

end


function gini(v::AbstractVector{<:Real}, w::AbstractWeights)::Float64

    checks_weights(v, w)

    w = w[sortperm(v)]/w.sum
    v = sort(v)
    p = cumsum(w)
    n = length(v)
    nᵤ = cumsum(w .* v)/cumsum(w .* v)[end]
    sum(nᵤ[2:end] .* p[1:(end-1)]) - sum(nᵤ[1:(end-1)] .* p[2:end])

end


"""
    wgini(v, w)

Compute the Gini Coefficient of `v` with weights `w`. See also [`gini`](@gini)
"""
wgini(v::AbstractVector{<:Real}, w::AbstractVector{<:Real}) = gini(v, w)

wgini(v::AbstractVector{<:Real}, w::AbstractWeights) = gini(v, w)
