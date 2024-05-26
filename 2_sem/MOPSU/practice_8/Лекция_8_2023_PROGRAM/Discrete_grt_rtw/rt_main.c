/*
 * Code generation for Simulink model "Discrete"
 *
 * File version               : 9.6 (R2021b) 14-May-2021
 * File generated on          : Thu May  4 12:25:09 2023
 * C source code generated on : Thu May  4 12:25:10 2023
 *
 * Compiler specified defines:
 *   RT
 *   MODEL           = Discrete
 *   NUMST           = 1 (Number of sample times)
 *   NCSTATES        = 0 (Number of continuous states)
 *   TID01EQ         = 0
 *                     (Set to 1 if sample time task id's 0 and 1 have equal rates)
 *
 * For more information:
 *   o Simulink Coder User's Guide
 */

#include <windows.h>
#include <process.h>
#include <processthreadsapi.h>
#include "rtmodel.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <float.h>
#include "Discrete.h"                  /* Model's header file */
#ifndef EXIT_FAILURE
#define EXIT_FAILURE                   1
#endif

#ifndef EXIT_SUCCESS
#define EXIT_SUCCESS                   0
#endif

#define RUN_FOREVER                    -1.0
#ifndef SAVEFILE
#define MATFILE2(file)                 #file ".mat"
#define MATFILE1(file)                 MATFILE2(file)
#define MATFILE                        MATFILE1(MODEL)
#else
#define QUOTE1(name)                   #name
#define QUOTE(name)                    QUOTE1(name)              /* need to expand name */
#define MATFILE                        QUOTE(SAVEFILE)
#endif

#define MdlInitializeSizes()                                     /* No op */
#define MdlInitializeSampleTimes()                               /* No op */
#define MdlStart()                                               /* No op */
#define MdlOutputs()                   Discrete_step()
#define MdlUpdate()                                              /* No Op */
#define MdlTerminate()                 Discrete_terminate()
#define rt_CreateIntegrationData(S)                              /* No op */
#define rt_UpdateContinuousStates(S)                             /* No op */

/*==================================*
 * Global data local to this module *
 *==================================*/
static struct {
  int_T stopExecutionFlag;
  int_T isrOverrun;
  int_T overrunFlags[NUMST];
  const char_T *errmsg;
} GBLbuf;

#define CHECK_STATUS(status,fcn)       if (status != 0) {fprintf(stderr, "Call to %s returned error status (%d).\n", (fcn),(status)); perror((fcn)); fflush(stderr); exit(EXIT_FAILURE);}

typedef struct {
  HANDLE threadHandle;
  unsigned threadID;
  int_T index;
  HANDLE startEvent;
  HANDLE stopEvent;
  LONG exitFlag;
} ThreadInfo;

ThreadInfo periodicThread[1];
ThreadInfo periodicTriggerThread[1];
int threadPriority[4] = { THREAD_PRIORITY_ABOVE_NORMAL,
  THREAD_PRIORITY_NORMAL,
  THREAD_PRIORITY_BELOW_NORMAL,
  THREAD_PRIORITY_LOWEST };

HANDLE quitEvent = NULL;
RT_MODEL_Discrete_T *S;
BOOL OnCtrlHandler(DWORD ctrl)
{
  /* Unused argument */
  (void)(ctrl);
  SetEvent(quitEvent);
  return true;
}

unsigned __stdcall baseRateTaskScheduler(void *arg)
{
  volatile boolean_T noErr;
  DWORD waitResult;
  HANDLE orTimer;
  LARGE_INTEGER orDueTime;
  int_T taskId[1] = { 0 };

  /* Unused argument */
  (void)(arg);
  noErr = (rtmGetErrorStatus(Discrete_M) == (NULL));
  orTimer = CreateWaitableTimer((NULL), false, (NULL));
  orDueTime.QuadPart = (LONGLONG)(0.01 * 1e7 * -1);
  while (noErr) {
    /* Check for Ctrl+C event */
    waitResult = WaitForSingleObject(quitEvent, 0);
    if ((waitResult == WAIT_OBJECT_0) || (waitResult == WAIT_FAILED)) {
      /* The quitEvent is set or the wait failed */
      noErr = false;
      continue;
    }

    CHECK_STATUS(SetWaitableTimer(orTimer, &orDueTime, 0, (NULL), (NULL), false)
                 == false, "SetWaitableTimer");
    waitResult = WaitForSingleObject(periodicThread[taskId[0]].stopEvent, 0);
    if (waitResult == WAIT_TIMEOUT) {
      printf("Overrun - rate for periodic task %d too fast.\n", taskId[0]);
      WaitForSingleObject(periodicThread[taskId[0]].stopEvent,INFINITE);
    }

    noErr = (rtmGetErrorStatus(Discrete_M) == (NULL));
    if (noErr) {
      SetEvent(periodicThread[taskId[0]].startEvent);
    }

    if (WaitForSingleObject(orTimer, 0) == WAIT_OBJECT_0) {
      printf("Overrun - periodic trigger 0 base rate too fast.\n");
    }
  }                                    /* while */

  InterlockedIncrement(&periodicThread[taskId[0]].exitFlag);
  SetEvent(periodicThread[taskId[0]].startEvent);
  _endthreadex(0);
  return 0;
}

