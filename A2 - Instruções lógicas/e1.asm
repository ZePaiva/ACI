.data
.text
.globl main
main: ori $t0, $0, 0x5c1b
      ori $t1, $0, 0xa3e4
      and $t2, $t1, $t0
      or  $t3, $t1, $t0
      nor $t4, $t1, $t0
      xor $t5, $t1, $t0
      
      ori $t3, $0, 0x0f1e
      ori $t4, $0, 0x0614
      ori $t5, $0, 0xe543
      
      nor $t5, $t5, $t5
      nor $t4, $t4, $t4
      nor $t3, $t3, $t3
      
      jr $ra