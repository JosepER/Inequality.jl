# Atkinson.jl


###### atkinson #####
"""
    atkinson(v, ϵ)

Compute the Atkinson Index of a vector `v` at a specified inequality 
aversion parameter `ϵ`.

# Examples
```julia
julia> using Inequality
julia> atkinson([8, 5, 1, 3, 5, 6, 7, 6, 3], 1.2)
0.1631765870035865
```
"""
function atkinson(v::AbstractVector{<:Real}, ϵ::Real)::Float64

    ϵ >= 0 ? nothing : throw(ArgumentError("`ϵ` must be larger or equal than 0"))

    if ϵ == 1
        v = v[v .!= 0]
        return 1 - (exp.(mean(log.(v)))/mean(v))
    elseif ϵ < 1
        return 1 - mean( (v./mean(v)).^(1-ϵ) ).^(1/(1-ϵ))
    else
        v = v[v .!= 0]
        return 1 - mean( (v./mean(v)).^(1-ϵ) ).^(1/(1-ϵ))
    end 
end


###### weighted atkinson #####
"""
    atkinson(v, w, ϵ)

Compute the weighted Atkinson Index of a vector `v` at a specified inequality 
aversion parameter `ϵ`, using weights given by a weight vector `w`.

Weights must not be negative, missing or NaN. The weights and data vectors must have the same length.

# Examples
```julia
julia> using Inequality
julia> atkinson([8, 5, 1, 3], [0.1,0.5,0.3,0.8], 1.2)
0.1681319821792493
```
"""
function atkinson(v::AbstractVector{<:Real}, w::AbstractVector{<:Real}, ϵ::Real)::Float64

    ϵ >= 0 ? nothing : throw(ArgumentError("`ϵ` must be larger or equal than 0"))
    checks_weights(v, w)
   
    v = v/Statistics.mean(v)
    w = w/sum(w)
 
    if ϵ == 1
        w = w[v .!= 0]
        v = v[v .!= 0]

        return 1 - (prod(exp.(w .* log.(v)))/sum(v .* w) )
    elseif ϵ < 1
        return 1-(sum(((v/sum(v.* w)).^(1-ϵ)).*w)).^(1/(1-ϵ))
    else 
        w = w[v .!= 0]
        v = v[v .!= 0]
        
        return 1-(sum(((v/sum(v.* w)).^(1-ϵ)).*w)).^(1/(1-ϵ))
    end
end




function atkinson(v::AbstractVector{<:Real}, w::AbstractWeights, ϵ::Real)::Float64

    ϵ >= 0 ? nothing : throw(ArgumentError("`ϵ` must be larger or equal than 0"))
    checks_weights(v, w)
   
    v = v/Statistics.mean(v)
    w = w/w.sum
 
    if ϵ == 1
        w = w[v .!= 0]
        v = v[v .!= 0]

        return 1 - (prod(exp.(w .* log.(v)))/sum(v .* w) )
    elseif ϵ < 1
        return 1-(sum(((v/sum(v.* w)).^(1-ϵ)).*w)).^(1/(1-ϵ))
    else 
        w = w[v .!= 0]
        v = v[v .!= 0]
        
        return 1-(sum(((v/sum(v.* w)).^(1-ϵ)).*w)).^(1/(1-ϵ))
    end
end


"""
    watkinson(v, w, p)

Compute the atkinson index of `v` with weights `w` and inequality aversion parameter 'ϵ'. See also [`atkinson`](@atkinson)
"""
watkinson(v::AbstractVector{<:Real}, w::AbstractVector{<:Real}, ϵ::Real) = atkinson(v, w, ϵ)

watkinson(v::AbstractVector{<:Real}, w::AbstractWeights, ϵ::Real) = atkinson(v, w, ϵ)