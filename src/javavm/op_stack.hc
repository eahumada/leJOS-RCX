/**
 * This is included inside a switch statement.
 */

case OP_BIPUSH:
  // Stack size: +1
  // Arguments: 1
  // TBD: check negatives
  *(++stackTop) = (STACKWORD) (char) (*pc++);
  goto LABEL_ENGINELOOP;
case OP_SIPUSH:
  // Stack size: +1
  // Arguments: 2
  *(++stackTop) = (STACKWORD) (short) (((TWOBYTES) pc[0] << 8) | pc[1]);
  pc += 2;
  goto LABEL_ENGINELOOP;
case OP_LDC:
  // Stack size: +1
  // Arguments: 1
  gConstRec = get_constant_record (*pc++);

  // TBD: strings

  #ifdef VERIFY
  assert (gConstRec->constantSize <= 4);
  #endif VERIFY

  *(++stackTop) = make_word (get_constant_ptr(gConstRec), 
                  gConstRec->constantSize);
  goto LABEL_ENGINELOOP;
case OP_LDC2_W:
  // Stack size: +2
  // Arguments: 2
  gConstRec = get_constant_record (((TWOBYTES) pc[0] << 8) | pc[1]);

  #ifdef VERIFY
  assert (gConstRec->constantSize == 8);
  #endif VERIFY

  gBytePtr = get_constant_ptr (gBytePtr);
  *(++stackTop) = make_word (gBytePtr, sizeof(STACKWORD));
  *(++stackTop) = make_word (gBytePtr + sizeof(STACKWORD), sizeof(STACKWORD));
  pc += 2;
  goto LABEL_ENGINELOOP;
case OP_ACONST_NULL:
  // Stack size: +1
  // Arguments: 0
  *(++stackTop) = 0;
  goto LABEL_ENGINELOOP;
case OP_ICONST_M1:
case OP_ICONST_0:
case OP_ICONST_1:
case OP_ICONST_2:
case OP_ICONST_3:
case OP_ICONST_4:
case OP_ICONST_5:
  // Stack size: +1
  // Arguments: 0

  // TBD: check negative

  *(++stackTop) = *(pc-1) - OP_ICONST_0;
  goto LABEL_ENGINELOOP;
case OP_LCONST_0:
case OP_LCONST_1:
  // Stack size: +2
  // Arguments: 0
  *(++stackTop) = 0;
  *(++stackTop) = *(pc-1) - OP_LCONST_0;
  goto LABEL_ENGINELOOP;
case OP_FCONST_0:
case OP_FCONST_1:
case OP_FCONST_2:
  // Stack size: +1
  // Arguments: 0
  gFloat = (float) (*(pc-1) - OP_FCONST_0);
  *(++stackTop) = jfloat2word(gFloat);
  goto LABEL_ENGINELOOP;
case OP_DCONST_0:
case OP_DCONST_1:
  // Stack size: +2
  // Arguments: 0
  gFloat = (float) (*(pc-1) - OP_DCONST_0);
  *(++stackTop) = 0;
  *(++stackTop) = jfloat2word(gFloat);
  goto LABEL_ENGINELOOP;
case OP_POP2:
  // Stack size: -2
  // Arguments: 0
  stackTop--;
  // Fall through
case OP_POP:
  // Stack size: -1
  // Arguments: 0
  stackTop--;
  goto LABEL_ENGINELOOP;
case OP_DUP:
  // Stack size: +1
  // Arguments: 0
  *(stackTop+1) = *stackTop;
  stackTop++;
  goto LABEL_ENGINELOOP;
case OP_DUP2:
  // Stack size: +2
  // Arguments: 0
  *(stackTop+1) = *(stackTop-1);
  *(stackTop+2) = *stackTop;
  stackTop += 2;
  goto LABEL_ENGINELOOP;
case OP_DUP_X1:
  // Stack size: +1
  // Arguments: 0
  stackTop++;
  *stackTop = *(stackTop-1);
  *(stackTop-1) = *(stackTop-2);
  *(stackTop-2) = *stackTop;
  goto LABEL_ENGINELOOP;
case OP_DUP2_X1:
  // Stack size: +2
  // Arguments: 0
  stackTop += 2;
  *stackTop = *(stackTop-2);
  *(stackTop-1) = *(stackTop-3);
  *(stackTop-2) = *(stackTop-4);
  *(stackTop-3) = *stackTop;
  *(stackTop-4) = *(stackTop-1);
  goto LABEL_ENGINELOOP;
case OP_DUP_X2:
  // Stack size: +1
  // Arguments: 0
  stackTop++;
  *stackTop = *(stackTop-1);
  *(stackTop-1) = *(stackTop-2);
  *(stackTop-2) = *(stackTop-3);
  *(stackTop-3) = *stackTop;
  goto LABEL_ENGINELOOP;
case OP_DUP2_X2:
  // Stack size: +2
  // Arguments: 0
  stackTop += 2;
  *stackTop = *(stackTop-2);
  *(stackTop-1) = *(stackTop-3);
  *(stackTop-2) = *(stackTop-4);
  *(stackTop-3) = *(stackTop-5);
  *(stackTop-4) = *stackTop;
  *(stackTop-5) = *(stackTop-1);  
  goto LABEL_ENGINELOOP;
case OP_SWAP:
  gStackWord = *stackTop;
  *stackTop = *(stackTop-1);
  *(stackTop-1) = gStackWord;
  goto LABEL_ENGINELOOP;

// Notes:
// - LDC_W should not occur in tinyvm.
// - Arguments or LDC and LDC2_W are postprocessed.
// - NOOP is in op_skip.hc.

/*end*/






