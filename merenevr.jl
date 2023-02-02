import Plots

err(x, y) = (x - y)^2

#force 64bit float type
ADC = Float64.(sort([800, 817, 846, 869, 901, 938, 981, 1018, 1060, 1098, 1138, 1322, 1401, 1488, 1583, 1661, 1777, 1997, 2217, 2389, 2554, 2653, 2716, 2783, 2845, 2908, 2970, 3014, 3071, 3133, 3206, 1201, 1245, 1284, 1365, 1447, 1526, 1620, 1698, 1733, 1811, 1857, 1899, 1937, 2035, 2081, 2123, 2167, 2274, 2326, 2452, 2603, 2687, 2756, 2826, 2879, 2940, 2992, 3048, 3103, 3164]))
dBm_expected = Float64.(rotr90((0:-1:-60)'))

pic = Plots.plot(ADC,
                 dBm_expected,
                 linetype=:scatter,
                 xlabel="ADC",
                 ylabel="dBm",
                 label="dBm, ADC pairs",
                 title="1st order")

g(x) = [x 1]
A = reduce(vcat, g.(ADC))

firstOrderCoeffs = A \ dBm_expected

firstOrder(x) = firstOrderCoeffs[1]x + firstOrderCoeffs[2]

xs = range(minimum(ADC), maximum(ADC), 1000)
firstOrderYs = firstOrder.(xs)

mat = maximum(firstOrder.(ADC) .- dBm_expected)
@show mat

firstOrderError = 0.5 * sum(err.(dBm_expected, firstOrder.(ADC)))

pic = Plots.plot!(xs,
                  firstOrderYs,
                  label="fit function, error = " * string(round(firstOrderError, digits=4)))

Plots.svg(pic, "fitImage1stOrder")

#2nd order polynomial
g(x) = [x^2  x 1]

nA = reduce(vcat, g.(ADC))

secondOrderCoeffs = nA \ dBm_expected

secondOrder(x) = secondOrderCoeffs[1]x^2 + secondOrderCoeffs[2]x + secondOrderCoeffs[3]

nPic = Plots.plot(ADC,
                  dBm_expected,
                  linetype=:scatter,
                  xlabel="ADC",
                  ylabel="dBm",
                  label="dbm, ADC pairs",
                  title="2nd order")

secondOrderYs = secondOrder.(xs)

secondOrderError = 0.5 * sum(err.(dBm_expected, secondOrder.(ADC)))

nPic = Plots.plot!(xs,
                   secondOrderYs,
                   label="fit function, error = " * string(round(secondOrderError, digits=4)))

Plots.svg(nPic, "fitImage2ndOrder")

#3rd order polynomial
g(x) = [x^3 x^2  x 1]

nA = reduce(vcat, g.(ADC))

thirdOrderCoeffs = nA \ dBm_expected

thirdOrder(x) = thirdOrderCoeffs[1]x^3 + thirdOrderCoeffs[2]x^2 + thirdOrderCoeffs[3]x + thirdOrderCoeffs[4]

nPic = Plots.plot(ADC,
                  dBm_expected,
                  linetype=:scatter,
                  xlabel="ADC",
                  ylabel="dBm",
                  label="dbm, ADC pairs",
                  title="3rd order")

thirdOrderYs = thirdOrder.(xs)

thirdOrderError = 0.5 * sum(err.(dBm_expected, thirdOrder.(ADC)))

nPic = Plots.plot!(xs,
                   thirdOrderYs,
                   label="fit function, error = " * string(round(thirdOrderError, digits=4)))

Plots.svg(nPic, "fitImage3rdOrder")

#4th order polynomial
g(x) = [x^4 x^3 x^2  x 1]

nA = reduce(vcat, g.(ADC))

fourthOrderCoeffs = nA \ dBm_expected

fourthOrder(x) = fourthOrderCoeffs[1]x^4 + fourthOrderCoeffs[2]x^3 + fourthOrderCoeffs[3]x^2 + fourthOrderCoeffs[4]x + fourthOrderCoeffs[5]

nPic = Plots.plot(ADC,
                  dBm_expected,
                  linetype=:scatter,
                  xlabel="ADC",
                  ylabel="dBm",
                  label="dbm, ADC pairs",
                  title="4th order")

fourthOrderYs = fourthOrder.(xs)

fourthOrderError = 0.5 * sum(err.(dBm_expected, fourthOrder.(ADC)))

nPic = Plots.plot!(xs,
                   fourthOrderYs,
                   label="fit function, error = " * string(round(fourthOrderError, digits=4)))

Plots.svg(nPic, "fitImage4thOrder")

nPic = Plots.plot(ADC,
                  dBm_expected,
                  linetype=:scatter,
                  xlabel="ADC",
                  ylabel="dBm",
                  label="dbm, ADC pairs",
                  title="comparison")
nPic = Plots.plot!(xs,
                   firstOrderYs,
                   label="1st order fit function, error = " * string(round(firstOrderError, digits=4)))
nPic = Plots.plot!(xs,
                   secondOrderYs,
                   label="2nd order fit function, error = " * string(round(secondOrderError, digits=4)))
nPic = Plots.plot!(xs,
                   thirdOrderYs,
                   label="3rd order fit function, error = " * string(round(thirdOrderError, digits=4)))
nPic = Plots.plot!(xs,
                   fourthOrderYs,
                   label="4th order fit function, error = " * string(round(fourthOrderError, digits=4)))

Plots.svg(nPic, "comparison")

@show firstOrderCoeffs
@show secondOrderCoeffs
@show thirdOrderCoeffs
@show fourthOrderCoeffs


#correction of linearization @credits djole

approx = fourthOrder.(ADC) .- firstOrder.(ADC)

Plots.plot(ADC, approx, linetype=:scatter)

#1st order function with estimated error

#betterFirstOrder(x) = 

#betterFirstOrderError = sum(err.(dBm_expected, ))