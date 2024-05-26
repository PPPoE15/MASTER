/*
 * Discrete.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "Discrete".
 *
 * Model version              : 1.1
 * Simulink Coder version : 9.6 (R2021b) 14-May-2021
 * C source code generated on : Thu May  4 12:25:10 2023
 *
 * Target selection: grt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_Discrete_h_
#define RTW_HEADER_Discrete_h_
#include <float.h>
#include <string.h>
#include <stddef.h>
#ifndef Discrete_COMMON_INCLUDES_
#define Discrete_COMMON_INCLUDES_
#include "rtwtypes.h"
#include "rtw_continuous.h"
#include "rtw_solver.h"
#include "rt_logging.h"
#endif                                 /* Discrete_COMMON_INCLUDES_ */

#include "Discrete_types.h"

/* Shared type includes */
#include "multiword_types.h"
#include "rt_nonfinite.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetFinalTime
#define rtmGetFinalTime(rtm)           ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetRTWLogInfo
#define rtmGetRTWLogInfo(rtm)          ((rtm)->rtwLogInfo)
#endif

#ifndef rtmGetErrorStatus
#define rtmGetErrorStatus(rtm)         ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
#define rtmSetErrorStatus(rtm, val)    ((rtm)->errorStatus = (val))
#endif

#ifndef rtmGetStopRequested
#define rtmGetStopRequested(rtm)       ((rtm)->Timing.stopRequestedFlag)
#endif

#ifndef rtmSetStopRequested
#define rtmSetStopRequested(rtm, val)  ((rtm)->Timing.stopRequestedFlag = (val))
#endif

#ifndef rtmGetStopRequestedPtr
#define rtmGetStopRequestedPtr(rtm)    (&((rtm)->Timing.stopRequestedFlag))
#endif

#ifndef rtmGetT
#define rtmGetT(rtm)                   ((rtm)->Timing.taskTime0)
#endif

#ifndef rtmGetTFinal
#define rtmGetTFinal(rtm)              ((rtm)->Timing.tFinal)
#endif

#ifndef rtmGetTPtr
#define rtmGetTPtr(rtm)                (&(rtm)->Timing.taskTime0)
#endif

/* Block states (default storage) for system '<Root>' */
typedef struct {
  real_T Integrator_DSTATE;            /* '<S33>/Integrator' */
  real_T Filter_DSTATE;                /* '<S28>/Filter' */
} DW_Discrete_T;

/* External inputs (root inport signals with default storage) */
typedef struct {
  real_T u;                            /* '<Root>/u' */
} ExtU_Discrete_T;

/* External outputs (root outports fed by signals with default storage) */
typedef struct {
  real_T y;                            /* '<Root>/y' */
} ExtY_Discrete_T;

/* Real-time Model Data Structure */
struct tag_RTM_Discrete_T {
  const char_T *errorStatus;
  RTWLogInfo *rtwLogInfo;

  /*
   * Timing:
   * The following substructure contains information regarding
   * the timing information for the model.
   */
  struct {
    time_T taskTime0;
    uint32_T clockTick0;
    uint32_T clockTickH0;
    time_T stepSize0;
    time_T tFinal;
    boolean_T stopRequestedFlag;
  } Timing;
};

/* Block states (default storage) */
extern DW_Discrete_T Discrete_DW;

/* External inputs (root inport signals with default storage) */
extern ExtU_Discrete_T Discrete_U;

/* External outputs (root outports fed by signals with default storage) */
extern ExtY_Discrete_T Discrete_Y;

/* Model entry point functions */
extern void Discrete_initialize(void);
extern void Discrete_step(void);
extern void Discrete_terminate(void);

