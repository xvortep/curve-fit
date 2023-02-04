/*
depends on
    libgsl-dev

build with
    gcc interp.c -lgsl -lm -lgslcblas (--static)
run with
    ./a.out >interp.dat
test with
    graph -T ps <interp.dat >interp.ps
*/

#include <stdio.h>
#include <stdlib.h>
#include <gsl/gsl_spline.h>
#include <gsl/gsl_errno.h>

#define RESOLUTION (61)

double ADC[RESOLUTION] = {800.0, 817.0, 846.0, 869.0, 901.0, 938.0, 981.0, 1018.0, 1060.0, 1098.0, 1138.0, 1201.0, 1245.0, 1284.0, 1322.0, 1365.0, 1401.0, 1447.0, 1488.0, 1526.0, 1583.0, 1620.0, 1661.0, 1698.0, 1733.0, 1777.0, 1811.0, 1857.0, 1899.0, 1937.0, 1997.0, 2035.0, 2081.0, 2123.0, 2167.0, 2217.0, 2274.0, 2326.0, 2389.0, 2452.0, 2522.0, 2603.0, 2653.0, 2687.0, 2716.0, 2756.0, 2783.0, 2826.0, 2845.0, 2879.0, 2908.0, 2940.0, 2970.0, 2992.0, 3014.0, 3048.0, 3071.0, 3103.0, 3133.0, 3164.0, 3206.0};
double dBm[RESOLUTION] = {0, -1, -2, -3, -4, -5, -6, -7, -8, -9, -10, -11, -12, -13, -14, -15, -16, -17, -18, -19, -20, -21, -22, -23, -24, -25, -26, -27, -28, -29, -30, -31, -32, -33, -34, -35, -36, -37, -38, -39, -40, -41, -42, -43, -44, -45, -46, -47, -48, -49, -50, -51, -52, -53, -54, -55, -56, -57, -58, -59, -60};

int
main(void)
{
    double xi, yi;
    double *x = ADC;
    double *y = dBm;
    int i;

    printf ("#m=0,S=2\n");
     
    for (i = 0; i < RESOLUTION; i++) {    
        printf ("%g %g\n", x[i], y[i]);
    }
    
    printf ("#m=1,S=0\n");

    gsl_interp_accel *acc = gsl_interp_accel_alloc();
    gsl_spline *spline = gsl_spline_alloc(gsl_interp_linear, RESOLUTION);

    gsl_spline_init(spline, x, y, RESOLUTION);

    for (xi = ADC[0]; xi < x[RESOLUTION - 1]; xi += 0.01) {
        yi = gsl_spline_eval(spline, xi, acc);
        printf("%g %g\n", xi, yi);
    }
    gsl_spline_free(spline);
    gsl_interp_accel_free(acc);

    return 0;
}
