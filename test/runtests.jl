using Inequality
using StatsBase
using Test

@testset "atkinson checks" begin
    @test_throws ArgumentError atkinson([8, 5, 1, 3, 5], -1)   
    @test_throws ArgumentError atkinson([8, 5, 1, 3, 5], [0.1, 0.2, 0.3, 0.4, 0.5], -1)  
    @test_throws ArgumentError atkinson([8, 5, 1, 3, 5], [-1, 0.1, 0.2, 0.3, 0.4], 1)  
    @test_throws ArgumentError atkinson([8, 5, 1, 3, 5], [NaN, 0.1, 0.2, 0.3, 0.4], 1)  
    @test_throws MethodError atkinson([8, 5, 1, 3, 5], [missing, 0.1, 0.2, 0.3, 0.4], 1)  
    @test_throws ArgumentError atkinson([8, 5, 1, 3, 5], [0.1, 0.2, 0.3, 0.4], 1)  # different length `v` and `w`
end

@testset "atkinson" begin
    @test atkinson([8,5,1,3,5], 1) ≈ atkinson([8,5,1,3,5], [1,1,1,1,1], 1)   atol=0.00000001
    @test atkinson([8,5,1,3,5], 0.8) ≈ atkinson([8,5,1,3,5], [1,1,1,1,1], 0.8) atol=0.00000001
    @test atkinson([8,5,1,3,5], 1.2) ≈ atkinson([8,5,1,3,5], [1,1,1,1,1], 1.2) atol=0.00000001
    @test atkinson([8,5,1,3,5], 1) ≈ 0.183083677559 atol=0.00000001
    @test atkinson([8,5,1,3,5], 0.8) ≈ 0.14249378376024 atol=0.00000001
    @test atkinson([8,5,1,3,5], 1.2) ≈ 0.2248733447899 atol=0.00000001
    @test atkinson([8,5,1,3,5], [1, 2, 1, 3, 1], 1) ≈ atkinson([8,5,5,1,3,3,3,5], 1)  atol=0.00000001 # same result for probability and frequency weights
    @test atkinson([8,5,1,3,5], StatsBase.weights([1,1,1,1,1]), 1) ≈ atkinson([8,5,1,3,5], [1,1,1,1,1], 1) atol=0.00000001
    @test atkinson([8,5,1,3,5], StatsBase.pweights([1,1,1,1,1]), 1) ≈ atkinson([8,5,1,3,5], [1,1,1,1,1], 1) atol=0.00000001
    @test atkinson([8,5,1,3,5], StatsBase.weights([1,1,1,1,1]), 0.8) ≈ atkinson([8,5,1,3,5], [1,1,1,1,1], 0.8) atol=0.00000001
    @test atkinson([8,5,1,3,5], StatsBase.pweights([1,1,1,1,1]), 0.8) ≈ atkinson([8,5,1,3,5], [1,1,1,1,1], 0.8) atol=0.00000001
    @test atkinson([8,5,1,3,5], StatsBase.weights([1,1,1,1,1]), 1.2) ≈ atkinson([8,5,1,3,5], [1,1,1,1,1], 1.2) atol=0.00000001
    @test atkinson([8,5,1,3,5], StatsBase.pweights([1,1,1,1,1]), 1.2) ≈ atkinson([8,5,1,3,5], [1,1,1,1,1], 1.2) atol=0.00000001
end


@testset "gini checks" begin
    @test_throws ArgumentError gini([8, 5, 1, 3, 5], [-1, 0.1, 0.2, 0.3, 0.4])  
    @test_throws ArgumentError gini([8, 5, 1, 3, 5], [NaN, 0.1, 0.2, 0.3, 0.4])  
    @test_throws MethodError gini([8, 5, 1, 3, 5], [missing, 0.1, 0.2, 0.3, 0.4])  
    @test_throws ArgumentError gini([8, 5, 1, 3, 5], [0.1, 0.2, 0.3, 0.4])  # different length `v` and `w`
end


