/* Include files */

#include "Cool_and_Heat_EVBatteryCoolingSystem_cgxe.h"
#include "m_VCq71w9yuDy4WDcI1keLWF.h"

unsigned int cgxe_Cool_and_Heat_EVBatteryCoolingSystem_method_dispatcher
  (SimStruct* S, int_T method, void* data)
{
  if (ssGetChecksum0(S) == 2741588055 &&
      ssGetChecksum1(S) == 3215618856 &&
      ssGetChecksum2(S) == 739192156 &&
      ssGetChecksum3(S) == 301271150) {
    method_dispatcher_VCq71w9yuDy4WDcI1keLWF(S, method, data);
    return 1;
  }

  return 0;
}