/* Real-time Model object */
extern RT_MODEL_Discrete_T *const Discrete_M;

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
 * hilite_system('PID_model_1/Discrete PID Controller')    - opens subsystem PID_model_1/Discrete PID Controller
 * hilite_system('PID_model_1/Discrete PID Controller/Kp') - opens and selects block Kp
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'PID_model_1'
 * '<S1>'   : 'PID_model_1/Discrete PID Controller'
 * '<S2>'   : 'PID_model_1/Discrete PID Controller/Anti-windup'
 * '<S3>'   : 'PID_model_1/Discrete PID Controller/D Gain'
 * '<S4>'   : 'PID_model_1/Discrete PID Controller/Filter'
 * '<S5>'   : 'PID_model_1/Discrete PID Controller/Filter ICs'
 * '<S6>'   : 'PID_model_1/Discrete PID Controller/I Gain'
 * '<S7>'   : 'PID_model_1/Discrete PID Controller/Ideal P Gain'
 * '<S8>'   : 'PID_model_1/Discrete PID Controller/Ideal P Gain Fdbk'
 * '<S9>'   : 'PID_model_1/Discrete PID Controller/Integrator'
 * '<S10>'  : 'PID_model_1/Discrete PID Controller/Integrator ICs'
 * '<S11>'  : 'PID_model_1/Discrete PID Controller/N Copy'
 * '<S12>'  : 'PID_model_1/Discrete PID Controller/N Gain'
 * '<S13>'  : 'PID_model_1/Discrete PID Controller/P Copy'
 * '<S14>'  : 'PID_model_1/Discrete PID Controller/Parallel P Gain'
 * '<S15>'  : 'PID_model_1/Discrete PID Controller/Reset Signal'
 * '<S16>'  : 'PID_model_1/Discrete PID Controller/Saturation'
 * '<S17>'  : 'PID_model_1/Discrete PID Controller/Saturation Fdbk'
 * '<S18>'  : 'PID_model_1/Discrete PID Controller/Sum'
 * '<S19>'  : 'PID_model_1/Discrete PID Controller/Sum Fdbk'
 * '<S20>'  : 'PID_model_1/Discrete PID Controller/Tracking Mode'
 * '<S21>'  : 'PID_model_1/Discrete PID Controller/Tracking Mode Sum'
 * '<S22>'  : 'PID_model_1/Discrete PID Controller/Tsamp - Integral'
 * '<S23>'  : 'PID_model_1/Discrete PID Controller/Tsamp - Ngain'
 * '<S24>'  : 'PID_model_1/Discrete PID Controller/postSat Signal'
 * '<S25>'  : 'PID_model_1/Discrete PID Controller/preSat Signal'
 * '<S26>'  : 'PID_model_1/Discrete PID Controller/Anti-windup/Passthrough'
 * '<S27>'  : 'PID_model_1/Discrete PID Controller/D Gain/Internal Parameters'
 * '<S28>'  : 'PID_model_1/Discrete PID Controller/Filter/Disc. Forward Euler Filter'
 * '<S29>'  : 'PID_model_1/Discrete PID Controller/Filter ICs/Internal IC - Filter'
 * '<S30>'  : 'PID_model_1/Discrete PID Controller/I Gain/Internal Parameters'
 * '<S31>'  : 'PID_model_1/Discrete PID Controller/Ideal P Gain/Passthrough'
 * '<S32>'  : 'PID_model_1/Discrete PID Controller/Ideal P Gain Fdbk/Disabled'
 * '<S33>'  : 'PID_model_1/Discrete PID Controller/Integrator/Discrete'
 * '<S34>'  : 'PID_model_1/Discrete PID Controller/Integrator ICs/Internal IC'
 * '<S35>'  : 'PID_model_1/Discrete PID Controller/N Copy/Disabled'
 * '<S36>'  : 'PID_model_1/Discrete PID Controller/N Gain/Internal Parameters'
 * '<S37>'  : 'PID_model_1/Discrete PID Controller/P Copy/Disabled'
 * '<S38>'  : 'PID_model_1/Discrete PID Controller/Parallel P Gain/Internal Parameters'
 * '<S39>'  : 'PID_model_1/Discrete PID Controller/Reset Signal/Disabled'
 * '<S40>'  : 'PID_model_1/Discrete PID Controller/Saturation/Passthrough'
 * '<S41>'  : 'PID_model_1/Discrete PID Controller/Saturation Fdbk/Disabled'
 * '<S42>'  : 'PID_model_1/Discrete PID Controller/Sum/Sum_PID'
 * '<S43>'  : 'PID_model_1/Discrete PID Controller/Sum Fdbk/Disabled'
 * '<S44>'  : 'PID_model_1/Discrete PID Controller/Tracking Mode/Disabled'
 * '<S45>'  : 'PID_model_1/Discrete PID Controller/Tracking Mode Sum/Passthrough'
 * '<S46>'  : 'PID_model_1/Discrete PID Controller/Tsamp - Integral/Passthrough'
 * '<S47>'  : 'PID_model_1/Discrete PID Controller/Tsamp - Ngain/Passthrough'
 * '<S48>'  : 'PID_model_1/Discrete PID Controller/postSat Signal/Forward_Path'
 * '<S49>'  : 'PID_model_1/Discrete PID Controller/preSat Signal/Forward_Path'
 */
#endif                                 /* RTW_HEADER_Discrete_h_ */
