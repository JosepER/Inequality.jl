# Entropy.jl

###### generalized entropy #####
"""
    gen_entropy(v, α)

    Compute the Generalized Entropy Index of a vector `v` at a specified parameter `α`.

# Examples
```julia
julia> using Inequality
julia> gen_entropy([8, 5, 1, 3, 5, 6, 7, 6, 3], 2)
0.09039256198347094
```
"""
gen_entropy(v::Array{<:Real,1}, α::Real)::Float64 = α == 1 ? theil(v) : (α == 0) ? (mld(v)) : (1/(α * (α - 1)) * sum(((v./Statistics.mean(v)).^α .- 1) * (1/length(v))) )


###### weighted generalized entropy #####
"""
    gen_entropy(v, w, α)

Compute the Generalized Entropy Index of a vector `v`, using weights given by a weight vector `w` 
at a specified parameter `α`.

Weights must not be negative, missing or NaN. The weights and data vectors must have the same length.

# Examples
```julia
julia> using Inequality
julia> gen_entropy([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9), 2)
0.0709746654322026
```
"""
function gen_entropy(v::Array{<:Real,1},w::Array{<:Real,1}, α::Real)::Float64

    if α == 1
        return theil(v, w)
    elseif α == 0
        return mld(v, w)
    end

    checks_weights(v, w)  

    return 1/(α * (α - 1)) * sum(((v./(sum(v .* w)/sum(w)) ) .^ α .-1) .* (w/sum(w)))

end


function gen_entropy(v::Array{<:Real,1},w::AbstractWeights, α::Real)::Float64

    if α == 1
        return theil(v, w)
    elseif α == 0
        return mld(v, w)
    end

    checks_weights(v, w)  

    return 1/(α * (α - 1)) * sum(((v./(sum(v .* w)/sum(w)) ) .^ α .-1) .* (w/sum(w)))

end



"""
    wgen_entropy(v, w, α)

Compute the Generalized Entropy Index of `v` with weights `w` at a specified parameter `α`. See also [`gen_entropy`](gen_entropy)
"""
wgen_entropy(v::Array{<:Real,1},w::Array{<:Real,1}, α::Real)::Float64 = entropy(v,w,α)



