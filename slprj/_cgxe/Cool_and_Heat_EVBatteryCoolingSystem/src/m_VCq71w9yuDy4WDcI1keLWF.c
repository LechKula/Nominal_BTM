/* Include files */

#include "modelInterface.h"
#include "m_VCq71w9yuDy4WDcI1keLWF.h"
#include "mwstringutil.h"

/* Type Definitions */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
static void cgxe_mdl_start(InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance);
static void cgxe_mdl_initialize(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance);
static void cgxe_mdl_outputs(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance);
static void cgxe_mdl_update(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance);
static void cgxe_mdl_derivative(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance);
static void cgxe_mdl_enable(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance);
static void cgxe_mdl_disable(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance);
static void cgxe_mdl_terminate(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance);
static void CheckPythonError(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *pyObjsToRelease[], int32_T numObjToRelease);
static real_T PyObj_marshalIn(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *pyToMarshal, PyObject *pyOwner);
static PyObject *getPyNamespaceDict(void);
static void assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance,
  PyObject *dict, char_T *key, real_T val);
static void b_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void c_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void d_assignToPyDict(PyObject *dict, char_T *key, PyObject *val);
static void e_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void f_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void g_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void execPyScript(InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance,
  char_T *script, PyObject *ns);
static PyObject *getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key);
static PyObject *b_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key);
static PyObject *c_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key);
static PyObject *d_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key);
static PyObject *e_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key);
static PyObject *f_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key);
static void h_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void i_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void j_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void k_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void l_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void m_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void n_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void o_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void p_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void q_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void r_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val);
static void b_execPyScript(InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance,
  char_T *script, PyObject *ns);
static PyObject *g_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key);
static PyObject *h_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key);
static PyObject *i_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key);
static PyObject *j_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key);
static PyObject *k_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key);
static PyObject *l_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key);
static int32_T deleteDictItem(PyObject *dict, char_T *key);
static int32_T b_deleteDictItem(PyObject *dict, char_T *key);
static int32_T c_deleteDictItem(PyObject *dict, char_T *key);
static int32_T d_deleteDictItem(PyObject *dict, char_T *key);
static int32_T e_deleteDictItem(PyObject *dict, char_T *key);
static void c_execPyScript(InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance,
  char_T *script, PyObject *ns);
static void init_simulink_io_address(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance);

/* Function Definitions */
static void cgxe_mdl_start(InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance)
{
  init_simulink_io_address(moduleInstance);
  cgxertSetSimStateCompliance(moduleInstance->S, 4);
}

static void cgxe_mdl_initialize(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance)
{
  PyObject *r;
  cgxertInitMLPythonIFace();
  moduleInstance->GIL = PyGILState_Ensure();
  moduleInstance->namespaceDict = getPyNamespaceDict();
  assignToPyDict(moduleInstance, moduleInstance->namespaceDict, "Q_heat", 0.0);
  b_assignToPyDict(moduleInstance, moduleInstance->namespaceDict, "T_bat_pred",
                   0.0);
  c_assignToPyDict(moduleInstance, moduleInstance->namespaceDict,
                   "T_bat_pred_nn", 0.0);
  d_assignToPyDict(moduleInstance->namespaceDict, "myController", Py_BuildValue(
    ""));
  e_assignToPyDict(moduleInstance, moduleInstance->namespaceDict, "omega", 0.0);
  f_assignToPyDict(moduleInstance, moduleInstance->namespaceDict, "pred_error",
                   0.0);
  g_assignToPyDict(moduleInstance, moduleInstance->namespaceDict,
                   "pred_error_nn", 0.0);
  execPyScript(moduleInstance,
               "from nominal_acados_mpc_battery import Controller\nmyController = Controller();\nmyController.setup(20.5+273.15, 19 + 273.15)\n",
               moduleInstance->namespaceDict);
  r = getPyDictVal(moduleInstance, moduleInstance->namespaceDict, "Q_heat");
  *moduleInstance->b_y1 = PyObj_marshalIn(moduleInstance, r, NULL);
  Py_DecRef(r);
  r = b_getPyDictVal(moduleInstance, moduleInstance->namespaceDict, "T_bat_pred");
  *moduleInstance->y3 = PyObj_marshalIn(moduleInstance, r, NULL);
  Py_DecRef(r);
  r = c_getPyDictVal(moduleInstance, moduleInstance->namespaceDict,
                     "T_bat_pred_nn");
  *moduleInstance->y2 = PyObj_marshalIn(moduleInstance, r, NULL);
  Py_DecRef(r);
  r = d_getPyDictVal(moduleInstance, moduleInstance->namespaceDict, "omega");
  *moduleInstance->b_y0 = PyObj_marshalIn(moduleInstance, r, NULL);
  Py_DecRef(r);
  r = e_getPyDictVal(moduleInstance, moduleInstance->namespaceDict, "pred_error");
  *moduleInstance->y5 = PyObj_marshalIn(moduleInstance, r, NULL);
  Py_DecRef(r);
  r = f_getPyDictVal(moduleInstance, moduleInstance->namespaceDict,
                     "pred_error_nn");
  *moduleInstance->y4 = PyObj_marshalIn(moduleInstance, r, NULL);
  Py_DecRef(r);
  PyGILState_Release(moduleInstance->GIL);
}

