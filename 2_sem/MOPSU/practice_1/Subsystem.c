/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * File: Subsystem.c
 *
 * Code generated for Simulink model 'Subsystem'.
 *
 * Model version                  : 2.0
 * Simulink Coder version         : 9.5 (R2021b) 14-Nov-2022
 * C/C++ source code generated on : Sat Feb  5 17:11:24 2022
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "Subsystem.h"
#include "Subsystem_private.h"

/* Block states (default storage) */
DW_Subsystem_T Subsystem_DW;

/* External inputs (root inport signals with default storage) */
ExtU_Subsystem_T Subsystem_U;

/* External outputs (root outports fed by signals with default storage) */
ExtY_Subsystem_T Subsystem_Y;

/* Real-time model */
static RT_MODEL_Subsystem_T Subsystem_M_;
RT_MODEL_Subsystem_T *const Subsystem_M = &Subsystem_M_;

/* Model step function */
void Subsystem_step(void)
{
  real_T rtb_FilterCoefficient;

  /* Outputs for Atomic SubSystem: '<Root>/Subsystem' */
  /* Gain: '<S37>/Filter Coefficient' incorporates:
   *  DiscreteIntegrator: '<S29>/Filter'
   *  Gain: '<S28>/Derivative Gain'
   *  Inport: '<Root>/u'
   *  Sum: '<S29>/SumD'
   */
  rtb_FilterCoefficient = (6.0 * Subsystem_U.u - Subsystem_DW.Filter_DSTATE) *
    28.0;

  /* Outport: '<Root>/y' incorporates:
   *  DiscreteIntegrator: '<S34>/Integrator'
   *  Gain: '<S39>/Proportional Gain'
   *  Inport: '<Root>/u'
   *  Sum: '<S43>/Sum'
   */
  Subsystem_Y.y = (12.0 * Subsystem_U.u + Subsystem_DW.Integrator_DSTATE) +
    rtb_FilterCoefficient;

  /* Update for DiscreteIntegrator: '<S29>/Filter' */
  Subsystem_DW.Filter_DSTATE += 0.07 * rtb_FilterCoefficient;

  /* Update for DiscreteIntegrator: '<S34>/Integrator' incorporates:
   *  Gain: '<S31>/Integral Gain'
   *  Inport: '<Root>/u'
   */
  Subsystem_DW.Integrator_DSTATE += 5.0 * Subsystem_U.u * 0.07;

  /* End of Outputs for SubSystem: '<Root>/Subsystem' */
}

/* Model initialize function */
void Subsystem_initialize(void)
{
  /* (no initialization code required) */
}

/* Model terminate function */
void Subsystem_terminate(void)
{
  /* (no terminate code required) */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
