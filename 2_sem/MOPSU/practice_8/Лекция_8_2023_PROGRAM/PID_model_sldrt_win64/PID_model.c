/*
 * PID_model.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "PID_model".
 *
 * Model version              : 3.1
 * Simulink Coder version : 9.6 (R2021b) 14-May-2021
 * C source code generated on : Thu May  4 18:38:14 2023
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "PID_model.h"
#include "PID_model_private.h"
#include "PID_model_dt.h"

/* list of Simulink Desktop Real-Time timers */
const int SLDRTTimerCount = 1;
const double SLDRTTimers[2] = {
  0.01, 0.0,
};

/* Block signals (default storage) */
B_PID_model_T PID_model_B;

/* Continuous states */
X_PID_model_T PID_model_X;

/* Block states (default storage) */
DW_PID_model_T PID_model_DW;

/* Real-time model */
static RT_MODEL_PID_model_T PID_model_M_;
RT_MODEL_PID_model_T *const PID_model_M = &PID_model_M_;

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
  PID_model_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE5_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE5_A[0]);
  rtsiSetdX(si, f1);
  PID_model_output();
  PID_model_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE5_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE5_A[1]);
  rtsiSetdX(si, f2);
  PID_model_output();
  PID_model_derivatives();

  /* f(:,4) = feval(odefile, t + hA(3), y + f*hB(:,3), args(:)(*)); */
  for (i = 0; i <= 2; i++) {
    hB[i] = h * rt_ODE5_B[2][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2]);
  }

  rtsiSetT(si, t + h*rt_ODE5_A[2]);
  rtsiSetdX(si, f3);
  PID_model_output();
  PID_model_derivatives();

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
  PID_model_output();
  PID_model_derivatives();

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
  PID_model_output();
  PID_model_derivatives();

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

