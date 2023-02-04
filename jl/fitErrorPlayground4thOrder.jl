using Plots

err(x, y) = (x - y)^2

dbm = 0:-1:-60
dbm = dbm'
dBm_expected = Float64.(rotr90(dbm))

ADC = Float64.(sort([800, 817, 846, 869, 901, 938, 981, 1018, 1060, 1098, 1138, 1322, 1401, 1488, 1583, 1661, 1777, 1997, 2217, 2389, 2554, 2653, 2716, 2783, 2845, 2908, 2970, 3014, 3071, 3133, 3206, 1201, 1245, 1284, 1365, 1447, 1526, 1620, 1698, 1733, 1811, 1857, 1899, 1937, 2035, 2081, 2123, 2167, 2274, 2326, 2452, 2603, 2687, 2756, 2826, 2879, 2940, 2992, 3048, 3103, 3164]))

xs = range(minimum(ADC), maximum(ADC), 1000)

g(x) = [x^4 x^3 x^2  x 1]

nA = reduce(vcat, g.(ADC))

fourthOrderCoeffs = Float32.(nA \ dBm_expected)

fourthOrder(x) = fourthOrderCoeffs[1]x^4 + fourthOrderCoeffs[2]x^3 + fourthOrderCoeffs[3]x^2 + fourthOrderCoeffs[4]x + fourthOrderCoeffs[5]

nPic = Plots.plot(ADC,
                  dBm_expected,
                  linetype=:scatter,
                  xlabel="ADC",
                  ylabel="dBm",
                  label="dbm, ADC pairs",
                  title="4th order")

fourthOrderYs = fourthOrder.(xs)

fourthOrderError = sum(err.(dBm_expected, fourthOrder.(ADC)))

nPic = Plots.plot!(xs,
                   fourthOrderYs,
                   label="fit function, error = " * string(round(fourthOrderError, digits=4)))

@show fourthOrderCoeffs
@show fourthOrderError
@show nPic
