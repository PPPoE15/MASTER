
/*
 * Include Files
 *
 */
#if defined(MATLAB_MEX_FILE)
#include "tmwtypes.h"
#include "simstruc_types.h"
#else
#include "rtwtypes.h"
#endif



/* %%%-SFUNWIZ_wrapper_includes_Changes_BEGIN --- EDIT HERE TO _END */
#include <math.h>
/* %%%-SFUNWIZ_wrapper_includes_Changes_END --- EDIT HERE TO _BEGIN */
#define u_width 1
#define y_width 1

/*
 * Create external references here.  
 *
 */
/* %%%-SFUNWIZ_wrapper_externs_Changes_BEGIN --- EDIT HERE TO _END */
/* extern double func(double a); */
/* %%%-SFUNWIZ_wrapper_externs_Changes_END --- EDIT HERE TO _BEGIN */

/*
 * Output function
 *
 */
void pid_regul_c_Outputs_wrapper(const real_T *u0,
			const real_T *u1,
			const real_T *u2,
			real_T *y0,
			real_T *y1,
			real_T *y2)
{
/* %%%-SFUNWIZ_wrapper_Outputs_Changes_BEGIN --- EDIT HERE TO _END */
float static input0=0;
float static input1=0;
float static input2=0;
float static output=0;
float static gain=0;
float static filtercoefficient=0;
float static input_prev=0;
float static filter=0;
float static filter_out=0;
float static integrator=0;
float static integrator_out=0;

input0=u0[0];
input1=u1[0];
input2=u2[0];

gain = 10.0 * input0;
filter=input2;
integrator=input1;
filtercoefficient = (0.0 - filter) * 100.0;
output = ((0.004333 * gain) + integrator) + filtercoefficient;
filter_out = (0.2 * filtercoefficient) + filter;
integrator_out = ((0.04333 * gain) * 0.2) + integrator;

y0[0]=output;
y1[0]=integrator_out;
y2[0]=filter_out;
/* %%%-SFUNWIZ_wrapper_Outputs_Changes_END --- EDIT HERE TO _BEGIN */
}