static void cgxe_mdl_outputs(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance)
{
  PyObject *r;
  moduleInstance->GIL = PyGILState_Ensure();
  h_assignToPyDict(moduleInstance, moduleInstance->namespaceDict, "Q_heat",
                   *moduleInstance->b_y1);
  i_assignToPyDict(moduleInstance, moduleInstance->namespaceDict, "SOC_0",
                   *moduleInstance->u1);
  j_assignToPyDict(moduleInstance, moduleInstance->namespaceDict, "T_bat_0",
                   *moduleInstance->u3);
  k_assignToPyDict(moduleInstance, moduleInstance->namespaceDict, "T_bat_pred", *
                   moduleInstance->y3);
  l_assignToPyDict(moduleInstance, moduleInstance->namespaceDict,
                   "T_bat_pred_nn", *moduleInstance->y2);
  m_assignToPyDict(moduleInstance, moduleInstance->namespaceDict, "current",
                   *moduleInstance->u0);
  n_assignToPyDict(moduleInstance, moduleInstance->namespaceDict, "dSOC",
                   *moduleInstance->u2);
  o_assignToPyDict(moduleInstance, moduleInstance->namespaceDict, "dT_bat",
                   *moduleInstance->u4);
  p_assignToPyDict(moduleInstance, moduleInstance->namespaceDict, "omega",
                   *moduleInstance->b_y0);
  q_assignToPyDict(moduleInstance, moduleInstance->namespaceDict, "pred_error", *
                   moduleInstance->y5);
  r_assignToPyDict(moduleInstance, moduleInstance->namespaceDict,
                   "pred_error_nn", *moduleInstance->y4);
  b_execPyScript(moduleInstance,
                 "omega, Q_heat, T_bat_pred_nn, T_bat_pred, pred_error_nn, pred_error = myController.get_input(20.5+273.15,T_bat_0, SOC_0, current"
                 ", dT_bat, dSOC)", moduleInstance->namespaceDict);
  r = g_getPyDictVal(moduleInstance, moduleInstance->namespaceDict, "Q_heat");
  *moduleInstance->b_y1 = PyObj_marshalIn(moduleInstance, r, NULL);
  Py_DecRef(r);
  r = h_getPyDictVal(moduleInstance, moduleInstance->namespaceDict, "T_bat_pred");
  *moduleInstance->y3 = PyObj_marshalIn(moduleInstance, r, NULL);
  Py_DecRef(r);
  r = i_getPyDictVal(moduleInstance, moduleInstance->namespaceDict,
                     "T_bat_pred_nn");
  *moduleInstance->y2 = PyObj_marshalIn(moduleInstance, r, NULL);
  Py_DecRef(r);
  r = j_getPyDictVal(moduleInstance, moduleInstance->namespaceDict, "omega");
  *moduleInstance->b_y0 = PyObj_marshalIn(moduleInstance, r, NULL);
  Py_DecRef(r);
  r = k_getPyDictVal(moduleInstance, moduleInstance->namespaceDict, "pred_error");
  *moduleInstance->y5 = PyObj_marshalIn(moduleInstance, r, NULL);
  Py_DecRef(r);
  r = l_getPyDictVal(moduleInstance, moduleInstance->namespaceDict,
                     "pred_error_nn");
  *moduleInstance->y4 = PyObj_marshalIn(moduleInstance, r, NULL);
  Py_DecRef(r);
  PyGILState_Release(moduleInstance->GIL);
}

