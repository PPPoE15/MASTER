/*
 * sldrtex_PLC_reg.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "sldrtex_PLC_reg".
 *
 * Model version              : 1.13
 * Simulink Coder version : 9.6 (R2021b) 14-May-2021
 * C source code generated on : Thu May  4 04:01:27 2023
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "sldrtex_PLC_reg.h"
#include "sldrtex_PLC_reg_private.h"
#include "sldrtex_PLC_reg_dt.h"

/* list of Simulink Desktop Real-Time timers */
const int SLDRTTimerCount = 2;
const double SLDRTTimers[4] = {
  0.01, 0.0,
  0.02, 0.0,
};

/* Block signals (default storage) */
B_sldrtex_PLC_reg_T sldrtex_PLC_reg_B;

/* Continuous states */
X_sldrtex_PLC_reg_T sldrtex_PLC_reg_X;

/* Block states (default storage) */
DW_sldrtex_PLC_reg_T sldrtex_PLC_reg_DW;

/* Real-time model */
static RT_MODEL_sldrtex_PLC_reg_T sldrtex_PLC_reg_M_;
RT_MODEL_sldrtex_PLC_reg_T *const sldrtex_PLC_reg_M = &sldrtex_PLC_reg_M_;
static void rate_monotonic_scheduler(void);
time_T rt_SimUpdateDiscreteEvents(
  int_T rtmNumSampTimes, void *rtmTimingData, int_T *rtmSampleHitPtr, int_T
  *rtmPerTaskSampleHits )
{
  rtmSampleHitPtr[1] = rtmStepTask(sldrtex_PLC_reg_M, 1);
  rtmSampleHitPtr[2] = rtmStepTask(sldrtex_PLC_reg_M, 2);
  UNUSED_PARAMETER(rtmNumSampTimes);
  UNUSED_PARAMETER(rtmTimingData);
  UNUSED_PARAMETER(rtmPerTaskSampleHits);
  return(-1);
}

/*
 *         This function updates active task flag for each subrate
 *         and rate transition flags for tasks that exchange data.
 *         The function assumes rate-monotonic multitasking scheduler.
 *         The function must be called at model base rate so that
 *         the generated code self-manages all its subrates and rate
 *         transition flags.
 */
static void rate_monotonic_scheduler(void)
{
  /* Compute which subrates run during the next base time step.  Subrates
   * are an integer multiple of the base rate counter.  Therefore, the subtask
   * counter is reset when it reaches its limit (zero means run).
   */
  (sldrtex_PLC_reg_M->Timing.TaskCounters.TID[2])++;
  if ((sldrtex_PLC_reg_M->Timing.TaskCounters.TID[2]) > 1) {/* Sample time: [0.02s, 0.0s] */
    sldrtex_PLC_reg_M->Timing.TaskCounters.TID[2] = 0;
  }
}

