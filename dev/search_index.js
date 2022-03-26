var documenterSearchIndex = {"docs":
[{"location":"#Inequality.jl","page":"Inequality.jl","title":"Inequality.jl","text":"","category":"section"},{"location":"","page":"Inequality.jl","title":"Inequality.jl","text":"Welcome to the Inequality.jl documentation!","category":"page"},{"location":"","page":"Inequality.jl","title":"Inequality.jl","text":"","category":"page"},{"location":"#Index","page":"Inequality.jl","title":"Index","text":"","category":"section"},{"location":"","page":"Inequality.jl","title":"Inequality.jl","text":"","category":"page"},{"location":"#Functions","page":"Inequality.jl","title":"Functions","text":"","category":"section"},{"location":"","page":"Inequality.jl","title":"Inequality.jl","text":"atkinson\ngini\nlorenz_curve\nmld\ngen_entropy\nwatts\ntheil\nfgt\nheadcount\npoverty_gap","category":"page"},{"location":"#Inequality.atkinson","page":"Inequality.jl","title":"Inequality.atkinson","text":"atkinson(v, ϵ)\n\nCompute the Atkinson Index of a vector v at a specified inequality  aversion parameter ϵ.\n\nExamples\n\njulia> atkinson([8, 5, 1, 3, 5, 6, 7, 6, 3], 1.2)\n0.1631765870035865\n\n\n\n\n\natkinson(v, w, ϵ)\n\nCompute the weighted Atkinson Index of a vector v at a specified inequality  aversion parameter ϵ, using weights given by a weight vector w.\n\nWeights must not be negative, missing or NaN. The weights and data vectors must have the same length.\n\nExamples\n\njulia> atkinson([8, 5, 1, 3], [0.1,0.5,0.3,0.8], 1.2)\n0.1681319821792493\n\n\n\n\n\n","category":"function"},{"location":"#Inequality.gini","page":"Inequality.jl","title":"Inequality.gini","text":"gini(v)\n\nCompute the Gini Coefficient of a vector v .\n\nExamples\n\njulia> gini([8, 5, 1, 3, 5, 6, 7, 6, 3])\n0.2373737373737374\n\n\n\n\n\ngini(v, w)\n\nCompute the weighted Gini Coefficient of a vector v using weights given by a weight vector w.\n\nWeights must not be negative, missing or NaN. The weights and data vectors must have the same length.\n\nExamples\n\njulia> gini([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9))\n0.20652395514780775\n\n\n\n\n\n","category":"function"},{"location":"#Inequality.lorenz_curve","page":"Inequality.jl","title":"Inequality.lorenz_curve","text":"lorenz(v)\n\nCompute the relative Lorenz Curve of a vector v . \n\nReturns two vectors. The first one contains the cumulative proportion of people.  The second contains the cumulative share of income earned.\n\nExamples\n\njulia> lorenz_curve([8, 5, 1, 3, 5, 6, 7, 6, 3])\n([0.0, 0.1111111111111111, 0.2222222222222222, 0.3333333333333333, 0.4444444444444444, 0.5555555555555556, 0.6666666666666666, 0.7777777777777778, 0.8888888888888888, 1.0], \n│ [0.0, 0.022727272727272728, 0.09090909090909091, 0.1590909090909091, 0.2727272727272727, 0.38636363636363635, 0.5227272727272727, 0.6590909090909091, 0.8181818181818182, 1.0])\n\n\n\n\n\nlorenz(v, w) Compute the weighted Lorenz Curve of a vector v using weights given by a weight vector w.\n\nWeights must not be negative, missing or NaN. The weights and data vectors must have the same length.\n\nReturns two vectors. The first one contains the cumulative proportion of weighted people.  The second contains the cumulative share of income earned.\n\nExamples\n\njulia> lorenz_curve([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9))\n([0.0, 0.06666666666666667, 0.08888888888888889, 0.13333333333333333, 0.2222222222222222, 0.3333333333333333, 0.5333333333333333, 0.6666666666666666, 0.8444444444444444, 1.0],\n[0.0, 0.013761467889908256, 0.05045871559633028, 0.0963302752293578, 0.1513761467889908, 0.2660550458715596, 0.38990825688073394, 0.555045871559633, 0.7752293577981653, 1.0])\n\n\n\n\n\n","category":"function"},{"location":"#Inequality.mld","page":"Inequality.jl","title":"Inequality.mld","text":"mld(v)\n\nCompute the Mean log deviation of a vector v.\n\nExamples\n\njulia> mld([8, 5, 1, 3, 5, 6, 7, 6, 3])\n0.1397460530936332\n\n\n\n\n\nmld(v, w)\n\nCompute the weighted Mean log deviation of a vector v using weights given by a weight vector w.\n\nWeights must not be negative, missing or NaN. The weights and data vectors must have the same length.\n\nExamples\n\njulia> mld([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9))\n0.10375545537468206\n\n\n\n\n\n","category":"function"},{"location":"#Inequality.gen_entropy","page":"Inequality.jl","title":"Inequality.gen_entropy","text":"gen_entropy(v, α)\n\nCompute the Generalized Entropy Index of a vector `v` at a specified parameter `α`.\n\nExamples\n\njulia> gen_entropy([8, 5, 1, 3, 5, 6, 7, 6, 3], 2)\n0.09039256198347094\n\n\n\n\n\ngen_entropy(v, w, α)\n\nCompute the Generalized Entropy Index of a vector v, using weights given by a weight vector w  at a specified parameter α.\n\nWeights must not be negative, missing or NaN. The weights and data vectors must have the same length.\n\nExamples\n\njulia> gen_entropy([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9), 2)\n0.0709746654322026\n\n\n\n\n\n","category":"function"},{"location":"#Inequality.watts","page":"Inequality.jl","title":"Inequality.watts","text":"watts(v, k)\n\nCompute the Watts Poverty Index of a vector `v` at a specified absolute \npoverty line `k`.\n\nExamples\n\njulia> watts([8, 5, 1, 3, 5, 6, 7, 6, 3], 4)\n0.217962056224828\n\n\n\n\n\nwatts(v, w, α)\n\nCompute the Watts Poverty Index of a vector v at a specified absolute  poverty line α, using weights given by a weight vector w.\n\nWeights must not be negative, missing or NaN. The weights and data vectors must have the same length.\n\nExamples\n\njulia> watts([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9), 4)\n0.17552777833850716\n\n\n\n\n\n","category":"function"},{"location":"#Inequality.theil","page":"Inequality.jl","title":"Inequality.theil","text":"theil(v)\n\nCompute the Theil Index of a vector `v`.\n\nExamples\n\njulia> theil([8, 5, 1, 3, 5, 6, 7, 6, 3])\n0.10494562214323544\n\n\n\n\n\ntheil(v, w)\n\nCompute the Theil Index of a vector v, using weights given by a weight vector w.\n\nWeights must not be negative, missing or NaN. The weights and data vectors must have the same length.\n\nExamples\n\njulia> theil([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9))\n0.08120013911680612\n\n\n\n\n\n","category":"function"},{"location":"#Inequality.fgt","page":"Inequality.jl","title":"Inequality.fgt","text":"fgt(v, α, z)\n\nCompute the Foster–Greer–Thorbecke index of a vector v at a specified α and a given poverty threshold z.\n\nExamples\n\njulia> fgt([8, 5, 1, 3, 5, 6, 7, 6, 3], 2, 4)\n0.0763888888888889\n\n\n\n\n\nfgt(v, w, α, z)\n\nCompute the Foster–Greer–Thorbecke index of a vector v at a specified α and  a given poverty threshold z, using weights given by a weight vector w.\n\nWeights must not be negative, missing or NaN. The weights and data vectors must have the same length.\n\nExamples\n\njulia> fgt([8, 5, 1, 3, 5, 6, 7, 6, 3], collect(0.1:0.1:0.9), 2, 4)\n0.05555555555555555\n\n\n\n\n\n","category":"function"},{"location":"#Inequality.headcount","page":"Inequality.jl","title":"Inequality.headcount","text":"headcount(v, z)\n\nCompute the Headcount Ratio of a vector v at a specified poverty threshold z.\n\nExamples\n\njulia> headcount([8, 5, 1, 3, 5, 6, 7, 6, 3], 4)\n0.3333333333333333\n\n\n\n\n\nheadcount(v, w, z)\n\nCompute the Headcount Ratio of a vector v at a specified poverty threshold z,  using weights given by a weight vector w.\n\nWeights must not be negative, missing or NaN. The weights and data vectors must have the same length.\n\nExamples\n\njulia> headcount([8, 5, 1, 3, 5, 6, 7, 6, 3], [0.1,0.5,0.3,0.8,0.1,0.5,0.3,0.8,0.2], 4)\n0.36111111111111116\n\n\n\n\n\n","category":"function"},{"location":"#Inequality.poverty_gap","page":"Inequality.jl","title":"Inequality.poverty_gap","text":"poverty_gap(v, z)\n\nCompute the Poverty Gap of a vector v at a specified poverty threshold z.\n\nExamples\n\njulia> poverty_gap([8, 5, 1, 3, 5, 6, 7, 6, 3], 4)\n0.1388888888888889\n\n\n\n\n\npoverty_gap(v, w, z)\n\nCompute the Poverty Gap of a vector v at a specified poverty threshold z,  using weights given by a weight vector w.\n\nWeights must not be negative, missing or NaN. The weights and data vectors must have the same length.\n\nExamples\n\njulia> poverty_gap([8, 5, 1, 3, 5, 6, 7, 6, 3], [0.1,0.5,0.3,0.8,0.1,0.5,0.3,0.8,0.2], 4)\n0.13194444444444445\n\n\n\n\n\n","category":"function"}]
}
