/*
 * PID_diskr.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "PID_diskr".
 *
 * Model version              : 3.0
 * Simulink Coder version : 9.6 (R2021b) 14-May-2021
 * C source code generated on : Thu May  4 17:53:04 2023
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "PID_diskr.h"
#include "PID_diskr_private.h"
#include "PID_diskr_dt.h"

/* list of Simulink Desktop Real-Time timers */
const int SLDRTTimerCount = 1;
const double SLDRTTimers[2] = {
  0.01, 0.0,
};

/* Block signals (default storage) */
B_PID_diskr_T PID_diskr_B;

/* Continuous states */
X_PID_diskr_T PID_diskr_X;

/* Block states (default storage) */
DW_PID_diskr_T PID_diskr_DW;

/* Real-time model */
static RT_MODEL_PID_diskr_T PID_diskr_M_;
RT_MODEL_PID_diskr_T *const PID_diskr_M = &PID_diskr_M_;

/*
 * This function updates continuous states using the ODE3 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  /* Solver Matrices */
  static const real_T rt_ODE3_A[3] = {
    1.0/2.0, 3.0/4.0, 1.0
  };

  static const real_T rt_ODE3_B[3][3] = {
    { 1.0/2.0, 0.0, 0.0 },

    { 0.0, 3.0/4.0, 0.0 },

    { 2.0/9.0, 1.0/3.0, 4.0/9.0 }
  };

  time_T t = rtsiGetT(si);
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE3_IntgData *id = (ODE3_IntgData *)rtsiGetSolverData(si);
  real_T *y = id->y;
  real_T *f0 = id->f[0];
  real_T *f1 = id->f[1];
  real_T *f2 = id->f[2];
  real_T hB[3];
  int_T i;
  int_T nXc = 2;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  PID_diskr_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE3_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[0]);
  rtsiSetdX(si, f1);
  PID_diskr_output();
  PID_diskr_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE3_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[1]);
  rtsiSetdX(si, f2);
  PID_diskr_output();
  PID_diskr_derivatives();

  /* tnew = t + hA(3);
     ynew = y + f*hB(:,3); */
  for (i = 0; i <= 2; i++) {
    hB[i] = h * rt_ODE3_B[2][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2]);
  }

  rtsiSetT(si, tnew);
  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

