# Lorenz.jl

"""
   lorenz(v)

Compute the relative Lorenz Curve of a vector `v` . 

Returns two vectors. The first one contains the cumulative proportion of people. 
The second contains the cumulative share of income earned.

# Examples
```julia
julia> lorenz_curve([8, 5, 1, 3, 5, 6, 7, 6, 3])
([0.0, 0.1111111111111111, 0.2222222222222222, 0.3333333333333333, 0.4444444444444444, 0.5555555555555556, 0.6666666666666666, 0.7777777777777778, 0.8888888888888888, 1.0], 
│ [0.0, 0.022727272727272728, 0.09090909090909091, 0.1590909090909091, 0.2727272727272727, 0.38636363636363635, 0.5227272727272727, 0.6590909090909091, 0.8181818181818182, 1.0])
``` 
"""
function lorenz_curve(v::Array{<:Real,1})
   sort!(v)
   cumsum!(v,v)
   cumsum_x = Vector{Float64}(undef, length(v))
   cumsum_y = Vector{Float64}(undef, length(v))
   
   @inbounds for (i, val) in enumerate(v)
    cumsum_x[i] = i/length(v)
    cumsum_y[i] = val/v[end]
   end

   pushfirst!(cumsum_x, 0.0)
   pushfirst!(cumsum_y, 0.0)

   return cumsum_x, cumsum_y

end


"""
   lorenz(v, w)
Compute the weighted Lorenz Curve of a vector `v` using weights given by a weight vector `w`.

Weights must not be negative, missing or NaN. The weights and data vectors must have the same length.

Returns two vectors. The first one contains the cumulative proportion of weighted people. 
The second contains the cumulative share of income earned.

# Examples
```julia
julia> lorenz_curve([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9))
([0.0, 0.06666666666666667, 0.08888888888888889, 0.13333333333333333, 0.2222222222222222, 0.3333333333333333, 0.5333333333333333, 0.6666666666666666, 0.8444444444444444, 1.0],
[0.0, 0.013761467889908256, 0.05045871559633028, 0.0963302752293578, 0.1513761467889908, 0.2660550458715596, 0.38990825688073394, 0.555045871559633, 0.7752293577981653, 1.0])
``` 
"""
function lorenz_curve(v::Array{<:Real,1}, w::Array{<:Real,1})

    checks_weights(v, w)

    v = v .* w

    w = w[sortperm(v)]/sum(w)
    sort!(v)
    
    cumsum!(v,v)
    cumsum!(w,w)

    cumsum_x = Vector{Float64}(undef, length(v))
    cumsum_y = Vector{Float64}(undef, length(v))

    @inbounds for (i, (val, wgt)) in enumerate(zip(v, w))
          
     cumsum_x[i] = wgt
     cumsum_y[i] = val/v[end]      
    end
 
    pushfirst!(cumsum_x, 0.0)
    pushfirst!(cumsum_y, 0.0)
 
    return cumsum_x, cumsum_y
 
 end

 """
   wlorenz_curve(v, w)
 
 Compute the weighted relative Lorenz Curve of `v` with weights `w`. See also [`lorenz_curve`](lorenz_curve)
 """
 wlorenz_curve(v::Array{<:Real,1}, w::Array{<:Real,1}) = lorenz_curve(v, w)
