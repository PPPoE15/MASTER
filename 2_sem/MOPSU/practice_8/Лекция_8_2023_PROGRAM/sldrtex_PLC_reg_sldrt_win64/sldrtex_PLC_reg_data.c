/*
 * sldrtex_PLC_reg_data.c
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

/* Block parameters (default storage) */
P_sldrtex_PLC_reg_T sldrtex_PLC_reg_P = {
  /* Mask Parameter: DiscretePIDController_D
   * Referenced by: '<S27>/Derivative Gain'
   */
  0.09,

  /* Mask Parameter: DiscretePIDController_DifferentiatorICPrevScaledInput
   * Referenced by: '<S28>/UD'
   */
  0.0,

  /* Mask Parameter: DiscretePIDController_I
   * Referenced by: '<S32>/Integral Gain'
   */
  3.275,

  /* Mask Parameter: DiscretePIDController_InitialConditionForIntegrator
   * Referenced by: '<S35>/Integrator'
   */
  0.0,

  /* Mask Parameter: RealTimeSynchronization_MaxMissedTicks
   * Referenced by: '<Root>/Real-Time Synchronization'
   */
  0.0,

  /* Mask Parameter: DiscretePIDController_P
   * Referenced by: '<S40>/Proportional Gain'
   */
  1.158,

  /* Mask Parameter: RealTimeSynchronization_YieldWhenWaiting
   * Referenced by: '<Root>/Real-Time Synchronization'
   */
  0.0,

  /* Computed Parameter: TransferFcn_A
   * Referenced by: '<Root>/Transfer Fcn'
   */
  { -8.3333333333333321, -23.148148148148145 },

  /* Computed Parameter: TransferFcn_C
   * Referenced by: '<Root>/Transfer Fcn'
   */
  { 0.0, 46.296296296296291 },

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

  /* Computed Parameter: Tsamp_WtEt
   * Referenced by: '<S30>/Tsamp'
   */
  100.0,

  /* Computed Parameter: Integrator_gainval
   * Referenced by: '<S35>/Integrator'
   */
  0.01
};
