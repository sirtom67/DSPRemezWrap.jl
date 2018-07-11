using Compat, DSPRemezWrap, Compat.Test

testfiles = [ "remez_wrap.jl" ]

for testfile in testfiles
    eval(@__MODULE__, :(@testset $testfile begin include($testfile) end))
end

