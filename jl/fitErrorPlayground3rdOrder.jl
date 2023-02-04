using Plots

err(x, y) = (x - y)^2


#ADC = Float64.([800;817;846;869;901;938;981;1018;1060;1098;1138;1322;1401;1488;1583;1661;1777;1997;2217;2389;2554;2653;2716;2783;2845;2908;2970;3014;3071;3133;3206])
#dBm_expected = Float64.([0;-1;-2;-3;-4;-5;-6;-7;-8;-9;-10;-14;-16;-18;-20;-22;-25;-30;-35;-38;-40;-42;-44;-46;-48;-50;-52;-54;-56;-58;-60])

dbm = 0:-1:-60
dbm = dbm'
dBm_expected = Float64.(rotr90(dbm))

ADC = Float64.(sort([800, 817, 846, 869, 901, 938, 981, 1018, 1060, 1098, 1138, 1322, 1401, 1488, 1583, 1661, 1777, 1997, 2217, 2389, 2554, 2653, 2716, 2783, 2845, 2908, 2970, 3014, 3071, 3133, 3206, 1201, 1245, 1284, 1365, 1447, 1526, 1620, 1698, 1733, 1811, 1857, 1899, 1937, 2035, 2081, 2123, 2167, 2274, 2326, 2452, 2603, 2687, 2756, 2826, 2879, 2940, 2992, 3048, 3103, 3164]))

xs = range(minimum(ADC), maximum(ADC), 1000)


g(x) = [x^3 x^2  x 1]

nA = reduce(vcat, g.(ADC))

#force 32bit float to estimate performance with arduino
thirdOrderCoeffs = Float32.(nA \ (dBm_expected))
thirdOrderCoeffs = thirdOrderCoeffs .* 1000000
thirdOrderCoeffs = round.(thirdOrderCoeffs, digits=5)


thirdOrder(x) = thirdOrderCoeffs[1]x^3 + thirdOrderCoeffs[2]x^2 + thirdOrderCoeffs[3]x + thirdOrderCoeffs[4]

nPic = Plots.plot(ADC,
                  dBm_expected,
                  linetype=:scatter,
                  xlabel="ADC",
                  ylabel="dBm",
                  label="dbm, ADC pairs",
                  title="3rd order")

thirdOrderYs = thirdOrder.(xs)

thirdOrderYs = thirdOrderYs ./ 1000000

thirdOrderError = sum(err.(dBm_expected, thirdOrder.(ADC) ./ 1000000))

nPic = Plots.plot!(xs,
                   thirdOrderYs,
                   label="fit function, error = " * string(round(thirdOrderError, digits=4)))

@show thirdOrderCoeffs
@show thirdOrderError
@show nPic
