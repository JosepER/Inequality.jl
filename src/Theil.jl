# Theil.jl

###### theil #####
"""
    theil(v)

    Compute the Theil Index of a vector `v`.

# Examples
```julia
julia> using Inequality
julia> theil([8, 5, 1, 3, 5, 6, 7, 6, 3])
0.10494562214323544
```
"""
theil(v::Array{<:Real,1})::Float64 = sum(v .* log.(v/Statistics.mean(v))) / sum(v)


###### weighted theil #####
"""
    theil(v, w)

Compute the Theil Index of a vector `v`, using weights given by a weight vector `w`.

Weights must not be negative, missing or NaN. The weights and data vectors must have the same length.

# Examples
```julia
julia> using Inequality
julia> theil([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9))
0.08120013911680612
```
"""
function theil(v::Array{<:Real,1}, w::Array{<:Real,1})::Float64
    
    checks_weights(v, w)

    w = w[v .!= 0]
    v = v[v .!= 0]

    w = w/sum(w)
    v = v / sum(v .* w) 
    return sum(v .* w .* log.(v))
end


function theil(v::Array{<:Real,1}, w::AbstractWeights)::Float64
    
    checks_weights(v, w)

    w = w[v .!= 0]
    v = v[v .!= 0]

    w = w/w.sum
    v = v / sum(v .* w) 
    return sum(v .* w .* log.(v))
end


"""
    wtheil(v, w)

Compute the Theil Index of `v` with weights `w`. See also [`theil`](@theil)
"""
wtheil(v::Array{<:Real,1}, w::Array{<:Real,1})::Float64 = theil(v,w) 

