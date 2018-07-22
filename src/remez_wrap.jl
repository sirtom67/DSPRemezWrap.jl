# linear phase FIR filter design that optimizes maximum error
# in the frequency domain

using DSP

"""
    remez_wrap(numtaps::Integer, 
          bands::Vector, 
          desired::Vector; 
          weight::Vector=[], 
          Hz::Real=1.0, 
          filter_type::RemezFilterType=filter_type_bandpass,
          maxiter::Integer=25, 
          grid_density::Integer=16)

Calculate the minimax optimal filter using the Remez exchange algorithm [^McClellan1973a] [^McClellan1973b].

Calculate the filter-coefficients for the finite impulse response
(FIR) filter whose transfer function minimizes the maximum error
between the desired gain and the realized gain in the specified
frequency bands using the Remez exchange algorithm.

`remez_wrap` is equivalent to `remez` in the DSP package, except it uses
the C code ported from scipy.

# Arguments
- `numtaps::Integer`: The desired number of taps in the filter. 
    The number of taps is the number of terms in the filter, or the filter 
    order plus one.
- `bands::Vector`: A monotonic sequence containing the band edges in Hz.
    All elements must be non-negative and less than half the sampling
    frequency as given by `Hz`.
- `desired::Vector`:A sequence half the size of bands containing the desired 
    gain in each of the specified bands.
- `weight::Vector`: (optional)
    A relative weighting to give to each band region. The length of
    `weight` has to be half the length of `bands`.
- `Hz::Real`: The sampling frequency in Hz. Default is 1.
- `filter_type::RemezFilterType`: Default is filter_type_bandpass.
    The type of filter:
      filter_type_bandpass : flat response in bands. This is the default.
      filter_type_differentiator : frequency proportional response in bands.
        Assymetric as in filter_type_hilbert case, but with a linear sloping
        desired response.
      filter_type_hilbert : filter with odd symmetry, that is, type III
                  (for even order) or type IV (for odd order)
                  linear phase filters.
- `maxiter::Integer`: (optional)
    Maximum number of iterations of the algorithm. Default is 25.
- `grid_density:Integer`: (optional)
    Grid density. The dense grid used in `remez` is of size
    ``(numtaps + 1) * grid_density``. Default is 16.

# Returns
- `h::Array{Float64,1}`: A rank-1 array containing the coefficients of the optimal
    (in a minimax sense) filter.

[^McClellan1973a]: 
J. H. McClellan and T. W. Parks, A unified approach to the
design of optimum FIR linear phase digital filters,
IEEE Trans. Circuit Theory, vol. CT-20, pp. 697-701, 1973.

[^McClellan1973b]: 
J. H. McClellan, T. W. Parks and L. R. Rabiner, A Computer
Program for Designing Optimum FIR Linear Phase Digital
Filters, IEEE Trans. Audio Electroacoust., vol. AU-21,
pp. 506-525, 1973.

# Examples
Construct a length 35 filter with a passband at 0.15-0.4 Hz 
(desired response of 1), and stop bands at 0-0.1 Hz and 0.45-0.5 Hz
(desired response of 0). Note: the behavior in the frequency ranges between 
those bands - the transition bands - is unspecified.

```julia-repl
julia> bpass = remez_wrap(35, [0 0.1 0.15 0.4 0.45 0.5], [0 1 0])
```

You can trade-off maximum error achieved for transition bandwidth. 
The wider the transition bands, the lower the maximum error in the
bands specified. Here is a bandpass filter with the same passband, but
wider transition bands.

```julia-repl
julia> bpass2 = remez_wrap(35, [0 0.08 0.15 0.4 0.47 0.5], [0 1 0])
```

Here we compute the frequency responses and plot them in dB.

```julia-repl
using PyPlot
b = DSP.Filters.PolynomialRatio(bpass, [1.0])
b2 = DSP.Filters.PolynomialRatio(bpass2, [1.0])
f = linspace(0, 0.5, 1000)
plot(f, 20*log10.(abs.(freqz(b,f,1.0))))
plot(f, 20*log10.(abs.(freqz(b2,f,1.0))))
grid()
```
"""
function remez_wrap(numtaps::Integer, bands::Vector, desired::Vector; 
               weight::Vector=[], 
               Hz::Real=1.0, 
               filter_type::RemezFilterType=filter_type_bandpass,
               maxiter::Integer=25, 
               grid_density::Integer=16)

    # Convert type
    if (filter_type == filter_type_bandpass)
        tnum = 1
    elseif (filter_type == filter_type_differentiator)
        tnum = 2
    elseif (filter_type == filter_type_hilbert)
        tnum = 3
    end
    if (length(weight)==0)
        weight = ones(desired)
    end

    h = zeros(numtaps)
    #return sigtools._remez(numtaps, bands, desired, weight, tnum, Hz,
                           #maxiter, grid_density)
    #int pre_remez(double *h2, int numtaps, int numbands, double *bands,
    #              double *response, double *weight, int type, int maxiter,
    #              int grid_density);
    bands = copy(bands)/Hz
    ccall((:pre_remez, "remez"), Integer, (Ptr{Cdouble}, Cint, Cint, Ptr{Cdouble}, Ptr{Cdouble}, Ptr{Cdouble}, Cint, Cint, Cint), 
        h, numtaps, length(bands)/2, bands, desired, weight, tnum, maxiter, grid_density)
    return h

end


