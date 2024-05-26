/*
 * PID_model_1_data.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "PID_model_1".
 *
 * Model version              : 1.1
 * Simulink Coder version : 9.6 (R2021b) 14-May-2021
 * C source code generated on : Thu May  4 17:20:32 2023
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objective: Debugging
 * Validation result: Not run
 */

#include "PID_model_1.h"
#include "PID_model_1_private.h"

/* Block parameters (default storage) */
P_PID_model_1_T PID_model_1_P = {
  /* Mask Parameter: DiscretePIDController_D
   * Referenced by: '<S27>/Derivative Gain'
   */
  1.42,

  /* Mask Parameter: DiscretePIDController_I
   * Referenced by: '<S30>/Integral Gain'
   */
  0.0365,

  /* Mask Parameter: DiscretePIDController_InitialConditionForFilter
   * Referenced by: '<S28>/Filter'
   */
  0.0,

  /* Mask Parameter: DiscretePIDController_InitialConditionForIntegrator
   * Referenced by: '<S33>/Integrator'
   */
  0.0,

  /* Mask Parameter: RealTimeSynchronization_MaxMissedTicks
   * Referenced by: '<Root>/Real-Time Synchronization'
   */
  0.0,

  /* Mask Parameter: DiscretePIDController_N
   * Referenced by: '<S36>/Filter Coefficient'
   */
  24.44,

  /* Mask Parameter: DiscretePIDController_P
   * Referenced by: '<S38>/Proportional Gain'
   */
  0.483,

  /* Mask Parameter: RealTimeSynchronization_YieldWhenWaiting
   * Referenced by: '<Root>/Real-Time Synchronization'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/Integrator'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/Step'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/Step'
   */
  0.0,

  /* Expression: 1
   * Referenced by: '<Root>/Step'
   */
  1.0,

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
