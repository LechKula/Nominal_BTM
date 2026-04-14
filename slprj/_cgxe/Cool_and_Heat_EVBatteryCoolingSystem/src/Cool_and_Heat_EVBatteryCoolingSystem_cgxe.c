/* Include files */

#include "Cool_and_Heat_EVBatteryCoolingSystem_cgxe.h"
#include "m_lOHat2Ol6eEqS22di7nwME.h"

unsigned int cgxe_Cool_and_Heat_EVBatteryCoolingSystem_method_dispatcher
  (SimStruct* S, int_T method, void* data)
{
  if (ssGetChecksum0(S) == 3087990433 &&
      ssGetChecksum1(S) == 1028305026 &&
      ssGetChecksum2(S) == 36853912 &&
      ssGetChecksum3(S) == 3935195307) {
    method_dispatcher_lOHat2Ol6eEqS22di7nwME(S, method, data);
    return 1;
  }

  return 0;
}