static void cgxe_mdl_update(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance)
{
  (void)moduleInstance;
}

static void cgxe_mdl_derivative(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance)
{
  (void)moduleInstance;
}

static void cgxe_mdl_enable(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance)
{
  (void)moduleInstance;
}

static void cgxe_mdl_disable(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance)
{
  (void)moduleInstance;
}

static void cgxe_mdl_terminate(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance)
{
  moduleInstance->GIL = PyGILState_Ensure();
  deleteDictItem(moduleInstance->namespaceDict, "SOC_0");
  b_deleteDictItem(moduleInstance->namespaceDict, "T_bat_0");
  c_deleteDictItem(moduleInstance->namespaceDict, "current");
  d_deleteDictItem(moduleInstance->namespaceDict, "dSOC");
  e_deleteDictItem(moduleInstance->namespaceDict, "dT_bat");
  c_execPyScript(moduleInstance, "", moduleInstance->namespaceDict);
  Py_DecRef(moduleInstance->namespaceDict);
  PyGILState_Release(moduleInstance->GIL);
}

static void CheckPythonError(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *pyObjsToRelease[], int32_T numObjToRelease)
{
  PyObject *pMsg;
  PyObject *pTraceback = NULL;
  PyObject *pType = NULL;
  PyObject *pValue = NULL;
  PyObject *sep = NULL;
  PyObject *tracebackList = NULL;
  PyObject *tracebackModule = NULL;
  int32_T i;
  int32_T idx;
  char_T *cMsg;
  void *slString;
  i = suStringStackSize();
  PyErr_Fetch(&pType, &pValue, &pTraceback);
  PyErr_NormalizeException(&pType, &pValue, &pTraceback);
  if (pType != NULL) {
    if (pTraceback != NULL) {
      tracebackModule = PyImport_ImportModule("traceback");
      tracebackList = PyObject_CallMethod(tracebackModule, "format_exception",
        "OOO", pType, pValue, pTraceback);
      sep = PyUnicode_FromString("");
      pMsg = PyUnicode_Join(sep, tracebackList);
    } else if (pValue != NULL) {
      pMsg = PyObject_Str(pValue);
    } else {
      pMsg = PyObject_Str(pType);
    }

    cMsg = (char_T *)PyUnicode_AsUTF8(pMsg);
    if (cMsg == NULL) {
      cMsg =
        "Simulink encountered an error when converting a python error message to UTF-8";
      PyErr_Clear();
    } else {
      slString = suAddStackString(cMsg);
      cMsg = suToCStr(slString);
    }

    if (sep != NULL) {
      Py_DecRef(sep);
    }

    if (tracebackList != NULL) {
      Py_DecRef(tracebackList);
    }

    if (tracebackModule != NULL) {
      Py_DecRef(tracebackModule);
    }

    if (pMsg != NULL) {
      Py_DecRef(pMsg);
    }

    pMsg = pType;
    if (pMsg != NULL) {
      Py_DecRef(pMsg);
    }

    pMsg = pValue;
    if (pMsg != NULL) {
      Py_DecRef(pMsg);
    }

    pMsg = pTraceback;
    if (pMsg != NULL) {
      Py_DecRef(pMsg);
    }

    for (idx = 0; idx < numObjToRelease; idx++) {
      pMsg = pyObjsToRelease[idx];
      if (pMsg != NULL) {
        Py_DecRef(pMsg);
      }
    }

    PyGILState_Release(moduleInstance->GIL);
    cgxertReportError(moduleInstance->S, -1, -1,
                      "Simulink:CustomCode:PythonRuntimeError", 3, 1, strlen
                      (cMsg), cMsg);
  }

  suMoveReturnedStringsToTopOfCallerStack(i, 0);
}

