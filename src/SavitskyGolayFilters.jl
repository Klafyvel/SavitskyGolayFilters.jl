module SavitskyGolayFilters

import DSP: conv

vandermonde(x, k) = x .^ transpose(0:k)
fit_matrix(n, k) = vandermonde(-floor(n/2):floor(n/2), k)

"""
    savitskygolayfilter(n,k,d=0)

Compute the Savitsky-Golay filter of length `n`, degree `k` and derivative
order `d`.

See also: [`savitskygolay`](@ref)
"""
savitskygolayfilter(n,k,d=0) = begin
    M = fit_matrix(n, k)
    B = inv(transpose(M)*M)*transpose(M)
    B[d+1,end:-1:1] 
end

"""
    savitskygolay(x, n, k, d=0)
    savitskygolay(x, filter)

Apply a Savitsky-Golay filter on `x`. The applied filter is either the already
calculated `filter` or a newly calculated filter of length `n`, degree `k` 
and derivative order `d`.

# Examples
```jldoctest
julia> using Random

julia> x = -3π:0.1:3π;

julia> y = sin.(x) .+ randn(length(x));

julia> filtered = savitskygolay(y, 10, 2);

julia> size(filtered)
(158,)

julia> size(y)
(158,)

julia> filtered_derivative = savitskygolay(y, 10, 2, 1);

julia> size(filtered_derivative)
(158,)

```

See also: [`savitskygolayfilter`](@ref)
"""
function savitskygolay end

savitskygolay(x, n, k, d=0) = savitskygolay(x, savitskygolayfilter(n,k,d))

savitskygolay(x, filter::AbstractArray) = begin
    len_filter = length(filter)
    border_repeat = floor(Int, len_filter/2)
    conv(
        filter,
        [repeat([x[1]],border_repeat);x;repeat([x[end]],border_repeat)],
       )[len_filter:end-len_filter+1]
end

export savitskygolayfilter, savitskygolay

end