@testset "gini" begin
    @test gini([8,5,1,3,5]) ≈ gini([8,5,1,3,5], [1,1,1,1,1]) atol=0.00000001
    @test gini([8,5,1,3,5,6,7,6,3]) ≈ 0.237373737373737 atol=0.00000001
    @test gini([8,5,1,3,5,6,7,6,3], collect(0.1:0.1:0.9)) ≈ 0.2065239551478077 atol=0.00000001
    @test gini([8,5,1,3,5], [1, 2, 1, 3, 1]) ≈ gini([8,5,5,1,3,3,3,5]) atol=0.00000001 # same result for probability and frequency weights
    @test gini([8,5,1,3,5], StatsBase.weights([1,1,1,1,1])) ≈ gini([8,5,1,3,5], [1,1,1,1,1]) atol=0.00000001
    @test gini([8,5,1,3,5], StatsBase.pweights([1,1,1,1,1])) ≈ gini([8,5,1,3,5], [1,1,1,1,1]) atol=0.00000001
end


@testset "lorenz_curve checks" begin
    @test_throws ArgumentError lorenz_curve([8, 5, 1, 3, 5], [-1, 0.1, 0.2, 0.3, 0.4])  
    @test_throws ArgumentError lorenz_curve([8, 5, 1, 3, 5], [NaN, 0.1, 0.2, 0.3, 0.4])  
    @test_throws MethodError lorenz_curve([8, 5, 1, 3, 5], [missing, 0.1, 0.2, 0.3, 0.4])  
    @test_throws ArgumentError lorenz_curve([8, 5, 1, 3, 5], [0.1, 0.2, 0.3, 0.4])  # different length `v` and `w`
end


@testset "lorenz_curve" begin
    @test all(lorenz_curve([8,5,1,3,5])[2] .≈ lorenz_curve([8,5,1,3,5], [1,1,1,1,1])[2]) 
    @test all(lorenz_curve([8,5,1,3,5,6,7,6,3])[1] .≈ Vector([0.0, 0.1111111111111111, 0.2222222222222222, 0.3333333333333333, 0.4444444444444444, 0.5555555555555556, 0.6666666666666666, 0.7777777777777778, 0.8888888888888888, 1.0]))
    @test all(lorenz_curve([8,5,1,3,5,6,7,6,3])[2] .≈ [0.0, 0.022727272727272728, 0.09090909090909091, 0.1590909090909091, 0.2727272727272727, 0.38636363636363635, 0.5227272727272727, 0.6590909090909091, 0.8181818181818182, 1.0])
    @test all(lorenz_curve([8,5,1,3,5,6,7,6,3], collect(0.1:0.1:0.9))[2] .≈ [0.0, 0.013761467889908256, 0.05045871559633028, 0.0963302752293578, 0.1513761467889908, 0.2660550458715596, 0.38990825688073394, 0.555045871559633, 0.7752293577981653, 1.0])
    @test all(lorenz_curve([8,5,1,3,5], StatsBase.weights([1,1,1,1,1]))[2] ≈ lorenz_curve([8,5,1,3,5], [1,1,1,1,1])[2])
    @test all(lorenz_curve([8,5,1,3,5], StatsBase.pweights([1,1,1,1,1]))[2] ≈ lorenz_curve([8,5,1,3,5], [1,1,1,1,1])[2])
end


@testset "mld checks" begin
    @test_throws ArgumentError mld([8, 5, 1, 3, 5], [-1, 0.1, 0.2, 0.3, 0.4])  
    @test_throws ArgumentError mld([8, 5, 1, 3, 5], [NaN, 0.1, 0.2, 0.3, 0.4])  
    @test_throws MethodError mld([8, 5, 1, 3, 5], [missing, 0.1, 0.2, 0.3, 0.4])  
    @test_throws ArgumentError mld([8, 5, 1, 3, 5], [0.1, 0.2, 0.3, 0.4])  # different length `v` and `w`
end