/* Model output function */
void PID_diskr_output(void)
{
  if (rtmIsMajorTimeStep(PID_diskr_M)) {
    /* set solver stop time */
    if (!(PID_diskr_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&PID_diskr_M->solverInfo,
                            ((PID_diskr_M->Timing.clockTickH0 + 1) *
        PID_diskr_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&PID_diskr_M->solverInfo,
                            ((PID_diskr_M->Timing.clockTick0 + 1) *
        PID_diskr_M->Timing.stepSize0 + PID_diskr_M->Timing.clockTickH0 *
        PID_diskr_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(PID_diskr_M)) {
    PID_diskr_M->Timing.t[0] = rtsiGetT(&PID_diskr_M->solverInfo);
  }

  /* Integrator: '<Root>/Integrator' */
  PID_diskr_B.Integrator = PID_diskr_X.Integrator_CSTATE;
  if (rtmIsMajorTimeStep(PID_diskr_M)) {
    real_T rtb_Sum1;

    /* DiscretePulseGenerator: '<Root>/Pulse Generator' */
    rtb_Sum1 = (PID_diskr_DW.clockTickCounter < PID_diskr_P.PulseGenerator_Duty)
      && (PID_diskr_DW.clockTickCounter >= 0) ? PID_diskr_P.PulseGenerator_Amp :
      0.0;
    if (PID_diskr_DW.clockTickCounter >= PID_diskr_P.PulseGenerator_Period - 1.0)
    {
      PID_diskr_DW.clockTickCounter = 0;
    } else {
      PID_diskr_DW.clockTickCounter++;
    }

    /* End of DiscretePulseGenerator: '<Root>/Pulse Generator' */

    /* Sum: '<Root>/Sum1' incorporates:
     *  ZeroOrderHold: '<Root>/Zero-Order Hold'
     */
    rtb_Sum1 -= PID_diskr_B.Integrator;

    /* Gain: '<S30>/Integral Gain' */
    PID_diskr_B.IntegralGain = PID_diskr_P.PIDController_I * rtb_Sum1;

    /* Gain: '<S36>/Filter Coefficient' incorporates:
     *  DiscreteIntegrator: '<S28>/Filter'
     *  Gain: '<S27>/Derivative Gain'
     *  Sum: '<S28>/SumD'
     */
    PID_diskr_B.FilterCoefficient = (PID_diskr_P.PIDController_D * rtb_Sum1 -
      PID_diskr_DW.Filter_DSTATE) * PID_diskr_P.PIDController_N;

    /* Gain: '<S31>/Proportional Gain' incorporates:
     *  DiscreteIntegrator: '<S33>/Integrator'
     *  Sum: '<S42>/Sum'
     */
    PID_diskr_B.ProportionalGain = ((rtb_Sum1 + PID_diskr_DW.Integrator_DSTATE)
      + PID_diskr_B.FilterCoefficient) * PID_diskr_P.PIDController_P;
  }

  /* TransferFcn: '<Root>/Transfer Fcn' */
  PID_diskr_B.TransferFcn = 0.0;
  PID_diskr_B.TransferFcn += PID_diskr_P.TransferFcn_C *
    PID_diskr_X.TransferFcn_CSTATE;
  if (rtmIsMajorTimeStep(PID_diskr_M)) {
    /* S-Function (sldrtsync): '<Root>/Real-Time Synchronization' */
    /* S-Function Block: <Root>/Real-Time Synchronization */
    {
      PID_diskr_B.RealTimeSynchronization = 0;/* Missed Ticks value is always zero */
    }
  }
}

/* Model update function */
void PID_diskr_update(void)
{
  if (rtmIsMajorTimeStep(PID_diskr_M)) {
    /* Update for DiscreteIntegrator: '<S28>/Filter' */
    PID_diskr_DW.Filter_DSTATE += PID_diskr_P.Filter_gainval *
      PID_diskr_B.FilterCoefficient;

    /* Update for DiscreteIntegrator: '<S33>/Integrator' */
    PID_diskr_DW.Integrator_DSTATE += PID_diskr_P.Integrator_gainval *
      PID_diskr_B.IntegralGain;
  }

  if (rtmIsMajorTimeStep(PID_diskr_M)) {
    rt_ertODEUpdateContinuousStates(&PID_diskr_M->solverInfo);
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
  if (!(++PID_diskr_M->Timing.clockTick0)) {
    ++PID_diskr_M->Timing.clockTickH0;
  }

  PID_diskr_M->Timing.t[0] = rtsiGetSolverStopTime(&PID_diskr_M->solverInfo);

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
    if (!(++PID_diskr_M->Timing.clockTick1)) {
      ++PID_diskr_M->Timing.clockTickH1;
    }

    PID_diskr_M->Timing.t[1] = PID_diskr_M->Timing.clockTick1 *
      PID_diskr_M->Timing.stepSize1 + PID_diskr_M->Timing.clockTickH1 *
      PID_diskr_M->Timing.stepSize1 * 4294967296.0;
  }
}

/* Derivatives for root system: '<Root>' */
void PID_diskr_derivatives(void)
{
  XDot_PID_diskr_T *_rtXdot;
  _rtXdot = ((XDot_PID_diskr_T *) PID_diskr_M->derivs);

  /* Derivatives for Integrator: '<Root>/Integrator' */
  _rtXdot->Integrator_CSTATE = PID_diskr_B.TransferFcn;

  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn' */
  _rtXdot->TransferFcn_CSTATE = 0.0;
  _rtXdot->TransferFcn_CSTATE += PID_diskr_P.TransferFcn_A *
    PID_diskr_X.TransferFcn_CSTATE;
  _rtXdot->TransferFcn_CSTATE += PID_diskr_B.ProportionalGain;
}

/* Model initialize function */
void PID_diskr_initialize(void)
{
  /* Start for DiscretePulseGenerator: '<Root>/Pulse Generator' */
  PID_diskr_DW.clockTickCounter = 0;

  /* InitializeConditions for Integrator: '<Root>/Integrator' */
  PID_diskr_X.Integrator_CSTATE = PID_diskr_P.Integrator_IC;

  /* InitializeConditions for DiscreteIntegrator: '<S28>/Filter' */
  PID_diskr_DW.Filter_DSTATE =
    PID_diskr_P.PIDController_InitialConditionForFilter;

  /* InitializeConditions for DiscreteIntegrator: '<S33>/Integrator' */
  PID_diskr_DW.Integrator_DSTATE =
    PID_diskr_P.PIDController_InitialConditionForIntegrator;

  /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn' */
  PID_diskr_X.TransferFcn_CSTATE = 0.0;
}

/* Model terminate function */
void PID_diskr_terminate(void)
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
  PID_diskr_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  PID_diskr_update();
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
  PID_diskr_initialize();
}

void MdlTerminate(void)
{
  PID_diskr_terminate();
}

/* Registration function */
RT_MODEL_PID_diskr_T *PID_diskr(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* non-finite (run-time) assignments */
  PID_diskr_P.RealTimeSynchronization_MaxMissedTicks = rtInf;

  /* initialize real-time model */
  (void) memset((void *)PID_diskr_M, 0,
                sizeof(RT_MODEL_PID_diskr_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&PID_diskr_M->solverInfo,
                          &PID_diskr_M->Timing.simTimeStep);
    rtsiSetTPtr(&PID_diskr_M->solverInfo, &rtmGetTPtr(PID_diskr_M));
    rtsiSetStepSizePtr(&PID_diskr_M->solverInfo, &PID_diskr_M->Timing.stepSize0);
    rtsiSetdXPtr(&PID_diskr_M->solverInfo, &PID_diskr_M->derivs);
    rtsiSetContStatesPtr(&PID_diskr_M->solverInfo, (real_T **)
                         &PID_diskr_M->contStates);
    rtsiSetNumContStatesPtr(&PID_diskr_M->solverInfo,
      &PID_diskr_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&PID_diskr_M->solverInfo,
      &PID_diskr_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&PID_diskr_M->solverInfo,
      &PID_diskr_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&PID_diskr_M->solverInfo,
      &PID_diskr_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&PID_diskr_M->solverInfo, (&rtmGetErrorStatus
      (PID_diskr_M)));
    rtsiSetRTModelPtr(&PID_diskr_M->solverInfo, PID_diskr_M);
  }

  rtsiSetSimTimeStep(&PID_diskr_M->solverInfo, MAJOR_TIME_STEP);
  PID_diskr_M->intgData.y = PID_diskr_M->odeY;
  PID_diskr_M->intgData.f[0] = PID_diskr_M->odeF[0];
  PID_diskr_M->intgData.f[1] = PID_diskr_M->odeF[1];
  PID_diskr_M->intgData.f[2] = PID_diskr_M->odeF[2];
  PID_diskr_M->contStates = ((real_T *) &PID_diskr_X);
  rtsiSetSolverData(&PID_diskr_M->solverInfo, (void *)&PID_diskr_M->intgData);
  rtsiSetSolverName(&PID_diskr_M->solverInfo,"ode3");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = PID_diskr_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "PID_diskr_M points to
       static memory which is guaranteed to be non-NULL" */
    PID_diskr_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    PID_diskr_M->Timing.sampleTimes = (&PID_diskr_M->Timing.sampleTimesArray[0]);
    PID_diskr_M->Timing.offsetTimes = (&PID_diskr_M->Timing.offsetTimesArray[0]);

    /* task periods */
    PID_diskr_M->Timing.sampleTimes[0] = (0.0);
    PID_diskr_M->Timing.sampleTimes[1] = (0.01);

    /* task offsets */
    PID_diskr_M->Timing.offsetTimes[0] = (0.0);
    PID_diskr_M->Timing.offsetTimes[1] = (0.0);
  }

  rtmSetTPtr(PID_diskr_M, &PID_diskr_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = PID_diskr_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    PID_diskr_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(PID_diskr_M, 10.0);
  PID_diskr_M->Timing.stepSize0 = 0.01;
  PID_diskr_M->Timing.stepSize1 = 0.01;

  /* External mode info */
  PID_diskr_M->Sizes.checksums[0] = (1232311470U);
  PID_diskr_M->Sizes.checksums[1] = (1245652594U);
  PID_diskr_M->Sizes.checksums[2] = (2859070497U);
  PID_diskr_M->Sizes.checksums[3] = (3537671527U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[1];
    PID_diskr_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(PID_diskr_M->extModeInfo,
      &PID_diskr_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(PID_diskr_M->extModeInfo, PID_diskr_M->Sizes.checksums);
    rteiSetTPtr(PID_diskr_M->extModeInfo, rtmGetTPtr(PID_diskr_M));
  }

  PID_diskr_M->solverInfoPtr = (&PID_diskr_M->solverInfo);
  PID_diskr_M->Timing.stepSize = (0.01);
  rtsiSetFixedStepSize(&PID_diskr_M->solverInfo, 0.01);
  rtsiSetSolverMode(&PID_diskr_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  PID_diskr_M->blockIO = ((void *) &PID_diskr_B);
  (void) memset(((void *) &PID_diskr_B), 0,
                sizeof(B_PID_diskr_T));

  /* parameters */
  PID_diskr_M->defaultParam = ((real_T *)&PID_diskr_P);

  /* states (continuous) */
  {
    real_T *x = (real_T *) &PID_diskr_X;
    PID_diskr_M->contStates = (x);
    (void) memset((void *)&PID_diskr_X, 0,
                  sizeof(X_PID_diskr_T));
  }

  /* states (dwork) */
  PID_diskr_M->dwork = ((void *) &PID_diskr_DW);
  (void) memset((void *)&PID_diskr_DW, 0,
                sizeof(DW_PID_diskr_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    PID_diskr_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 18;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  PID_diskr_M->Sizes.numContStates = (2);/* Number of continuous states */
  PID_diskr_M->Sizes.numPeriodicContStates = (0);
                                      /* Number of periodic continuous states */
  PID_diskr_M->Sizes.numY = (0);       /* Number of model outputs */
  PID_diskr_M->Sizes.numU = (0);       /* Number of model inputs */
  PID_diskr_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  PID_diskr_M->Sizes.numSampTimes = (2);/* Number of sample times */
  PID_diskr_M->Sizes.numBlocks = (16); /* Number of blocks */
  PID_diskr_M->Sizes.numBlockIO = (6); /* Number of block outputs */
  PID_diskr_M->Sizes.numBlockPrms = (17);/* Sum of parameter "widths" */
  return PID_diskr_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
