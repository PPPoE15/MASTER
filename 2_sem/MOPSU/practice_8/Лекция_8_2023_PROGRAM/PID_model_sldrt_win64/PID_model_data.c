/*
 * PID_model_data.c
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

/* Block parameters (default storage) */
P_PID_model_T PID_model_P = {
  /* Mask Parameter: PIDController_D
   * Referenced by: '<S27>/Derivative Gain'
   */
  3.03896468351061,

  /* Mask Parameter: PIDController_I
   * Referenced by: '<S30>/Integral Gain'
   */
  0.0575762439559454,

  /* Mask Parameter: PIDController_InitialConditionForFilter
   * Referenced by: '<S28>/Filter'
   */
  0.0,

  /* Mask Parameter: PIDController_InitialConditionForIntegrator
   * Referenced by: '<S33>/Integrator'
   */
  0.0,

  /* Mask Parameter: RealTimeSynchronization_MaxMissedTicks
   * Referenced by: '<Root>/Real-Time Synchronization'
   */
  0.0,

  /* Mask Parameter: PIDController_N
   * Referenced by: '<S36>/Filter Coefficient'
   */
  47.5579676606345,

  /* Mask Parameter: PIDController_P
   * Referenced by: '<S31>/Proportional Gain'
   */
  0.276191569614038,

  /* Mask Parameter: RealTimeSynchronization_YieldWhenWaiting
   * Referenced by: '<Root>/Real-Time Synchronization'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/Integrator'
   */
  0.0,

  /* Expression: 1
   * Referenced by: '<Root>/Pulse Generator'
   */
  1.0,

  /* Computed Parameter: PulseGenerator_Period
   * Referenced by: '<Root>/Pulse Generator'
   */
  400.0,

  /* Computed Parameter: PulseGenerator_Duty
   * Referenced by: '<Root>/Pulse Generator'
   */
  200.0,

  /* Expression: 0
   * Referenced by: '<Root>/Pulse Generator'
   */
  0.0,

  /* Computed Parameter: Filter_gainval
   * Referenced by: '<S28>/Filter'
   */
  0.01,

  /* Computed Parameter: Integrator_gainval
   * Referenced by: '<S33>/Integrator'
   */
  0.01,

  /* Computed Parameter: TransferFcn_A
   * Referenced by: '<Root>/Transfer Fcn'
   */
  -0.1,

  /* Computed Parameter: TransferFcn_C
   * Referenced by: '<Root>/Transfer Fcn'
   */
  10.0
};
