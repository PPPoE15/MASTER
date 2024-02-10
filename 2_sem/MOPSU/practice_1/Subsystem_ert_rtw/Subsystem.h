/*
 * File: Subsystem.h
 *
 * Code generated for Simulink model 'Subsystem'.
 *
 * Model version                  : 3.0
 * Simulink Coder version         : 9.6 (R2021b) 14-May-2021
 * C/C++ source code generated on : Fri Feb  9 13:26:23 2024
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_Subsystem_h_
#define RTW_HEADER_Subsystem_h_
#ifndef Subsystem_COMMON_INCLUDES_
#define Subsystem_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#endif                                 /* Subsystem_COMMON_INCLUDES_ */

#include "Subsystem_types.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

/* Block states (default storage) for system '<Root>' */
typedef struct {
  real_T Filter_DSTATE;                /* '<S29>/Filter' */
  real_T Integrator_DSTATE;            /* '<S34>/Integrator' */
} DW_Subsystem_T;

/* External inputs (root inport signals with default storage) */
typedef struct {
  real_T u;                            /* '<Root>/u' */
} ExtU_Subsystem_T;

/* External outputs (root outports fed by signals with default storage) */
typedef struct {
  real_T y;                            /* '<Root>/y' */
} ExtY_Subsystem_T;

/* Real-time Model Data Structure */
struct tag_RTM_Subsystem_T {
  const char_T * volatile errorStatus;
};

/* Block states (default storage) */
extern DW_Subsystem_T Subsystem_DW;

/* External inputs (root inport signals with default storage) */
extern ExtU_Subsystem_T Subsystem_U;

/* External outputs (root outports fed by signals with default storage) */
extern ExtY_Subsystem_T Subsystem_Y;

/* Model entry point functions */
extern void Subsystem_initialize(void);
extern void Subsystem_step(void);
extern void Subsystem_terminate(void);

/* Real-time Model object */
extern RT_MODEL_Subsystem_T *const Subsystem_M;

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Note that this particular code originates from a subsystem build,
 * and has its own system numbers different from the parent model.
 * Refer to the system hierarchy for this subsystem below, and use the
 * MATLAB hilite_system command to trace the generated code back
 * to the parent model.  For example,
 *
 * hilite_system('model2/Subsystem')    - opens subsystem model2/Subsystem
 * hilite_system('model2/Subsystem/Kp') - opens and selects block Kp
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'model2'
 * '<S1>'   : 'model2/Subsystem'
 * '<S2>'   : 'model2/Subsystem/PID Controller1'
 * '<S3>'   : 'model2/Subsystem/PID Controller1/Anti-windup'
 * '<S4>'   : 'model2/Subsystem/PID Controller1/D Gain'
 * '<S5>'   : 'model2/Subsystem/PID Controller1/Filter'
 * '<S6>'   : 'model2/Subsystem/PID Controller1/Filter ICs'
 * '<S7>'   : 'model2/Subsystem/PID Controller1/I Gain'
 * '<S8>'   : 'model2/Subsystem/PID Controller1/Ideal P Gain'
 * '<S9>'   : 'model2/Subsystem/PID Controller1/Ideal P Gain Fdbk'
 * '<S10>'  : 'model2/Subsystem/PID Controller1/Integrator'
 * '<S11>'  : 'model2/Subsystem/PID Controller1/Integrator ICs'
 * '<S12>'  : 'model2/Subsystem/PID Controller1/N Copy'
 * '<S13>'  : 'model2/Subsystem/PID Controller1/N Gain'
 * '<S14>'  : 'model2/Subsystem/PID Controller1/P Copy'
 * '<S15>'  : 'model2/Subsystem/PID Controller1/Parallel P Gain'
 * '<S16>'  : 'model2/Subsystem/PID Controller1/Reset Signal'
 * '<S17>'  : 'model2/Subsystem/PID Controller1/Saturation'
 * '<S18>'  : 'model2/Subsystem/PID Controller1/Saturation Fdbk'
 * '<S19>'  : 'model2/Subsystem/PID Controller1/Sum'
 * '<S20>'  : 'model2/Subsystem/PID Controller1/Sum Fdbk'
 * '<S21>'  : 'model2/Subsystem/PID Controller1/Tracking Mode'
 * '<S22>'  : 'model2/Subsystem/PID Controller1/Tracking Mode Sum'
 * '<S23>'  : 'model2/Subsystem/PID Controller1/Tsamp - Integral'
 * '<S24>'  : 'model2/Subsystem/PID Controller1/Tsamp - Ngain'
 * '<S25>'  : 'model2/Subsystem/PID Controller1/postSat Signal'
 * '<S26>'  : 'model2/Subsystem/PID Controller1/preSat Signal'
 * '<S27>'  : 'model2/Subsystem/PID Controller1/Anti-windup/Passthrough'
 * '<S28>'  : 'model2/Subsystem/PID Controller1/D Gain/Internal Parameters'
 * '<S29>'  : 'model2/Subsystem/PID Controller1/Filter/Disc. Forward Euler Filter'
 * '<S30>'  : 'model2/Subsystem/PID Controller1/Filter ICs/Internal IC - Filter'
 * '<S31>'  : 'model2/Subsystem/PID Controller1/I Gain/Internal Parameters'
 * '<S32>'  : 'model2/Subsystem/PID Controller1/Ideal P Gain/Passthrough'
 * '<S33>'  : 'model2/Subsystem/PID Controller1/Ideal P Gain Fdbk/Disabled'
 * '<S34>'  : 'model2/Subsystem/PID Controller1/Integrator/Discrete'
 * '<S35>'  : 'model2/Subsystem/PID Controller1/Integrator ICs/Internal IC'
 * '<S36>'  : 'model2/Subsystem/PID Controller1/N Copy/Disabled'
 * '<S37>'  : 'model2/Subsystem/PID Controller1/N Gain/Internal Parameters'
 * '<S38>'  : 'model2/Subsystem/PID Controller1/P Copy/Disabled'
 * '<S39>'  : 'model2/Subsystem/PID Controller1/Parallel P Gain/Internal Parameters'
 * '<S40>'  : 'model2/Subsystem/PID Controller1/Reset Signal/Disabled'
 * '<S41>'  : 'model2/Subsystem/PID Controller1/Saturation/Passthrough'
 * '<S42>'  : 'model2/Subsystem/PID Controller1/Saturation Fdbk/Disabled'
 * '<S43>'  : 'model2/Subsystem/PID Controller1/Sum/Sum_PID'
 * '<S44>'  : 'model2/Subsystem/PID Controller1/Sum Fdbk/Disabled'
 * '<S45>'  : 'model2/Subsystem/PID Controller1/Tracking Mode/Disabled'
 * '<S46>'  : 'model2/Subsystem/PID Controller1/Tracking Mode Sum/Passthrough'
 * '<S47>'  : 'model2/Subsystem/PID Controller1/Tsamp - Integral/Passthrough'
 * '<S48>'  : 'model2/Subsystem/PID Controller1/Tsamp - Ngain/Passthrough'
 * '<S49>'  : 'model2/Subsystem/PID Controller1/postSat Signal/Forward_Path'
 * '<S50>'  : 'model2/Subsystem/PID Controller1/preSat Signal/Forward_Path'
 */
#endif                                 /* RTW_HEADER_Subsystem_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
