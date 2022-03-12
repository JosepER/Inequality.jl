using Inequality
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
    @test atkinson([8,5,1,3,5], 1) == atkinson([8,5,1,3,5], [1,1,1,1,1], 1)   
    @test atkinson([8,5,1,3,5], 0.8) == atkinson([8,5,1,3,5], [1,1,1,1,1], 0.8)
    @test atkinson([8,5,1,3,5], 1.2) ≈ atkinson([8,5,1,3,5], [1,1,1,1,1], 1.2) atol=0.00000001
    @test atkinson([8,5,1,3,5], 1) ≈ 0.183083677559 atol=0.00000001
    @test atkinson([8,5,1,3,5], 0.8) ≈ 0.14249378376024 atol=0.00000001
    @test atkinson([8,5,1,3,5], 1.2) ≈ 0.2248733447899 atol=0.00000001
    @test atkinson([8,5,1,3,5], [1, 2, 1, 3, 1], 1) ≈ atkinson([8,5,5,1,3,3,3,5], 1)  atol=0.00000001 # same result for probability and frequency weights
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
end
