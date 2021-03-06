!(dirname(@__FILE__) in LOAD_PATH) && push!(LOAD_PATH, dirname(@__FILE__))
using DSPRemezWrap, Compat, Compat.Test

#
# Length 151 LPF (Low Pass Filter).
#
@testset "remez_151_lpf" begin
    h = remez_wrap(151, [0, 0.475, 0.5, 1.0], [1.0, 0.0]; Hz=2.0);
    h_scipy = readdlm(joinpath(dirname(@__FILE__), "data", "remez_151_lpf.txt"),'\t')
    @test h ≈ h_scipy
end

#
# Length 152 LPF. Non-default "weight" input.
# 
#    from scipy.signal import remez
#    lpf = remez(152, [0, 0.475, 0.5, 1.0], [1.0, 0.0], weight=[1,2], Hz=2.0)
#    lpf.tofile('remez_152_lpf.txt', sep='\n')
#
@testset "remez_152_lpf" begin
    h = remez_wrap(152, [0, 0.475, 0.5, 1.0], [1.0, 0.0]; weight=[1.0,2.0], Hz=2.0);
    h_scipy = readdlm(joinpath(dirname(@__FILE__), "data", "remez_152_lpf.txt"),'\t')
    @test h ≈ h_scipy
end

#
# Length 51 HPF (High Pass Filter).
#
#    from scipy.signal import remez
#    hpf = remez(51, [0, 0.75, 0.8, 1.0], [0.0, 1.0], Hz=2.0)
#    hpf.tofile('remez_51_hpf.txt', sep='\n')
#
@testset "remez_51_hpf" begin
    h = remez_wrap(51, [0, 0.75, 0.8, 1.0], [0.0, 1.0]; Hz=2.0);
    h_scipy = readdlm(joinpath(dirname(@__FILE__), "data", "remez_51_hpf.txt"),'\t')
    @test h ≈ h_scipy
end

#
# Length 180 BPF (Band Pass Filter).
#
#    from scipy.signal import remez
#    bpf = remez(180, [0, 0.375, 0.4, 0.5, 0.525, 1.0], [0.0, 1.0, 0.0], Hz=2.0)
#    bpf.tofile('remez_180_bpf.txt', sep='\n')
#
@testset "remez_180_bpf" begin
    h = remez_wrap(180, [0, 0.375, 0.4, 0.5, 0.525, 1.0], [0.0, 1.0, 0.0]; Hz=2.0);
    h_scipy = readdlm(joinpath(dirname(@__FILE__), "data", "remez_180_bpf.txt"),'\t')
    @test h ≈ h_scipy
end

#
#  Odd-symmetric filters - hilbert and differentiators type.
#  Even length - much better approximation since it is not constrained to 0 at 
#  the nyquist frequency
#
# Length 20 hilbert
#
#    from scipy.signal import remez
#    h = remez(20, [0.1, 0.95], [1], type="hilbert", Hz=2.0)
#    h.tofile('remez_20_hilbert.txt', sep='\n')
#
@testset "remez_20_hilbert" begin
    h = remez_wrap(20, [0.1, 0.95],[1.0]; filter_type=filter_type_hilbert, Hz=2.0);
    h_scipy = readdlm(joinpath(dirname(@__FILE__), "data", "remez_20_hilbert.txt"),'\t')
    @test h ≈ h_scipy
end

#
# Length 21 hilbert
#
#    from scipy.signal import remez
#    h = remez(21, [0.1, 0.95], [1], type="hilbert", Hz=2.0)
#    h.tofile('remez_21_hilbert.txt', sep='\n')
#
@testset "remez_21_hilbert" begin
    h = remez_wrap(21, [0.1, 0.95],[1.0]; filter_type=filter_type_hilbert, Hz=2.0);
    h_scipy = readdlm(joinpath(dirname(@__FILE__), "data", "remez_21_hilbert.txt"),'\t')
    @test h ≈ h_scipy
end

#
# Length 200 differentiator
#
#    from scipy.signal import remez
#    h = remez(200,[0.01, 0.99],[1],type="differentiator" Hz=2.0)
#    h.tofile('remez_200_differentiator.txt', sep='\n')
#
@testset "remez_200_differentiator" begin
    h = remez_wrap(200, [0.01, 0.99],[1.0]; filter_type=filter_type_differentiator, Hz=2.0);
    h_scipy = readdlm(joinpath(dirname(@__FILE__), "data", "remez_200_differentiator.txt"),'\t')
    @test h ≈ h_scipy
end

#
# Length 201 differentiator
#
#    from scipy.signal import remez
#    h = remez(201,[0.05, 0.95],[1],type="differentiator" Hz=2.0)
#    h.tofile('remez_201_differentiator.txt', sep='\n')
#
@testset "remez_201_differentiator" begin
    h = remez_wrap(201, [0.05, 0.95],[1.0]; filter_type=filter_type_differentiator, Hz=2.0);
    h_scipy = readdlm(joinpath(dirname(@__FILE__), "data", "remez_201_differentiator.txt"),'\t')
    @test h ≈ h_scipy
end
