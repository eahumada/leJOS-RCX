
// Memory overflow test

import tinyvm.rcx.*;

public class Test13
{ 
  public static void main (String[] argv)
  {
    int i = 0;
    try {
      for (;;)
      {
        i++;
        new Object();
      }
    } finally {
      ROM.setLcdNumber (ROM.LCD_CODE_UNSIGNED, i, ROM.LCD_POINT_DECIMAL_0);
      ROM.refreshLcd();
      for (int k = 0; k < 50000; k++) {}
    }    
  }
}