unsigned __stdcall periodicTask(void *arg)
{
  DWORD waitResult;
  ThreadInfo* info = (ThreadInfo*)arg;
  volatile boolean_T noErr = true;
  while (noErr) {
    waitResult = WaitForSingleObject(info->startEvent,INFINITE);
    if ((waitResult != WAIT_OBJECT_0) || info->exitFlag) {
      /* Wait failed or exitFlag is set */
      noErr = false;
      continue;
    }

    MdlOutputs();
    MdlUpdate();
    SetEvent(info->stopEvent);
  }

  _endthreadex(0);
  return 0;
}

int main(int argc, char *argv[])
{
  int i;
  int priority[1];

  /* Unused arguments */
  (void)(argc);
  (void)(argv);
  priority[0] = threadPriority[0];
  CHECK_STATUS(SetConsoleCtrlHandler((PHANDLER_ROUTINE)OnCtrlHandler, true) ==
               false, "SetConsoleCtrlHandler");
  printf("**starting the model**\n");
  fflush(stdout);
  rtmSetErrorStatus(Discrete_M, 0);

  /* Set the priority of the main thread */
  CHECK_STATUS(SetThreadPriority(GetCurrentThread(),
    THREAD_PRIORITY_TIME_CRITICAL) == false, "SetThreadPriority");

  /* Create & initialize events used for thread synchronization */
  quitEvent = CreateEvent((NULL), true, false, (NULL));
  CHECK_STATUS(quitEvent == (NULL),"CreateEvent");

  /************************
   * Initialize the model *
   ************************/
  S = Discrete_M;
  Discrete_initialize();
  if (rtmGetErrorStatus(Discrete_M) != (NULL)) {
    puts("Error during model registration");
    exit(EXIT_FAILURE);
  }

  MdlInitializeSizes();
  MdlInitializeSampleTimes();
  MdlStart();

  /* Create periodic threads */
  for (i = 0; i < 1; i++) {
    periodicThread[i].index = (int_T) i;
    periodicThread[i].exitFlag = 0;

    /* Create the events that will be used by the thread */
    periodicThread[i].startEvent = CreateEvent((NULL), false, false, (NULL));
    CHECK_STATUS(periodicThread[i].startEvent == (NULL), "CreateEvent");
    periodicThread[i].stopEvent = CreateEvent((NULL), false, true, (NULL));
    CHECK_STATUS(periodicThread[i].stopEvent == (NULL), "CreateStopEventEvent");

    /* Create the thread in suspended mode */
    periodicThread[i].threadHandle = (HANDLE)_beginthreadex((NULL), 0,
      &periodicTask, &periodicThread[i], CREATE_SUSPENDED, &periodicThread[i].
      threadID);
    CHECK_STATUS(periodicThread[i].threadID == 0,"_beginthreadex");

    /* Set the thread priority */
    CHECK_STATUS(SetThreadPriority(periodicThread[i].threadHandle, priority[i]) ==
                 false, "SetThreadPriority");

    /* Start the thread */
    CHECK_STATUS(ResumeThread(periodicThread[i].threadHandle) == -1,
                 "ResumeThread");
  }

  /* Create periodic trigger threads */
  {
    periodicTriggerThread[0].index = 0;
    periodicTriggerThread[0].exitFlag = 0;
    periodicTriggerThread[0].startEvent = (NULL);
    periodicTriggerThread[0].stopEvent = (NULL);

    /* Create the thread in suspended mode */
    periodicTriggerThread[0].threadHandle = (HANDLE)_beginthreadex((NULL), 0,
      &baseRateTaskScheduler, (NULL), CREATE_SUSPENDED, &periodicTriggerThread[0]
      .threadID);
    CHECK_STATUS(periodicTriggerThread[0].threadHandle == 0,"_beginthreadex");

    /* Set the periodic trigger thread priority */
    CHECK_STATUS(SetThreadPriority(periodicTriggerThread[0].threadHandle,
      THREAD_PRIORITY_HIGHEST) == false, "SetThreadPriority");

    /* Start the periodic trigger thread */
    CHECK_STATUS(ResumeThread(periodicTriggerThread[0].threadHandle) == -1,
                 "ResumeThread");
  }

  /* Wait for a stopping condition. */
  for (i = 0; i < 1; i++) {
    WaitForSingleObject(periodicTriggerThread[i].threadHandle, INFINITE);
  }

  /* Clean up */
  for (i = 0; i< 1; i++) {
    if (periodicTriggerThread[i].threadHandle != (NULL)) {
      CloseHandle(periodicTriggerThread[i].threadHandle);
    }
  }

  if (quitEvent != (NULL)) {
    CloseHandle(quitEvent);
  }

  for (i = 0; i < 1; i++) {
    if (periodicThread[i].startEvent != (NULL)) {
      CloseHandle(periodicThread[i].startEvent);
    }

    if (periodicThread[i].stopEvent != (NULL)) {
      CloseHandle(periodicThread[i].stopEvent);
    }

    if (periodicThread[i].threadHandle != (NULL)) {
      CloseHandle(periodicThread[i].threadHandle);
    }
  }

  printf("**stopping the model**\n");
  fflush(stdout);
  if (rtmGetErrorStatus(Discrete_M) != (NULL)) {
    fprintf(stderr, "\n**%s**\n", rtmGetErrorStatus(Discrete_M));
  }

  MdlTerminate();
  return 0;
}