static real_T PyObj_marshalIn(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *pyToMarshal, PyObject *pyOwner)
{
  PyObject *pyObjArray[1];
  PyObject *objToRelease;
  real_T outputVal;
  outputVal = PyFloat_AsDouble(pyToMarshal);
  if (pyOwner == NULL) {
    objToRelease = pyToMarshal;
  } else {
    objToRelease = pyOwner;
  }

  pyObjArray[0U] = objToRelease;
  CheckPythonError(moduleInstance, pyObjArray, 1);
  return outputVal;
}

static PyObject *getPyNamespaceDict(void)
{
  return PyDict_Copy(PyModule_GetDict(PyImport_AddModule("__main__")));
}

static void assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance,
  PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void b_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void c_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void d_assignToPyDict(PyObject *dict, char_T *key, PyObject *val)
{
  if (dict != NULL) {
    PyDict_SetItemString(dict, key, val);
    Py_DecRef(val);
  }
}

static void e_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void f_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void g_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void execPyScript(InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance,
  char_T *script, PyObject *ns)
{
  PyObject *pyObjArray[2];
  PyObject *codeObject;
  PyObject *originalNamespace;
  PyObject *unusedEvalResult;
  Py_ssize_t i;
  Py_ssize_t numKeysInModifiedNs;
  if (ns != NULL) {
    codeObject = Py_CompileString(script, "Python Code Block", 257);
    CheckPythonError(moduleInstance, NULL, 0);
    originalNamespace = PyDict_Copy(ns);
    unusedEvalResult = PyEval_EvalCode(codeObject, ns, ns);
    pyObjArray[0U] = codeObject;
    pyObjArray[1U] = unusedEvalResult;
    CheckPythonError(moduleInstance, pyObjArray, 2);
    Py_DecRef(codeObject);
    if (unusedEvalResult != NULL) {
      Py_DecRef(unusedEvalResult);
    }

    codeObject = PyDict_Keys(ns);
    numKeysInModifiedNs = PyList_Size(codeObject);
    for (i = 0; i < numKeysInModifiedNs; i++) {
      unusedEvalResult = PySequence_GetItem(codeObject, i);
      CheckPythonError(moduleInstance, NULL, 0);
      if ((PyDict_Contains(originalNamespace, unusedEvalResult) == 0) &&
          (!PyModule_Check(PyDict_GetItem(ns, unusedEvalResult)))) {
        PyDict_DelItem(ns, unusedEvalResult);
      }

      Py_DecRef(unusedEvalResult);
    }

    Py_DecRef(codeObject);
    Py_DecRef(originalNamespace);
  }
}

static PyObject *getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key)
{
  PyObject *b_value;
  b_value = PyDict_GetItemString(dict, key);
  CheckPythonError(moduleInstance, NULL, 0);
  Py_IncRef(b_value);
  return b_value;
}

static PyObject *b_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key)
{
  PyObject *b_value;
  b_value = PyDict_GetItemString(dict, key);
  CheckPythonError(moduleInstance, NULL, 0);
  Py_IncRef(b_value);
  return b_value;
}

static PyObject *c_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key)
{
  PyObject *b_value;
  b_value = PyDict_GetItemString(dict, key);
  CheckPythonError(moduleInstance, NULL, 0);
  Py_IncRef(b_value);
  return b_value;
}

static PyObject *d_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key)
{
  PyObject *b_value;
  b_value = PyDict_GetItemString(dict, key);
  CheckPythonError(moduleInstance, NULL, 0);
  Py_IncRef(b_value);
  return b_value;
}

static PyObject *e_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key)
{
  PyObject *b_value;
  b_value = PyDict_GetItemString(dict, key);
  CheckPythonError(moduleInstance, NULL, 0);
  Py_IncRef(b_value);
  return b_value;
}

static PyObject *f_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key)
{
  PyObject *b_value;
  b_value = PyDict_GetItemString(dict, key);
  CheckPythonError(moduleInstance, NULL, 0);
  Py_IncRef(b_value);
  return b_value;
}

static void h_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void i_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void j_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void k_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void l_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void m_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void n_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void o_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void p_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void q_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void r_assignToPyDict(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key, real_T val)
{
  PyObject *pyObj;
  if (dict != NULL) {
    pyObj = PyFloat_FromDouble(val);
    CheckPythonError(moduleInstance, NULL, 0);
    PyDict_SetItemString(dict, key, pyObj);
    Py_DecRef(pyObj);
  }
}

