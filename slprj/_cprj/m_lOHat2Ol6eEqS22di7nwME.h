#ifndef __lOHat2Ol6eEqS22di7nwME_h__
#define __lOHat2Ol6eEqS22di7nwME_h__

/* Include files */
#include "simstruc.h"
#include "rtwtypes.h"
#include "multiword_types.h"
#include "slexec_vm_zc_functions.h"
#include "slexec_vm_simstruct_bridge.h"
#include "sl_sfcn_cov/sl_sfcn_cov_bridge.h"

/* Type Definitions */
#ifndef typedef_InstanceStruct_lOHat2Ol6eEqS22di7nwME
#define typedef_InstanceStruct_lOHat2Ol6eEqS22di7nwME

typedef struct {
  SimStruct *S;
  PyObject *namespaceDict;
  PyGILState_STATE GIL;
  void *emlrtRootTLSGlobal;
  real_T *u0;
  real_T *u1;
  real_T *u2;
  real_T *u3;
  real_T *u4;
  real_T *b_y0;
  real_T *b_y1;
  real_T *y2;
  real_T *y3;
  real_T *y4;
  real_T *y5;
  void **myController;
} InstanceStruct_lOHat2Ol6eEqS22di7nwME;

#endif                                 /* typedef_InstanceStruct_lOHat2Ol6eEqS22di7nwME */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */

/* Function Definitions */
extern void method_dispatcher_lOHat2Ol6eEqS22di7nwME(SimStruct *S, int_T method,
  void* data);

#endif