@testset "mld" begin
    @test mld([8,5,1,3,5]) ≈ mld([8,5,1,3,5], [1,1,1,1,1]) atol=0.00000001
    @test mld([8,5,1,3,5,6,7,6,3]) ≈ 0.1397460530936332 atol=0.00000001
    @test mld([8,5,1,3,5,6,7,6,3], collect(0.1:0.1:0.9)) ≈ 0.10375545537468207 atol=0.00000001
    @test mld([8,5,1,3,5], [1, 2, 1, 3, 1]) ≈ mld([8,5,5,1,3,3,3,5]) atol=0.00000001 # same result for probability and frequency weights
    @test mld([8,5,1,3,5], StatsBase.weights([1,1,1,1,1])) ≈ mld([8,5,1,3,5], [1,1,1,1,1]) atol=0.00000001
    @test mld([8,5,1,3,5], StatsBase.pweights([1,1,1,1,1])) ≈ mld([8,5,1,3,5], [1,1,1,1,1]) atol=0.00000001
end


@testset "watts checks" begin
    @test_throws ArgumentError watts([8, 5, 1, 3, 5], [-1, 0.1, 0.2, 0.3, 0.4], 4)  
    @test_throws ArgumentError watts([8, 5, 1, 3, 5], [NaN, 0.1, 0.2, 0.3, 0.4], 4)  
    @test_throws MethodError watts([8, 5, 1, 3, 5], [missing, 0.1, 0.2, 0.3, 0.4], 4)  
    @test_throws ArgumentError watts([8, 5, 1, 3, 5], [0.1, 0.2, 0.3, 0.4], 4)  # different length `v` and `w`
end

@testset "watts" begin
    @test watts([8,5,1,3,5], 4) ≈ watts([8,5,1,3,5], [1,1,1,1,1], 4) atol=0.00000001
    @test watts([8,5,1,3,5,6,7,6,3], 4) ≈ 0.217962056224828 atol=0.00000001
    @test watts([8,5,1,3,5,6,7,6,3], collect(0.1:0.1:0.9), 4) ≈ 0.17552777833850716 atol=0.00000001
    @test watts([8,5,1,3,5], [1, 2, 1, 3, 1], 4) ≈ watts([8,5,5,1,3,3,3,5], 4) atol=0.00000001 # same result for probability and frequency weights
    @test watts([8,5,1,3,5], StatsBase.weights([1,1,1,1,1]), 4) ≈ watts([8,5,1,3,5], [1,1,1,1,1], 4) atol=0.00000001
    @test watts([8,5,1,3,5], StatsBase.pweights([1,1,1,1,1]), 4) ≈ watts([8,5,1,3,5], [1,1,1,1,1], 4) atol=0.00000001
end


@testset "theil checks" begin
    @test_throws ArgumentError theil([8, 5, 1, 3, 5], [-1, 0.1, 0.2, 0.3, 0.4])  
    @test_throws ArgumentError theil([8, 5, 1, 3, 5], [NaN, 0.1, 0.2, 0.3, 0.4])  
    @test_throws MethodError theil([8, 5, 1, 3, 5], [missing, 0.1, 0.2, 0.3, 0.4])  
    @test_throws ArgumentError theil([8, 5, 1, 3, 5], [0.1, 0.2, 0.3, 0.4])  # different length `v` and `w`
end

@testset "theil" begin
    @test theil([8,5,1,3,5]) ≈ theil([8,5,1,3,5], [1,1,1,1,1]) atol=0.00000001
    @test theil([8,5,1,3,5,6,7,6,3]) ≈ 0.10494562214323544 atol=0.00000001
    @test theil([8,5,1,3,5,6,7,6,3], collect(0.1:0.1:0.9)) ≈ 0.08120013911680612 atol=0.00000001
    @test theil([8,5,1,3,5], [1, 2, 1, 3, 1]) ≈ theil([8,5,5,1,3,3,3,5]) atol=0.00000001 # same result for probability and frequency weights
    @test theil([8,5,1,3,5], StatsBase.weights([1,1,1,1,1])) ≈ theil([8,5,1,3,5], [1,1,1,1,1]) atol=0.00000001
    @test theil([8,5,1,3,5], StatsBase.pweights([1,1,1,1,1])) ≈ theil([8,5,1,3,5], [1,1,1,1,1]) atol=0.00000001
