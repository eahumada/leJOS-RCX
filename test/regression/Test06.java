
// Test for motor control & exception catching

import tinyvm.rcx.ROM;

public class Test06
{
  public static void myMethod()
  {
    throw new RuntimeException();
  }

  public static void main (String[] aArg)
  {
    ROM.controlMotor ('A', 1, 1);
    ROM.controlMotor ('C', 1, 7);
    for (int i = 0; i < 10000; i++) {}
    ROM.controlMotor ('A', 3, 1);
    ROM.controlMotor ('C', 3, 1);
    try {
      (new int[1])[1] = 0;
    } catch (ArrayIndexOutOfBoundsException e) {
      ROM.playTone (3000, 100);
    }
    try {
      int[] x = null;
      x[0] = 0;
    } catch (Throwable t) {
      ROM.playTone (2000, 100);
    }
    try {
      myMethod();
    } catch (Exception e) {
      ROM.playTone (1000, 100);
    }
    for (int i = 0; i < 100000; i++) {}
    try {
      int[] x = null;
      x[0] = 0;
    } catch (ArrayIndexOutOfBoundsException e) {
      ROM.playTone (3000, 200);
    } finally {
      ROM.controlMotor ('A', 1, 1);
      for (int i = 0; i < 10000; i++) {}
      ROM.controlMotor ('A', 3, 1);
    }
  }
}


