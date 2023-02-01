import Plots

ADC = [800;817;846;869;901;938;981;1018;1060;1098;1138;1322;1401;1488;1583;1661;1777;1997;2217;2389;2554;2653;2716;2783;2845;2908;2970;3014;3071;3133;3206]
dBm_expected = [0;-1;-2;-3;-4;-5;-6;-7;-8;-9;-10;-14;-16;-18;-20;-22;-25;-30;-35;-38;-40;-42;-44;-46;-48;-50;-52;-54;-56;-58;-60]

pic = Plots.plot(ADC,
                 dBm_expected,
                 linetype=:scatter,
                 xlabel="ADC",
                 ylabel="dBm",
                 label="dBm, ADC pairs",
                 title="1st order")

#A = ones(31, 2) .* [dBm_expected ones(31)]
A = ones(31, 2) .* [ADC ones(31)]

#coeffs = A\ADC
firstOrderCoeffs = A \ dBm_expected

firstOrder(x) = firstOrderCoeffs[1]x + firstOrderCoeffs[2]

xs = range(minimum(ADC), maximum(ADC), 1000)
firstOrderYs = firstOrder.(xs)

pic = Plots.plot!(xs,
                  firstOrderYs,
                  label="fit function")

Plots.png(pic, "fitImage1stOrder")

#@show pic

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

nPic = Plots.plot!(xs,
                   thirdOrderYs,
                   label="fit function")

Plots.png(nPic, "fitImage3rdOrder")

#@show nPic

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

nPic = Plots.plot!(xs,
                   fourthOrderYs,
                   label="fit function")

Plots.png(nPic, "fitImage4thOrder")

#@show nPic

@show firstOrderCoeffs
@show thirdOrderCoeffs
@show fourthOrderCoeffs
