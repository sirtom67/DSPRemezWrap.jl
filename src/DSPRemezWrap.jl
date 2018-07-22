__precompile__()

module DSPRemezWrap

include("remez_wrap.jl")
export  remez_wrap, 
        RemezFilterType,
        filter_type_bandpass,
        filter_type_differentiator,
        filter_type_hilbert

end