static void b_execPyScript(InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance,
  char_T *script, PyObject *ns)
{
  PyObject *pyObjArray[2];
  PyObject *codeObject;
  PyObject *originalNamespace;
  PyObject *unusedEvalResult;
  Py_ssize_t i;
  Py_ssize_t numKeysInModifiedNs;
  if (ns != NULL) {
    codeObject = Py_CompileString(script, "Python Code Block", 257);
    CheckPythonError(moduleInstance, NULL, 0);
    originalNamespace = PyDict_Copy(ns);
    unusedEvalResult = PyEval_EvalCode(codeObject, ns, ns);
    pyObjArray[0U] = codeObject;
    pyObjArray[1U] = unusedEvalResult;
    CheckPythonError(moduleInstance, pyObjArray, 2);
    Py_DecRef(codeObject);
    if (unusedEvalResult != NULL) {
      Py_DecRef(unusedEvalResult);
    }

    codeObject = PyDict_Keys(ns);
    numKeysInModifiedNs = PyList_Size(codeObject);
    for (i = 0; i < numKeysInModifiedNs; i++) {
      unusedEvalResult = PySequence_GetItem(codeObject, i);
      CheckPythonError(moduleInstance, NULL, 0);
      if ((PyDict_Contains(originalNamespace, unusedEvalResult) == 0) &&
          (!PyModule_Check(PyDict_GetItem(ns, unusedEvalResult)))) {
        PyDict_DelItem(ns, unusedEvalResult);
      }

      Py_DecRef(unusedEvalResult);
    }

    Py_DecRef(codeObject);
    Py_DecRef(originalNamespace);
  }
}

static PyObject *g_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key)
{
  PyObject *b_value;
  b_value = PyDict_GetItemString(dict, key);
  CheckPythonError(moduleInstance, NULL, 0);
  Py_IncRef(b_value);
  return b_value;
}

static PyObject *h_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key)
{
  PyObject *b_value;
  b_value = PyDict_GetItemString(dict, key);
  CheckPythonError(moduleInstance, NULL, 0);
  Py_IncRef(b_value);
  return b_value;
}

static PyObject *i_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key)
{
  PyObject *b_value;
  b_value = PyDict_GetItemString(dict, key);
  CheckPythonError(moduleInstance, NULL, 0);
  Py_IncRef(b_value);
  return b_value;
}

static PyObject *j_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key)
{
  PyObject *b_value;
  b_value = PyDict_GetItemString(dict, key);
  CheckPythonError(moduleInstance, NULL, 0);
  Py_IncRef(b_value);
  return b_value;
}

static PyObject *k_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key)
{
  PyObject *b_value;
  b_value = PyDict_GetItemString(dict, key);
  CheckPythonError(moduleInstance, NULL, 0);
  Py_IncRef(b_value);
  return b_value;
}

static PyObject *l_getPyDictVal(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance, PyObject *dict, char_T *key)
{
  PyObject *b_value;
  b_value = PyDict_GetItemString(dict, key);
  CheckPythonError(moduleInstance, NULL, 0);
  Py_IncRef(b_value);
  return b_value;
}

static int32_T deleteDictItem(PyObject *dict, char_T *key)
{
  if (dict != NULL) {
    PyDict_DelItemString(dict, key);
    PyErr_Clear();
  }

  return 0;
}

static int32_T b_deleteDictItem(PyObject *dict, char_T *key)
{
  if (dict != NULL) {
    PyDict_DelItemString(dict, key);
    PyErr_Clear();
  }

  return 0;
}

static int32_T c_deleteDictItem(PyObject *dict, char_T *key)
{
  if (dict != NULL) {
    PyDict_DelItemString(dict, key);
    PyErr_Clear();
  }

  return 0;
}

static int32_T d_deleteDictItem(PyObject *dict, char_T *key)
{
  if (dict != NULL) {
    PyDict_DelItemString(dict, key);
    PyErr_Clear();
  }

  return 0;
}

