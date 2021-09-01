# SavitskyGolayFilters

This is a simple package to use [Savitsky-Golay filters](https://en.wikipedia.org/wiki/Savitzky%E2%80%93Golay_filter) in Julia. Check-out the documentation to see how it works.

# Example 

```julia
julia> using SavitskyGolayFilters
julia> x = randn(100)
...
julia> savitskygolay(x, 10, 2)
````
