# Misc.jl

function checks_weights(v::Array{<:Real,1}, w::Array{<:Real,1})
    length(v) == length(w) ? nothing : throw(ArgumentError("`v` and `w` vectors must be the same size, got $(length(v)) and $(length(w))"))
    any([isnan(x) for x in w]) ? throw(ArgumentError("`w` vector cannot contain NaN values")) : nothing
    all(w .>= 0) ? nothing : throw(ArgumentError("`w` vector cannot contain negative entries"))
 end

 function checks_weights(v::Array{<:Real,1}, w::AbstractWeights)
    length(v) == length(w) ? nothing : throw(ArgumentError("`v` and `w` vectors must be the same size, got $(length(v)) and $(length(w))"))
    any([isnan(x) for x in w]) ? throw(ArgumentError("`w` vector cannot contain NaN values")) : nothing
    all(w .>= 0) ? nothing : throw(ArgumentError("`w` vector cannot contain negative entries"))
 end