static int32_T e_deleteDictItem(PyObject *dict, char_T *key)
{
  if (dict != NULL) {
    PyDict_DelItemString(dict, key);
    PyErr_Clear();
  }

  return 0;
}

static void c_execPyScript(InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance,
  char_T *script, PyObject *ns)
{
  PyObject *pyObjArray[2];
  PyObject *codeObject;
  PyObject *originalNamespace;
  PyObject *unusedEvalResult;
  if (ns != NULL) {
    codeObject = Py_CompileString(script, "Python Code Block", 257);
    CheckPythonError(moduleInstance, NULL, 0);
    originalNamespace = PyDict_Copy(ns);
    unusedEvalResult = PyEval_EvalCode(codeObject, ns, ns);
    pyObjArray[0U] = codeObject;
    pyObjArray[1U] = unusedEvalResult;
    CheckPythonError(moduleInstance, pyObjArray, 2);
    Py_DecRef(codeObject);
    if (unusedEvalResult != NULL) {
      Py_DecRef(unusedEvalResult);
    }

    Py_DecRef(originalNamespace);
  }
}

static void init_simulink_io_address(InstanceStruct_VCq71w9yuDy4WDcI1keLWF
  *moduleInstance)
{
  moduleInstance->emlrtRootTLSGlobal = (void *)cgxertGetEMLRTCtx
    (moduleInstance->S);
  moduleInstance->u0 = (real_T *)cgxertGetInputPortSignal(moduleInstance->S, 0);
  moduleInstance->u1 = (real_T *)cgxertGetInputPortSignal(moduleInstance->S, 1);
  moduleInstance->u2 = (real_T *)cgxertGetInputPortSignal(moduleInstance->S, 2);
  moduleInstance->u3 = (real_T *)cgxertGetInputPortSignal(moduleInstance->S, 3);
  moduleInstance->u4 = (real_T *)cgxertGetInputPortSignal(moduleInstance->S, 4);
  moduleInstance->b_y0 = (real_T *)cgxertGetOutputPortSignal(moduleInstance->S,
    0);
  moduleInstance->b_y1 = (real_T *)cgxertGetOutputPortSignal(moduleInstance->S,
    1);
  moduleInstance->y2 = (real_T *)cgxertGetOutputPortSignal(moduleInstance->S, 2);
  moduleInstance->y3 = (real_T *)cgxertGetOutputPortSignal(moduleInstance->S, 3);
  moduleInstance->y4 = (real_T *)cgxertGetOutputPortSignal(moduleInstance->S, 4);
  moduleInstance->y5 = (real_T *)cgxertGetOutputPortSignal(moduleInstance->S, 5);
  moduleInstance->myController = (void **)cgxertGetDWork(moduleInstance->S, 0);
}

