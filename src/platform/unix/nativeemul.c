/**
 * nativeemul.c
 * Native method handling for unix_impl (emulation).
 */
#include <stdio.h>
#include "types.h"
#include "trace.h"
#include "constants.h"
#include "specialsignatures.h"
#include "specialclasses.h"
#include "memory.h"
#include "threads.h"
#include "classes.h"
#include "language.h"
#include "configure.h"
#include "interpreter.h"
#include "exceptions.h"

static TWOBYTES gSensorValue = 0;

void dispatch_native (TWOBYTES signature, STACKWORD *paramBase)
{
  ClassRecord *classRecord;

  switch (signature)
  {
    case START_V:
      init_thread ((Thread *) paramBase[0]);
      break;
    case CALLROM0_V:
      printf ("& ROM call 0: 0x%lX\n", paramBase[0]);
      break;      
    case CALLROM1_V:
      printf ("& ROM call 1: 0x%lX (%ld)\n", paramBase[0], paramBase[1]);
      break;      
    case CALLROM2_V:
      printf ("& ROM call 2: 0x%lX (%ld, %ld)\n", paramBase[0],
                                                  paramBase[1],
                                                  paramBase[2]
             );
      break;      
    case CALLROM3_V:
      printf ("& ROM call 3: 0x%lX (%ld, %ld, %ld)\n", paramBase[0],
                                                     paramBase[1],
                                                     paramBase[2],
                                                     paramBase[3]
             );
      break;      
    case CALLROM4_V:
      printf ("& ROM call 4: 0x%lX (%ld, %ld, %ld, %ld)\n", paramBase[0],
                                                     paramBase[1],
                                                     paramBase[2],
                                                     paramBase[3],
                                                     paramBase[4]
             );
      break;      
    case READMEMORYBYTE_B:
      printf ("& Attempt to read byte from 0x%lX\n", (paramBase[0] & 0xFFFF));
      if ((paramBase[0] & 0x0001) == 0)
        *(++stackTop) = gSensorValue >> 8;
      else
      {
        *(++stackTop) = gSensorValue & 0xFF;
        gSensorValue++;
      }
      do_return (1);
      return;
    case WRITEMEMORYBYTE_V:
      printf ("& Attempt to write byte [%lX] at 0x%lX (no effect)\n", paramBase[1] & 0xFF, paramBase[0] & 0xFFFF);
      break;
    case GETDATAADDRESS_I:
      *(++stackTop) = ptr2word (((byte *) word2ptr (paramBase[0])) + HEADER_SIZE);
      do_return (1);
      return;
    case RESETRCX_V:
      printf ("& Call to resetRcx");
      break;
    #ifdef VERIFY
    default:
      assert (false, 2000 + signature);
    #endif VERIFY
  }
  do_return (0);
} 


