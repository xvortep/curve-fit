import Plots

ADC = [800;817;846;869;901;938;981;1018;1060;1098;1138;1322;1401;1488;1583;1661;1777;1997;2217;2389;2554;2653;2716;2783;2845;2908;2970;3014;3071;3133;3206]
dBm_expected = [0;-1;-2;-3;-4;-5;-6;-7;-8;-9;-10;-14;-16;-18;-20;-22;-25;-30;-35;-38;-40;-42;-44;-46;-48;-50;-52;-54;-56;-58;-60]

pic = Plots.plot(ADC, dBm_expected, linetype=:scatter, label="dBm, ADC pairs", title="could be better with 3rd or 4th degree polynomial")

#A = ones(31, 2) .* [dBm_expected ones(31)]
A = ones(31, 2) .* [ADC ones(31)]

#coeffs = A\ADC
coeffs = A\dBm_expected

f(x) = coeffs[1]x + coeffs[2]

xs = range(minimum(ADC), maximum(ADC), 1000)
ys = f.(xs)

pic = Plots.plot!(xs, ys, label="fit function")

Plots.png(pic, "fitImage")

@show pic
