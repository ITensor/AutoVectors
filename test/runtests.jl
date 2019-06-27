using AutoVectors,
      Test

@testset "AutoVectors" begin
  v = AutoVector(i->exp(-i*1.0),-1,5)

  @test length(v) == 7

  vc = copy(v)

  @test length(vc) == 7

  vc *= 2.0

  @test length(vc) == 7
  @test vc[0] == 2*v[0]
  @test vc[1] == 2*v[1]

  vc *= 0.5

  @test length(vc) == 7
  @test vc[1] == v[1]

  vv = [v,v,v]
  vv0 = [1.0,2.0,3.0] * vv - 6 * v

  @test avdot(vv0,vv0) == 0

  vb = AutoVector(i->exp(-i*i*0.2),-30,30)
  vbs = copy(vb)
  shrink!(vbs,1.0e-10)

  @test length(vbs) < length(vb)

  vvb = broadcast(*,v,vb)

  @test vvb[0] == v[0]*vb[0]

  w = AutoVector([1.0,2.0],4,5)

  @test w[3] == 0.0
  @test w[4] == 1.0
  @test w[5] == 2.0
  @test w[6] == 0.0

  for test =1:30
    u = AutoVector(0.0)
    g = AutoVector(0.0)
    v = AutoVector(0.0)
    ua = rand(-1000:1000)
    ub = ua+rand(0:5000)
    ga = rand(-20:20)
    gb = ga+rand(0:20)
    va = rand(-500:500)
    vb = va+rand(0:5000)
    for i=ua:ub
      u[i] = rand()
    end
    for i=ga:gb
      g[i] = rand()
    end
    for i=va:vb
      v[i] = rand()
    end
    res = avdot(convolve(u,g),v)
    res2 = avtripconv(u,g,v)
    @test res == 0 && res2 == 0 || abs(res-res2)/abs(res) < 1e-10
  end
end