/* Model output function */
void PID_model_output(void)
{
  if (rtmIsMajorTimeStep(PID_model_M)) {
    /* set solver stop time */
    if (!(PID_model_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&PID_model_M->solverInfo,
                            ((PID_model_M->Timing.clockTickH0 + 1) *
        PID_model_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&PID_model_M->solverInfo,
                            ((PID_model_M->Timing.clockTick0 + 1) *
        PID_model_M->Timing.stepSize0 + PID_model_M->Timing.clockTickH0 *
        PID_model_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(PID_model_M)) {
    PID_model_M->Timing.t[0] = rtsiGetT(&PID_model_M->solverInfo);
  }

  /* Integrator: '<Root>/Integrator' */
  PID_model_B.Integrator = PID_model_X.Integrator_CSTATE;
  if (rtmIsMajorTimeStep(PID_model_M)) {
    real_T rtb_Sum1;

    /* DiscretePulseGenerator: '<Root>/Pulse Generator' */
    rtb_Sum1 = (PID_model_DW.clockTickCounter < PID_model_P.PulseGenerator_Duty)
      && (PID_model_DW.clockTickCounter >= 0) ? PID_model_P.PulseGenerator_Amp :
      0.0;
    if (PID_model_DW.clockTickCounter >= PID_model_P.PulseGenerator_Period - 1.0)
    {
      PID_model_DW.clockTickCounter = 0;
    } else {
      PID_model_DW.clockTickCounter++;
    }

    /* End of DiscretePulseGenerator: '<Root>/Pulse Generator' */

    /* Sum: '<Root>/Sum1' incorporates:
     *  ZeroOrderHold: '<Root>/Zero-Order Hold'
     */
    rtb_Sum1 -= PID_model_B.Integrator;

    /* Gain: '<S30>/Integral Gain' */
    PID_model_B.IntegralGain = PID_model_P.PIDController_I * rtb_Sum1;

    /* Gain: '<S36>/Filter Coefficient' incorporates:
     *  DiscreteIntegrator: '<S28>/Filter'
     *  Gain: '<S27>/Derivative Gain'
     *  Sum: '<S28>/SumD'
     */
    PID_model_B.FilterCoefficient = (PID_model_P.PIDController_D * rtb_Sum1 -
      PID_model_DW.Filter_DSTATE) * PID_model_P.PIDController_N;

    /* Gain: '<S31>/Proportional Gain' incorporates:
     *  DiscreteIntegrator: '<S33>/Integrator'
     *  Sum: '<S42>/Sum'
     */
    PID_model_B.ProportionalGain = ((rtb_Sum1 + PID_model_DW.Integrator_DSTATE)
      + PID_model_B.FilterCoefficient) * PID_model_P.PIDController_P;
  }

  /* TransferFcn: '<Root>/Transfer Fcn' */
  PID_model_B.TransferFcn = 0.0;
  PID_model_B.TransferFcn += PID_model_P.TransferFcn_C *
    PID_model_X.TransferFcn_CSTATE;
  if (rtmIsMajorTimeStep(PID_model_M)) {
    /* S-Function (sldrtsync): '<Root>/Real-Time Synchronization' */
    /* S-Function Block: <Root>/Real-Time Synchronization */
    {
      PID_model_B.RealTimeSynchronization = 0;/* Missed Ticks value is always zero */
    }
  }
}

/* Model update function */
void PID_model_update(void)
{
  if (rtmIsMajorTimeStep(PID_model_M)) {
    /* Update for DiscreteIntegrator: '<S28>/Filter' */
    PID_model_DW.Filter_DSTATE += PID_model_P.Filter_gainval *
      PID_model_B.FilterCoefficient;

    /* Update for DiscreteIntegrator: '<S33>/Integrator' */
    PID_model_DW.Integrator_DSTATE += PID_model_P.Integrator_gainval *
      PID_model_B.IntegralGain;
  }

  if (rtmIsMajorTimeStep(PID_model_M)) {
    rt_ertODEUpdateContinuousStates(&PID_model_M->solverInfo);
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++PID_model_M->Timing.clockTick0)) {
    ++PID_model_M->Timing.clockTickH0;
  }

  PID_model_M->Timing.t[0] = rtsiGetSolverStopTime(&PID_model_M->solverInfo);

  {
    /* Update absolute timer for sample time: [0.01s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick1"
     * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick1 and the high bits
     * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++PID_model_M->Timing.clockTick1)) {
      ++PID_model_M->Timing.clockTickH1;
    }

    PID_model_M->Timing.t[1] = PID_model_M->Timing.clockTick1 *
      PID_model_M->Timing.stepSize1 + PID_model_M->Timing.clockTickH1 *
      PID_model_M->Timing.stepSize1 * 4294967296.0;
  }
}

/* Derivatives for root system: '<Root>' */
void PID_model_derivatives(void)
{
  XDot_PID_model_T *_rtXdot;
  _rtXdot = ((XDot_PID_model_T *) PID_model_M->derivs);

  /* Derivatives for Integrator: '<Root>/Integrator' */
  _rtXdot->Integrator_CSTATE = PID_model_B.TransferFcn;

  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn' */
  _rtXdot->TransferFcn_CSTATE = 0.0;
  _rtXdot->TransferFcn_CSTATE += PID_model_P.TransferFcn_A *
    PID_model_X.TransferFcn_CSTATE;
  _rtXdot->TransferFcn_CSTATE += PID_model_B.ProportionalGain;
}

/* Model initialize function */
void PID_model_initialize(void)
{
  /* Start for DiscretePulseGenerator: '<Root>/Pulse Generator' */
  PID_model_DW.clockTickCounter = 0;

  /* InitializeConditions for Integrator: '<Root>/Integrator' */
  PID_model_X.Integrator_CSTATE = PID_model_P.Integrator_IC;

  /* InitializeConditions for DiscreteIntegrator: '<S28>/Filter' */
  PID_model_DW.Filter_DSTATE =
    PID_model_P.PIDController_InitialConditionForFilter;

  /* InitializeConditions for DiscreteIntegrator: '<S33>/Integrator' */
  PID_model_DW.Integrator_DSTATE =
    PID_model_P.PIDController_InitialConditionForIntegrator;

  /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn' */
  PID_model_X.TransferFcn_CSTATE = 0.0;
}

/* Model terminate function */
void PID_model_terminate(void)
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
  PID_model_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  PID_model_update();
  UNUSED_PARAMETER(tid);
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
  PID_model_initialize();
}

void MdlTerminate(void)
{
  PID_model_terminate();
}

/* Registration function */
RT_MODEL_PID_model_T *PID_model(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* non-finite (run-time) assignments */
  PID_model_P.RealTimeSynchronization_MaxMissedTicks = rtInf;

  /* initialize real-time model */
  (void) memset((void *)PID_model_M, 0,
                sizeof(RT_MODEL_PID_model_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&PID_model_M->solverInfo,
                          &PID_model_M->Timing.simTimeStep);
    rtsiSetTPtr(&PID_model_M->solverInfo, &rtmGetTPtr(PID_model_M));
    rtsiSetStepSizePtr(&PID_model_M->solverInfo, &PID_model_M->Timing.stepSize0);
    rtsiSetdXPtr(&PID_model_M->solverInfo, &PID_model_M->derivs);
    rtsiSetContStatesPtr(&PID_model_M->solverInfo, (real_T **)
                         &PID_model_M->contStates);
    rtsiSetNumContStatesPtr(&PID_model_M->solverInfo,
      &PID_model_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&PID_model_M->solverInfo,
      &PID_model_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&PID_model_M->solverInfo,
      &PID_model_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&PID_model_M->solverInfo,
      &PID_model_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&PID_model_M->solverInfo, (&rtmGetErrorStatus
      (PID_model_M)));
    rtsiSetRTModelPtr(&PID_model_M->solverInfo, PID_model_M);
  }

  rtsiSetSimTimeStep(&PID_model_M->solverInfo, MAJOR_TIME_STEP);
  PID_model_M->intgData.y = PID_model_M->odeY;
  PID_model_M->intgData.f[0] = PID_model_M->odeF[0];
  PID_model_M->intgData.f[1] = PID_model_M->odeF[1];
  PID_model_M->intgData.f[2] = PID_model_M->odeF[2];
  PID_model_M->intgData.f[3] = PID_model_M->odeF[3];
  PID_model_M->intgData.f[4] = PID_model_M->odeF[4];
  PID_model_M->intgData.f[5] = PID_model_M->odeF[5];
  PID_model_M->contStates = ((real_T *) &PID_model_X);
  rtsiSetSolverData(&PID_model_M->solverInfo, (void *)&PID_model_M->intgData);
  rtsiSetSolverName(&PID_model_M->solverInfo,"ode5");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = PID_model_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "PID_model_M points to
       static memory which is guaranteed to be non-NULL" */
    PID_model_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    PID_model_M->Timing.sampleTimes = (&PID_model_M->Timing.sampleTimesArray[0]);
    PID_model_M->Timing.offsetTimes = (&PID_model_M->Timing.offsetTimesArray[0]);

    /* task periods */
    PID_model_M->Timing.sampleTimes[0] = (0.0);
    PID_model_M->Timing.sampleTimes[1] = (0.01);

    /* task offsets */
    PID_model_M->Timing.offsetTimes[0] = (0.0);
    PID_model_M->Timing.offsetTimes[1] = (0.0);
  }

  rtmSetTPtr(PID_model_M, &PID_model_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = PID_model_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    PID_model_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(PID_model_M, 10.0);
  PID_model_M->Timing.stepSize0 = 0.01;
  PID_model_M->Timing.stepSize1 = 0.01;

  /* External mode info */
  PID_model_M->Sizes.checksums[0] = (1815208774U);
  PID_model_M->Sizes.checksums[1] = (2633434060U);
  PID_model_M->Sizes.checksums[2] = (2068943265U);
  PID_model_M->Sizes.checksums[3] = (4101092940U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[1];
    PID_model_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(PID_model_M->extModeInfo,
      &PID_model_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(PID_model_M->extModeInfo, PID_model_M->Sizes.checksums);
    rteiSetTPtr(PID_model_M->extModeInfo, rtmGetTPtr(PID_model_M));
  }

  PID_model_M->solverInfoPtr = (&PID_model_M->solverInfo);
  PID_model_M->Timing.stepSize = (0.01);
  rtsiSetFixedStepSize(&PID_model_M->solverInfo, 0.01);
  rtsiSetSolverMode(&PID_model_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  PID_model_M->blockIO = ((void *) &PID_model_B);
  (void) memset(((void *) &PID_model_B), 0,
                sizeof(B_PID_model_T));

  /* parameters */
  PID_model_M->defaultParam = ((real_T *)&PID_model_P);

  /* states (continuous) */
  {
    real_T *x = (real_T *) &PID_model_X;
    PID_model_M->contStates = (x);
    (void) memset((void *)&PID_model_X, 0,
                  sizeof(X_PID_model_T));
  }

  /* states (dwork) */
  PID_model_M->dwork = ((void *) &PID_model_DW);
  (void) memset((void *)&PID_model_DW, 0,
                sizeof(DW_PID_model_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    PID_model_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 18;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  PID_model_M->Sizes.numContStates = (2);/* Number of continuous states */
  PID_model_M->Sizes.numPeriodicContStates = (0);
                                      /* Number of periodic continuous states */
  PID_model_M->Sizes.numY = (0);       /* Number of model outputs */
  PID_model_M->Sizes.numU = (0);       /* Number of model inputs */
  PID_model_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  PID_model_M->Sizes.numSampTimes = (2);/* Number of sample times */
  PID_model_M->Sizes.numBlocks = (16); /* Number of blocks */
  PID_model_M->Sizes.numBlockIO = (6); /* Number of block outputs */
  PID_model_M->Sizes.numBlockPrms = (17);/* Sum of parameter "widths" */
  return PID_model_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
