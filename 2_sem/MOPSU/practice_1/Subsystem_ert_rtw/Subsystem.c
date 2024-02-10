/*
 * File: Subsystem.c
 *
 * Code generated for Simulink model 'Subsystem'.
 *
 * Model version                  : 3.1
 * Simulink Coder version         : 9.6 (R2021b) 14-May-2021
 * C/C++ source code generated on : Sat Feb 10 18:01:13 2024
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
  rtb_FilterCoefficient = (4.5 * Subsystem_U.u - Subsystem_DW.Filter_DSTATE) *
    40.0;

  /* Outport: '<Root>/y' incorporates:
   *  DiscreteIntegrator: '<S34>/Integrator'
   *  Gain: '<S39>/Proportional Gain'
   *  Inport: '<Root>/u'
   *  Sum: '<S43>/Sum'
   */
  Subsystem_Y.y = (10.5 * Subsystem_U.u + Subsystem_DW.Integrator_DSTATE) +
    rtb_FilterCoefficient;

  /* Update for DiscreteIntegrator: '<S29>/Filter' */
  Subsystem_DW.Filter_DSTATE += 0.01 * rtb_FilterCoefficient;

  /* Update for DiscreteIntegrator: '<S34>/Integrator' incorporates:
   *  Gain: '<S31>/Integral Gain'
   *  Inport: '<Root>/u'
   */
  Subsystem_DW.Integrator_DSTATE += 11.0 * Subsystem_U.u * 0.01;

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
