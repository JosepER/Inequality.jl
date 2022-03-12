# Gini.jl



###### gini #####
"""
gini(v)

Compute the Gini Coefficient of a vector `v` .

# Examples
```jldoctest
julia> gini([8, 5, 1, 3, 5, 6, 7, 6, 3])
0.2373737373737374
```
"""
gini(v::Array{<:Real,1})::Float64 = (2 * sum([x*i for (i,x) in enumerate(sort(v))]) / sum(sort(v)) - (length(v)+1))/(length(v))


###### weighted gini #####
"""
Compute the weighted Gini Coefficient of a vector `v` using weights given by a weight vector `w`.
Weights must not be negative, missing or NaN. The weights and data vectors must have the same length.

# Examples
```jldoctest
julia> gini([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9))
0.20652395514780775
```
"""
function gini(v::Array{<:Real,1}, w::Array{<:Real,1})::Float64

    checks_weights(v, w)

    w = w[sortperm(v)]/sum(w)
    sort!(v)
    p = cumsum(w)
    n = length(v)
    nᵤ = cumsum(w .* v)/cumsum(w .* v)[end]
    sum(nᵤ[2:end] .* p[1:(end-1)]) - sum(nᵤ[1:(end-1)] .* p[2:end])

end

"""
wgini(v, w)

Compute the Gini Coefficient of `v` with weights `w`. See the documentation for `gini()`
"""
wgini(v::Array{<:Real,1}, w::Array{<:Real,1}) = gini(v, w)