/*
 * This function updates continuous states using the ODE5 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  /* Solver Matrices */
  static const real_T rt_ODE5_A[6] = {
    1.0/5.0, 3.0/10.0, 4.0/5.0, 8.0/9.0, 1.0, 1.0
  };

  static const real_T rt_ODE5_B[6][6] = {
    { 1.0/5.0, 0.0, 0.0, 0.0, 0.0, 0.0 },

    { 3.0/40.0, 9.0/40.0, 0.0, 0.0, 0.0, 0.0 },

    { 44.0/45.0, -56.0/15.0, 32.0/9.0, 0.0, 0.0, 0.0 },

    { 19372.0/6561.0, -25360.0/2187.0, 64448.0/6561.0, -212.0/729.0, 0.0, 0.0 },

    { 9017.0/3168.0, -355.0/33.0, 46732.0/5247.0, 49.0/176.0, -5103.0/18656.0,
      0.0 },

    { 35.0/384.0, 0.0, 500.0/1113.0, 125.0/192.0, -2187.0/6784.0, 11.0/84.0 }
  };

  time_T t = rtsiGetT(si);
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE5_IntgData *id = (ODE5_IntgData *)rtsiGetSolverData(si);
  real_T *y = id->y;
  real_T *f0 = id->f[0];
  real_T *f1 = id->f[1];
  real_T *f2 = id->f[2];
  real_T *f3 = id->f[3];
  real_T *f4 = id->f[4];
  real_T *f5 = id->f[5];
  real_T hB[6];
  int_T i;
  int_T nXc = 2;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  sldrtex_PLC_reg_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE5_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE5_A[0]);
  rtsiSetdX(si, f1);
  sldrtex_PLC_reg_output0();
  sldrtex_PLC_reg_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE5_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE5_A[1]);
  rtsiSetdX(si, f2);
  sldrtex_PLC_reg_output0();
  sldrtex_PLC_reg_derivatives();

  /* f(:,4) = feval(odefile, t + hA(3), y + f*hB(:,3), args(:)(*)); */
  for (i = 0; i <= 2; i++) {
    hB[i] = h * rt_ODE5_B[2][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2]);
  }

  rtsiSetT(si, t + h*rt_ODE5_A[2]);
  rtsiSetdX(si, f3);
  sldrtex_PLC_reg_output0();
  sldrtex_PLC_reg_derivatives();

  /* f(:,5) = feval(odefile, t + hA(4), y + f*hB(:,4), args(:)(*)); */
  for (i = 0; i <= 3; i++) {
    hB[i] = h * rt_ODE5_B[3][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2] +
                   f3[i]*hB[3]);
  }

  rtsiSetT(si, t + h*rt_ODE5_A[3]);
  rtsiSetdX(si, f4);
  sldrtex_PLC_reg_output0();
  sldrtex_PLC_reg_derivatives();

  /* f(:,6) = feval(odefile, t + hA(5), y + f*hB(:,5), args(:)(*)); */
  for (i = 0; i <= 4; i++) {
    hB[i] = h * rt_ODE5_B[4][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2] +
                   f3[i]*hB[3] + f4[i]*hB[4]);
  }

  rtsiSetT(si, tnew);
  rtsiSetdX(si, f5);
  sldrtex_PLC_reg_output0();
  sldrtex_PLC_reg_derivatives();

  /* tnew = t + hA(6);
     ynew = y + f*hB(:,6); */
  for (i = 0; i <= 5; i++) {
    hB[i] = h * rt_ODE5_B[5][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2] +
                   f3[i]*hB[3] + f4[i]*hB[4] + f5[i]*hB[5]);
  }

  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/* Model output function for TID0 */
