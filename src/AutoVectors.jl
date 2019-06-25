module AutoVectors
using LinearAlgebra
using DSP		# for conv = convolution

import Base.deepcopy, Base.getindex, Base.setindex!

include("autovector.jl")

const autovector = AutoVector

export AutoVector, autovector, mini, maxi, clear!, copy, avdot, doprint, axpy!, convolve, 
		makeauto,makeautotake,applyshift,avtriple, fast, arange, symmetrize!, 
		avlocation, avlocmin,avlocmax,avvec, shrink!, avnorm, avtripconv,eigsym

end
