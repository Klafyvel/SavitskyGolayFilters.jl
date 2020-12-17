module SavitskyGolayFilters

import DSP: conv

vandermonde(x, k) = x .^ transpose(0:k)
fit_matrix(n, k) = vandermonde(-floor(n/2):floor(n/2), k)

savitskygolayfilter(n,k,d=0) = begin
    M = fit_matrix(n, k)
    B = inv(transpose(M)*M)*transpose(M)
    B[d+1,end:-1:1] 
end

savitskygolay(x, n, k, d=0) = begin
    len_filter = 2*floor(Int, n/2)+1
    filter = savitskygolayfilter(n, k, d)
    border_repeat = floor(Int, n/2)
    conv(
        filter,
        [repeat([x[1]],border_repeat);x;repeat([x[end]],border_repeat)],
       )[len_filter:end-len_filter+1]
end

export savitskygolayfilter, savitskygolay

end