void sldrtex_PLC_reg_output0(void)     /* Sample time: [0.0s, 0.0s] */
{
  real_T tmp;
  if (rtmIsMajorTimeStep(sldrtex_PLC_reg_M)) {
    /* set solver stop time */
    if (!(sldrtex_PLC_reg_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&sldrtex_PLC_reg_M->solverInfo,
                            ((sldrtex_PLC_reg_M->Timing.clockTickH0 + 1) *
        sldrtex_PLC_reg_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&sldrtex_PLC_reg_M->solverInfo,
                            ((sldrtex_PLC_reg_M->Timing.clockTick0 + 1) *
        sldrtex_PLC_reg_M->Timing.stepSize0 +
        sldrtex_PLC_reg_M->Timing.clockTickH0 *
        sldrtex_PLC_reg_M->Timing.stepSize0 * 4294967296.0));
    }

    {                                  /* Sample time: [0.0s, 0.0s] */
      rate_monotonic_scheduler();
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(sldrtex_PLC_reg_M)) {
    sldrtex_PLC_reg_M->Timing.t[0] = rtsiGetT(&sldrtex_PLC_reg_M->solverInfo);
  }

  /* TransferFcn: '<Root>/Transfer Fcn' */
  sldrtex_PLC_reg_B.TransferFcn = 0.0;
  sldrtex_PLC_reg_B.TransferFcn += sldrtex_PLC_reg_P.TransferFcn_C[0] *
    sldrtex_PLC_reg_X.TransferFcn_CSTATE[0];
  sldrtex_PLC_reg_B.TransferFcn += sldrtex_PLC_reg_P.TransferFcn_C[1] *
    sldrtex_PLC_reg_X.TransferFcn_CSTATE[1];
  if (rtmIsMajorTimeStep(sldrtex_PLC_reg_M)) {
    /* ZeroOrderHold: '<Root>/Zero-Order Hold' */
    sldrtex_PLC_reg_B.ZeroOrderHold = sldrtex_PLC_reg_B.TransferFcn;
  }

  /* Step: '<Root>/Step' */
  if (sldrtex_PLC_reg_M->Timing.t[0] < sldrtex_PLC_reg_P.Step_Time) {
    tmp = sldrtex_PLC_reg_P.Step_Y0;
  } else {
    tmp = sldrtex_PLC_reg_P.Step_YFinal;
  }

  /* End of Step: '<Root>/Step' */

  /* Sum: '<Root>/Sum' */
  sldrtex_PLC_reg_B.Sum = tmp - sldrtex_PLC_reg_B.ZeroOrderHold;
  if (rtmIsMajorTimeStep(sldrtex_PLC_reg_M)) {
    /* SampleTimeMath: '<S30>/Tsamp' incorporates:
     *  Gain: '<S27>/Derivative Gain'
     *
     * About '<S30>/Tsamp':
     *  y = u * K where K = 1 / ( w * Ts )
     */
    sldrtex_PLC_reg_B.Tsamp = sldrtex_PLC_reg_P.DiscretePIDController_D *
      sldrtex_PLC_reg_B.Sum * sldrtex_PLC_reg_P.Tsamp_WtEt;

    /* Gain: '<S32>/Integral Gain' */
    sldrtex_PLC_reg_B.IntegralGain = sldrtex_PLC_reg_P.DiscretePIDController_I *
      sldrtex_PLC_reg_B.Sum;

    /* Sum: '<S44>/Sum' incorporates:
     *  Delay: '<S28>/UD'
     *  DiscreteIntegrator: '<S35>/Integrator'
     *  Gain: '<S40>/Proportional Gain'
     *  Sum: '<S28>/Diff'
     */
    sldrtex_PLC_reg_B.Sum_g = (sldrtex_PLC_reg_P.DiscretePIDController_P *
      sldrtex_PLC_reg_B.Sum + sldrtex_PLC_reg_DW.Integrator_DSTATE) +
      (sldrtex_PLC_reg_B.Tsamp - sldrtex_PLC_reg_DW.UD_DSTATE);
  }
}

/* Model update function for TID0 */
void sldrtex_PLC_reg_update0(void)     /* Sample time: [0.0s, 0.0s] */
{
  if (rtmIsMajorTimeStep(sldrtex_PLC_reg_M)) {
    /* Update for Delay: '<S28>/UD' */
    sldrtex_PLC_reg_DW.UD_DSTATE = sldrtex_PLC_reg_B.Tsamp;

    /* Update for DiscreteIntegrator: '<S35>/Integrator' */
    sldrtex_PLC_reg_DW.Integrator_DSTATE += sldrtex_PLC_reg_P.Integrator_gainval
      * sldrtex_PLC_reg_B.IntegralGain;
  }

  if (rtmIsMajorTimeStep(sldrtex_PLC_reg_M)) {
    rt_ertODEUpdateContinuousStates(&sldrtex_PLC_reg_M->solverInfo);
  }

  /* Update absolute time */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++sldrtex_PLC_reg_M->Timing.clockTick0)) {
    ++sldrtex_PLC_reg_M->Timing.clockTickH0;
  }

  sldrtex_PLC_reg_M->Timing.t[0] = rtsiGetSolverStopTime
    (&sldrtex_PLC_reg_M->solverInfo);

  /* Update absolute time */
  /* The "clockTick1" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick1"
   * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick1 and the high bits
   * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++sldrtex_PLC_reg_M->Timing.clockTick1)) {
    ++sldrtex_PLC_reg_M->Timing.clockTickH1;
  }

  sldrtex_PLC_reg_M->Timing.t[1] = sldrtex_PLC_reg_M->Timing.clockTick1 *
    sldrtex_PLC_reg_M->Timing.stepSize1 + sldrtex_PLC_reg_M->Timing.clockTickH1 *
    sldrtex_PLC_reg_M->Timing.stepSize1 * 4294967296.0;
}

/* Derivatives for root system: '<Root>' */
void sldrtex_PLC_reg_derivatives(void)
{
  XDot_sldrtex_PLC_reg_T *_rtXdot;
  _rtXdot = ((XDot_sldrtex_PLC_reg_T *) sldrtex_PLC_reg_M->derivs);

  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn' */
  _rtXdot->TransferFcn_CSTATE[0] = 0.0;
  _rtXdot->TransferFcn_CSTATE[0] += sldrtex_PLC_reg_P.TransferFcn_A[0] *
    sldrtex_PLC_reg_X.TransferFcn_CSTATE[0];
  _rtXdot->TransferFcn_CSTATE[1] = 0.0;
  _rtXdot->TransferFcn_CSTATE[0] += sldrtex_PLC_reg_P.TransferFcn_A[1] *
    sldrtex_PLC_reg_X.TransferFcn_CSTATE[1];
  _rtXdot->TransferFcn_CSTATE[1] += sldrtex_PLC_reg_X.TransferFcn_CSTATE[0];
  _rtXdot->TransferFcn_CSTATE[0] += sldrtex_PLC_reg_B.Sum_g;
}

/* Model output function for TID2 */
void sldrtex_PLC_reg_output2(void)     /* Sample time: [0.02s, 0.0s] */
{
  /* S-Function (sldrtsync): '<Root>/Real-Time Synchronization' */
  /* S-Function Block: <Root>/Real-Time Synchronization */
  {
    sldrtex_PLC_reg_B.RealTimeSynchronization = 0;/* Missed Ticks value is always zero */
  }
}

/* Model update function for TID2 */
void sldrtex_PLC_reg_update2(void)     /* Sample time: [0.02s, 0.0s] */
{
  /* Update absolute time */
  /* The "clockTick2" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick2"
   * and "Timing.stepSize2". Size of "clockTick2" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick2 and the high bits
   * Timing.clockTickH2. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++sldrtex_PLC_reg_M->Timing.clockTick2)) {
    ++sldrtex_PLC_reg_M->Timing.clockTickH2;
  }

  sldrtex_PLC_reg_M->Timing.t[2] = sldrtex_PLC_reg_M->Timing.clockTick2 *
    sldrtex_PLC_reg_M->Timing.stepSize2 + sldrtex_PLC_reg_M->Timing.clockTickH2 *
    sldrtex_PLC_reg_M->Timing.stepSize2 * 4294967296.0;
}

/* Use this function only if you need to maintain compatibility with an existing static main program. */
void sldrtex_PLC_reg_output(int_T tid)
{
  switch (tid) {
   case 0 :
    sldrtex_PLC_reg_output0();
    break;

   case 2 :
    sldrtex_PLC_reg_output2();
    break;

   default :
    /* do nothing */
    break;
  }
}

/* Use this function only if you need to maintain compatibility with an existing static main program. */
void sldrtex_PLC_reg_update(int_T tid)
{
  switch (tid) {
   case 0 :
    sldrtex_PLC_reg_update0();
    break;

   case 2 :
    sldrtex_PLC_reg_update2();
    break;

   default :
    /* do nothing */
    break;
  }
}

/* Model initialize function */
void sldrtex_PLC_reg_initialize(void)
{
  /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn' */
  sldrtex_PLC_reg_X.TransferFcn_CSTATE[0] = 0.0;
  sldrtex_PLC_reg_X.TransferFcn_CSTATE[1] = 0.0;

  /* InitializeConditions for Delay: '<S28>/UD' */
  sldrtex_PLC_reg_DW.UD_DSTATE =
    sldrtex_PLC_reg_P.DiscretePIDController_DifferentiatorICPrevScaledInput;

  /* InitializeConditions for DiscreteIntegrator: '<S35>/Integrator' */
  sldrtex_PLC_reg_DW.Integrator_DSTATE =
    sldrtex_PLC_reg_P.DiscretePIDController_InitialConditionForIntegrator;
}

/* Model terminate function */
void sldrtex_PLC_reg_terminate(void)
{
  /* (no terminate code required) */
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/

/* Solver interface called by GRT_Main */
#ifndef USE_GENERATED_SOLVER

void rt_ODECreateIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEDestroyIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEUpdateContinuousStates(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

#endif

void MdlOutputs(int_T tid)
{
  if (tid == 1)
    tid = 0;
  sldrtex_PLC_reg_output(tid);
}

void MdlUpdate(int_T tid)
{
  if (tid == 1)
    tid = 0;
  sldrtex_PLC_reg_update(tid);
}

void MdlInitializeSizes(void)
{
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  sldrtex_PLC_reg_initialize();
}

void MdlTerminate(void)
{
  sldrtex_PLC_reg_terminate();
}

/* Registration function */
RT_MODEL_sldrtex_PLC_reg_T *sldrtex_PLC_reg(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* non-finite (run-time) assignments */
  sldrtex_PLC_reg_P.RealTimeSynchronization_MaxMissedTicks = rtInf;

  /* initialize real-time model */
  (void) memset((void *)sldrtex_PLC_reg_M, 0,
                sizeof(RT_MODEL_sldrtex_PLC_reg_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&sldrtex_PLC_reg_M->solverInfo,
                          &sldrtex_PLC_reg_M->Timing.simTimeStep);
    rtsiSetTPtr(&sldrtex_PLC_reg_M->solverInfo, &rtmGetTPtr(sldrtex_PLC_reg_M));
    rtsiSetStepSizePtr(&sldrtex_PLC_reg_M->solverInfo,
                       &sldrtex_PLC_reg_M->Timing.stepSize0);
    rtsiSetdXPtr(&sldrtex_PLC_reg_M->solverInfo, &sldrtex_PLC_reg_M->derivs);
    rtsiSetContStatesPtr(&sldrtex_PLC_reg_M->solverInfo, (real_T **)
                         &sldrtex_PLC_reg_M->contStates);
    rtsiSetNumContStatesPtr(&sldrtex_PLC_reg_M->solverInfo,
      &sldrtex_PLC_reg_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&sldrtex_PLC_reg_M->solverInfo,
      &sldrtex_PLC_reg_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&sldrtex_PLC_reg_M->solverInfo,
      &sldrtex_PLC_reg_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&sldrtex_PLC_reg_M->solverInfo,
      &sldrtex_PLC_reg_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&sldrtex_PLC_reg_M->solverInfo, (&rtmGetErrorStatus
      (sldrtex_PLC_reg_M)));
    rtsiSetRTModelPtr(&sldrtex_PLC_reg_M->solverInfo, sldrtex_PLC_reg_M);
  }

  rtsiSetSimTimeStep(&sldrtex_PLC_reg_M->solverInfo, MAJOR_TIME_STEP);
  sldrtex_PLC_reg_M->intgData.y = sldrtex_PLC_reg_M->odeY;
  sldrtex_PLC_reg_M->intgData.f[0] = sldrtex_PLC_reg_M->odeF[0];
  sldrtex_PLC_reg_M->intgData.f[1] = sldrtex_PLC_reg_M->odeF[1];
  sldrtex_PLC_reg_M->intgData.f[2] = sldrtex_PLC_reg_M->odeF[2];
  sldrtex_PLC_reg_M->intgData.f[3] = sldrtex_PLC_reg_M->odeF[3];
  sldrtex_PLC_reg_M->intgData.f[4] = sldrtex_PLC_reg_M->odeF[4];
  sldrtex_PLC_reg_M->intgData.f[5] = sldrtex_PLC_reg_M->odeF[5];
  sldrtex_PLC_reg_M->contStates = ((real_T *) &sldrtex_PLC_reg_X);
  rtsiSetSolverData(&sldrtex_PLC_reg_M->solverInfo, (void *)
                    &sldrtex_PLC_reg_M->intgData);
  rtsiSetSolverName(&sldrtex_PLC_reg_M->solverInfo,"ode5");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = sldrtex_PLC_reg_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;
    mdlTsMap[2] = 2;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "sldrtex_PLC_reg_M points to
       static memory which is guaranteed to be non-NULL" */
    sldrtex_PLC_reg_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    sldrtex_PLC_reg_M->Timing.sampleTimes =
      (&sldrtex_PLC_reg_M->Timing.sampleTimesArray[0]);
    sldrtex_PLC_reg_M->Timing.offsetTimes =
      (&sldrtex_PLC_reg_M->Timing.offsetTimesArray[0]);

    /* task periods */
    sldrtex_PLC_reg_M->Timing.sampleTimes[0] = (0.0);
    sldrtex_PLC_reg_M->Timing.sampleTimes[1] = (0.01);
    sldrtex_PLC_reg_M->Timing.sampleTimes[2] = (0.02);

    /* task offsets */
    sldrtex_PLC_reg_M->Timing.offsetTimes[0] = (0.0);
    sldrtex_PLC_reg_M->Timing.offsetTimes[1] = (0.0);
    sldrtex_PLC_reg_M->Timing.offsetTimes[2] = (0.0);
  }

  rtmSetTPtr(sldrtex_PLC_reg_M, &sldrtex_PLC_reg_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = sldrtex_PLC_reg_M->Timing.sampleHitArray;
    int_T *mdlPerTaskSampleHits =
      sldrtex_PLC_reg_M->Timing.perTaskSampleHitsArray;
    sldrtex_PLC_reg_M->Timing.perTaskSampleHits = (&mdlPerTaskSampleHits[0]);
    mdlSampleHits[0] = 1;
    sldrtex_PLC_reg_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(sldrtex_PLC_reg_M, 2.0);
  sldrtex_PLC_reg_M->Timing.stepSize0 = 0.01;
  sldrtex_PLC_reg_M->Timing.stepSize1 = 0.01;
  sldrtex_PLC_reg_M->Timing.stepSize2 = 0.02;

  /* External mode info */
  sldrtex_PLC_reg_M->Sizes.checksums[0] = (694181879U);
  sldrtex_PLC_reg_M->Sizes.checksums[1] = (1131154076U);
  sldrtex_PLC_reg_M->Sizes.checksums[2] = (3475416291U);
  sldrtex_PLC_reg_M->Sizes.checksums[3] = (2787510189U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[1];
    sldrtex_PLC_reg_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(sldrtex_PLC_reg_M->extModeInfo,
      &sldrtex_PLC_reg_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(sldrtex_PLC_reg_M->extModeInfo,
                        sldrtex_PLC_reg_M->Sizes.checksums);
    rteiSetTPtr(sldrtex_PLC_reg_M->extModeInfo, rtmGetTPtr(sldrtex_PLC_reg_M));
  }

  sldrtex_PLC_reg_M->solverInfoPtr = (&sldrtex_PLC_reg_M->solverInfo);
  sldrtex_PLC_reg_M->Timing.stepSize = (0.01);
  rtsiSetFixedStepSize(&sldrtex_PLC_reg_M->solverInfo, 0.01);
  rtsiSetSolverMode(&sldrtex_PLC_reg_M->solverInfo, SOLVER_MODE_MULTITASKING);

  /* block I/O */
  sldrtex_PLC_reg_M->blockIO = ((void *) &sldrtex_PLC_reg_B);
  (void) memset(((void *) &sldrtex_PLC_reg_B), 0,
                sizeof(B_sldrtex_PLC_reg_T));

  /* parameters */
  sldrtex_PLC_reg_M->defaultParam = ((real_T *)&sldrtex_PLC_reg_P);

  /* states (continuous) */
  {
    real_T *x = (real_T *) &sldrtex_PLC_reg_X;
    sldrtex_PLC_reg_M->contStates = (x);
    (void) memset((void *)&sldrtex_PLC_reg_X, 0,
                  sizeof(X_sldrtex_PLC_reg_T));
  }

  /* states (dwork) */
  sldrtex_PLC_reg_M->dwork = ((void *) &sldrtex_PLC_reg_DW);
  (void) memset((void *)&sldrtex_PLC_reg_DW, 0,
                sizeof(DW_sldrtex_PLC_reg_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    sldrtex_PLC_reg_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 18;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  sldrtex_PLC_reg_M->Sizes.numContStates = (2);/* Number of continuous states */
  sldrtex_PLC_reg_M->Sizes.numPeriodicContStates = (0);
                                      /* Number of periodic continuous states */
  sldrtex_PLC_reg_M->Sizes.numY = (0); /* Number of model outputs */
  sldrtex_PLC_reg_M->Sizes.numU = (0); /* Number of model inputs */
  sldrtex_PLC_reg_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  sldrtex_PLC_reg_M->Sizes.numSampTimes = (3);/* Number of sample times */
  sldrtex_PLC_reg_M->Sizes.numBlocks = (15);/* Number of blocks */
  sldrtex_PLC_reg_M->Sizes.numBlockIO = (7);/* Number of block outputs */
  sldrtex_PLC_reg_M->Sizes.numBlockPrms = (16);/* Sum of parameter "widths" */
  return sldrtex_PLC_reg_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
