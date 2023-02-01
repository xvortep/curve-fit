import Plots

err(x, y) = (x - y)^2

ADC = [800;817;846;869;901;938;981;1018;1060;1098;1138;1322;1401;1488;1583;1661;1777;1997;2217;2389;2554;2653;2716;2783;2845;2908;2970;3014;3071;3133;3206]
dBm_expected = [0;-1;-2;-3;-4;-5;-6;-7;-8;-9;-10;-14;-16;-18;-20;-22;-25;-30;-35;-38;-40;-42;-44;-46;-48;-50;-52;-54;-56;-58;-60]

pic = Plots.plot(ADC,
                 dBm_expected,
                 linetype=:scatter,
                 xlabel="ADC",
                 ylabel="dBm",
                 label="dBm, ADC pairs",
                 title="1st order")

A = ones(31, 2) .* [ADC ones(31)]

#coeffs = A\ADC
firstOrderCoeffs = A \ dBm_expected

firstOrder(x) = firstOrderCoeffs[1]x + firstOrderCoeffs[2]

xs = range(minimum(ADC), maximum(ADC), 1000)
firstOrderYs = firstOrder.(xs)

firstOrderError = sum(err.(dBm_expected, firstOrder.(ADC)))

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

secondOrderError = sum(err.(dBm_expected, secondOrder.(ADC)))

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

thirdOrderError = sum(err.(dBm_expected, thirdOrder.(ADC)))

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

fourthOrderError = sum(err.(dBm_expected, fourthOrder.(ADC)))

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
                   secondOrderYs,
                   label="1st order fit function, error = " * string(round(secondOrderError, digits=4)))
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