end


@testset "gen_entropy checks" begin
    @test_throws ArgumentError gen_entropy([8, 5, 1, 3, 5], [-1, 0.1, 0.2, 0.3, 0.4],2)  
    @test_throws ArgumentError gen_entropy([8, 5, 1, 3, 5], [NaN, 0.1, 0.2, 0.3, 0.4],2)  
    @test_throws MethodError gen_entropy([8, 5, 1, 3, 5], [missing, 0.1, 0.2, 0.3, 0.4],2)  
    @test_throws ArgumentError gen_entropy([8, 5, 1, 3, 5], [0.1, 0.2, 0.3, 0.4],2)  # different length `v` and `w`
end

@testset "gen_entropy" begin
    @test gen_entropy([8,5,1,3,5], 0) ≈ mld([8,5,1,3,5])
    @test gen_entropy([8,5,1,3,5], 1) ≈ theil([8,5,1,3,5]) 
    @test gen_entropy([8,5,1,3,5], 2) ≈ gen_entropy([8,5,1,3,5], [1,1,1,1,1], 2) atol=0.00000001
    @test gen_entropy([8,5,1,3,5,6,7,6,3], 2) ≈ 0.09039256198347094 atol=0.00000001
    @test gen_entropy([8,5,1,3,5,6,7,6,3], collect(0.1:0.1:0.9), 2) ≈ 0.0709746654322026 atol=0.00000001
    @test gen_entropy([8,5,1,3,5], [1, 2, 1, 3, 1], 2) ≈ gen_entropy([8,5,5,1,3,3,3,5], 2) atol=0.00000001 # same result for probability and frequency weights
    @test gen_entropy([8,5,1,3,5], StatsBase.weights([1,1,1,1,1]), 2) ≈ gen_entropy([8,5,1,3,5], [1,1,1,1,1], 2) atol=0.00000001
    @test gen_entropy([8,5,1,3,5], StatsBase.pweights([1,1,1,1,1]), 2) ≈ gen_entropy([8,5,1,3,5], [1,1,1,1,1], 2) atol=0.00000001
end


@testset "headcount checks" begin
    @test_throws ArgumentError headcount([8, 5, 1, 3, 5], [-1, 0.1, 0.2, 0.3, 0.4],2)  
    @test_throws ArgumentError headcount([8, 5, 1, 3, 5], [NaN, 0.1, 0.2, 0.3, 0.4],2)  
    @test_throws MethodError headcount([8, 5, 1, 3, 5], [missing, 0.1, 0.2, 0.3, 0.4],2)  
    @test_throws ArgumentError headcount([8, 5, 1, 3, 5], [0.1, 0.2, 0.3, 0.4],2)  # different length `v` and `w`
end

@testset "headcount" begin
    @test headcount([8,5,1,3,5,6,7,6,3], 4) ≈ 0.3333333333333333 atol=0.00000001
    @test headcount([8,5,1,3,5,6,7,6,3], fill(1,9), 4) ≈ 0.3333333333333333 atol=0.00000001
    @test headcount([8,5,1,3,5,6,7,6,3], collect(0.1:0.1:0.9), 4) ≈ 0.35555555555555557 atol=0.00000001
    @test headcount([8,5,1,3,5], [1, 2, 1, 3, 1], 2) ≈ headcount([8,5,5,1,3,3,3,5], 2) atol=0.00000001 # same result for probability and frequency weights
    @test headcount([8,5,1,3,5], StatsBase.weights([1,1,1,1,1]), 2) ≈ headcount([8,5,1,3,5], [1,1,1,1,1], 2) atol=0.00000001
    @test headcount([8,5,1,3,5], StatsBase.pweights([1,1,1,1,1]), 2) ≈ headcount([8,5,1,3,5], [1,1,1,1,1], 2) atol=0.00000001
end