/* CGXE Glue Code */
static void mdlOutputs_VCq71w9yuDy4WDcI1keLWF(SimStruct *S, int_T tid)
{
  InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance =
    (InstanceStruct_VCq71w9yuDy4WDcI1keLWF *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_outputs(moduleInstance);
}

static void mdlInitialize_VCq71w9yuDy4WDcI1keLWF(SimStruct *S)
{
  InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance =
    (InstanceStruct_VCq71w9yuDy4WDcI1keLWF *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_initialize(moduleInstance);
}

static void mdlUpdate_VCq71w9yuDy4WDcI1keLWF(SimStruct *S, int_T tid)
{
  InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance =
    (InstanceStruct_VCq71w9yuDy4WDcI1keLWF *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_update(moduleInstance);
}

static void mdlDerivatives_VCq71w9yuDy4WDcI1keLWF(SimStruct *S)
{
  InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance =
    (InstanceStruct_VCq71w9yuDy4WDcI1keLWF *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_derivative(moduleInstance);
}

static void mdlTerminate_VCq71w9yuDy4WDcI1keLWF(SimStruct *S)
{
  InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance =
    (InstanceStruct_VCq71w9yuDy4WDcI1keLWF *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_terminate(moduleInstance);
  free((void *)moduleInstance);
}

static void mdlEnable_VCq71w9yuDy4WDcI1keLWF(SimStruct *S)
{
  InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance =
    (InstanceStruct_VCq71w9yuDy4WDcI1keLWF *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_enable(moduleInstance);
}

static void mdlDisable_VCq71w9yuDy4WDcI1keLWF(SimStruct *S)
{
  InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance =
    (InstanceStruct_VCq71w9yuDy4WDcI1keLWF *)cgxertGetRuntimeInstance(S);
  cgxe_mdl_disable(moduleInstance);
}

static void mdlStart_VCq71w9yuDy4WDcI1keLWF(SimStruct *S)
{
  InstanceStruct_VCq71w9yuDy4WDcI1keLWF *moduleInstance =
    (InstanceStruct_VCq71w9yuDy4WDcI1keLWF *)calloc(1, sizeof
    (InstanceStruct_VCq71w9yuDy4WDcI1keLWF));
  moduleInstance->S = S;
  cgxertSetRuntimeInstance(S, (void *)moduleInstance);
  ssSetmdlOutputs(S, mdlOutputs_VCq71w9yuDy4WDcI1keLWF);
  ssSetmdlInitializeConditions(S, mdlInitialize_VCq71w9yuDy4WDcI1keLWF);
  ssSetmdlUpdate(S, mdlUpdate_VCq71w9yuDy4WDcI1keLWF);
  ssSetmdlDerivatives(S, mdlDerivatives_VCq71w9yuDy4WDcI1keLWF);
  ssSetmdlTerminate(S, mdlTerminate_VCq71w9yuDy4WDcI1keLWF);
  ssSetmdlEnable(S, mdlEnable_VCq71w9yuDy4WDcI1keLWF);
  ssSetmdlDisable(S, mdlDisable_VCq71w9yuDy4WDcI1keLWF);
  cgxe_mdl_start(moduleInstance);

  {
    uint_T options = ssGetOptions(S);
    options |= SS_OPTION_RUNTIME_EXCEPTION_FREE_CODE;
    ssSetOptions(S, options);
  }
}

static void mdlProcessParameters_VCq71w9yuDy4WDcI1keLWF(SimStruct *S)
{
}

void method_dispatcher_VCq71w9yuDy4WDcI1keLWF(SimStruct *S, int_T method, void
  *data)
{
  switch (method) {
   case SS_CALL_MDL_START:
    mdlStart_VCq71w9yuDy4WDcI1keLWF(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_VCq71w9yuDy4WDcI1keLWF(S);
    break;

   default:
    /* Unhandled method */
    /*
       sf_mex_error_message("Stateflow Internal Error:\n"
       "Error calling method dispatcher for module: VCq71w9yuDy4WDcI1keLWF.\n"
       "Can't handle method %d.\n", method);
     */
    break;
  }
}

mxArray *cgxe_VCq71w9yuDy4WDcI1keLWF_BuildInfoUpdate(void)
{
  mxArray * mxBIArgs;
  mxArray * elem_1;
  mxArray * elem_2;
  mxArray * elem_3;
  double * pointer;
  mxBIArgs = mxCreateCellMatrix(1,3);
  elem_1 = mxCreateDoubleMatrix(0,0, mxREAL);
  pointer = mxGetPr(elem_1);
  mxSetCell(mxBIArgs,0,elem_1);
  elem_2 = mxCreateDoubleMatrix(0,0, mxREAL);
  pointer = mxGetPr(elem_2);
  mxSetCell(mxBIArgs,1,elem_2);
  elem_3 = mxCreateCellMatrix(1,0);
  mxSetCell(mxBIArgs,2,elem_3);
  return mxBIArgs;
}

mxArray *cgxe_VCq71w9yuDy4WDcI1keLWF_fallback_info(void)
{
  const char* fallbackInfoFields[] = { "fallbackType", "incompatiableSymbol" };

  mxArray* fallbackInfoStruct = mxCreateStructMatrix(1, 1, 2, fallbackInfoFields);
  mxArray* fallbackType = mxCreateString("incompatibleFunction");
  mxArray* incompatibleSymbol = mxCreateString("PyModule_Check");
  mxSetFieldByNumber(fallbackInfoStruct, 0, 0, fallbackType);
  mxSetFieldByNumber(fallbackInfoStruct, 0, 1, incompatibleSymbol);
  return fallbackInfoStruct;
}
