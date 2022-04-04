# User Guide
[`Inequality.jl`]("https://github.com/JosepER/Inequality.jl") provides functions to compute income and wealth inequality estimates. This guide will show how to use them. 

## Weighted and unweighted estimates
All the functions in the package provide methods to compute both weighted and unweighted estimates. The details of the functions can be seen in the [Library](https://joseper.github.io/Inequality.jl/dev/library/#Functions) section of the documentation. 

All functions requiere the vector for which the estimate is to be computed as first argument. They also have an optional second argument to pass a vector of weights.

```julia 
using Inequality

v = collect(1:1:20)
w = collect(0.1:0.1:2)

gini(v) # unweighted
# 0.3166666666666666

gini(v, w) # weighted
# 0.19904761904761914
```

The functions can also use weights from `StatsBase`, such as:

```julia
using StatsBase

gini(v, Weights(w))
# 0.19904761904761914

gini(v, pweights(w))
# 0.19904761904761914
```

Certain functions have extra parameters. These should be passed after the vector for which the estimate is to be computed and the optional weights.

For example, the Atkinson Index uses an aversion parameter ϵ.

```julia
atkinson(v, 2) # unweighted
# 0.47056705423923484

atkinson(v, w, 2) # weighted
# 0.23170731707317072
```


## Passing a DataFrame or GroupedDataFrame

The package functions can also work using a `DataFrame` or a grouped `DataFrame` (i.e. `GroupedDataFrame` type object).

The following example shows how to use `DataFrames.combine()` to produce the Gini Coefficient of a `DataFrame` column `v`.

```julia 
using DataFrames

df = DataFrame(v = v, w = w)

combine(df, :v => gini)
#1×1 DataFrame
# Row │ v_gini   
#     │ Float64
#─────┼──────────
#   1 │ 0.316667

```

The same function can be used to compute the weighted version of the estimate. This only requieres to pass both the `v` and `w` columns to the `gini()` function. The [`DataFrames`](https://dataframes.juliadata.org/stable/) package [User Guide](https://dataframes.juliadata.org/stable/man/getting_started/) provides further explanations on how to use 
`DataFrames.combine()` with multiple variables and/or anonymous functions.

``` julia
combine(df, [:v, :w] => (x, y) -> gini(x, y) )
#1×1 DataFrame
# Row │ v_w_function 
#     │ Float64
#─────┼──────────────
#   1 │     0.199048

```

The `Inequality.jl` functions can also be used with a `GroupedDataFrame`.

```julia
group = vcat(repeat(["a"], 10), repeat(["b"], 10))

df_grouped = DataFrame(v = v, 
                       w = w,
                       group = group)

combine(groupby(df_grouped, :group), :v => gini)
#2×2 DataFrame
# Row │ group   v_gini   
#     │ String  Float64
#─────┼──────────────────
#   1 │ a       0.3
#   2 │ b       0.106452

combine(groupby(df_grouped, :group), [:v, :w] => (x, y) -> gini(x, y))
#2×2 DataFrame
# Row │ group   v_w_function 
#     │ String  Float64      
#─────┼──────────────────────
#   1 │ a           0.196364
#   2 │ b           0.100754

```