@testset "poverty_gap checks" begin
    @test_throws ArgumentError poverty_gap([8, 5, 1, 3, 5], [-1, 0.1, 0.2, 0.3, 0.4],2)  
    @test_throws ArgumentError poverty_gap([8, 5, 1, 3, 5], [NaN, 0.1, 0.2, 0.3, 0.4],2)  
    @test_throws MethodError poverty_gap([8, 5, 1, 3, 5], [missing, 0.1, 0.2, 0.3, 0.4],2)  
    @test_throws ArgumentError poverty_gap([8, 5, 1, 3, 5], [0.1, 0.2, 0.3, 0.4],2)  # different length `v` and `w`
end

@testset "poverty_gap" begin
    @test poverty_gap([8,5,1,3,5,6,7,6,3], 4) ≈ 0.1388888888888889 atol=0.00000001
    @test poverty_gap([8,5,1,3,5,6,7,6,3], fill(1,9), 4) ≈ 0.1388888888888889 atol=0.00000001
    @test poverty_gap([8,5,1,3,5,6,7,6,3], collect(0.1:0.1:0.9), 4) ≈ 0.1222222222222222 atol=0.00000001
    @test poverty_gap([8,5,1,3,5], [1, 2, 1, 3, 1], 2) ≈ poverty_gap([8,5,5,1,3,3,3,5], 2) atol=0.00000001 # same result for probability and frequency weights
    @test poverty_gap([8,5,1,3,5], StatsBase.weights([1,1,1,1,1]), 2) ≈ poverty_gap([8,5,1,3,5], [1,1,1,1,1], 2) atol=0.00000001
    @test poverty_gap([8,5,1,3,5], StatsBase.pweights([1,1,1,1,1]), 2) ≈ poverty_gap([8,5,1,3,5], [1,1,1,1,1], 2) atol=0.00000001
end


@testset "fgt checks" begin
    @test_throws ArgumentError fgt([8, 5, 1, 3, 5], [-1, 0.1, 0.2, 0.3, 0.4], 2, 4)  
    @test_throws ArgumentError fgt([8, 5, 1, 3, 5], [NaN, 0.1, 0.2, 0.3, 0.4],2, 4)  
    @test_throws MethodError fgt([8, 5, 1, 3, 5], [missing, 0.1, 0.2, 0.3, 0.4],2, 4)  
    @test_throws ArgumentError fgt([8, 5, 1, 3, 5], [0.1, 0.2, 0.3, 0.4], 2, 4)  # different length `v` and `w`
end

@testset "fgt" begin
    @test fgt([8,5,1,3,5], 0, 4) ≈ headcount([8,5,1,3,5], 4)
    @test fgt([8,5,1,3,5], 1, 4) ≈ poverty_gap([8,5,1,3,5], 4) 
    @test fgt([8,5,1,3,5], 0, 4) ≈ headcount([8,5,1,3,5], 4)
    @test fgt([8,5,1,3,5], 1, 4) ≈ poverty_gap([8,5,1,3,5], 4) 
    @test fgt([8,5,1,3,5], 2, 4) ≈ fgt([8,5,1,3,5], [1,1,1,1,1], 2, 4) atol=0.00000001
    @test fgt([8,5,1,3,5,6,7,6,3], 2, 4) ≈ 0.0763888888888889 atol=0.00000001
    @test fgt([8,5,1,3,5,6,7,6,3], collect(0.1:0.1:0.9), 2, 4) ≈ 0.05555555555555555 atol=0.00000001
    @test fgt([8,5,1,3,5], [1, 2, 1, 3, 1], 2, 4) ≈ fgt([8,5,5,1,3,3,3,5], 2, 4) atol=0.00000001 # same result for probability and frequency weights
    @test fgt([8,5,1,3,5], StatsBase.weights([1,1,1,1,1]), 2, 4) ≈ fgt([8,5,1,3,5], [1,1,1,1,1], 2, 4) atol=0.00000001
    @test fgt([8,5,1,3,5], StatsBase.pweights([1,1,1,1,1]), 2, 4) ≈ fgt([8,5,1,3,5], [1,1,1,1,1], 2, 4) atol=0.00000001
end