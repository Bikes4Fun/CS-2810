                .global array_max
                .text

# int array_max(int *array, int count)
array_max:
   # array_max(array_address, array_count)
   # a0 - array param
   # a1 - array count param
   # a2 - largest value
   # a3 - i? current address?
   ld a2, 0(a0)
   li a3, 1
   2: bge a3, a1, 1f
   slli t0, a3, 3
   ld a2, (t0)
   addi a3, a3, 1
   j 2b
   1: li a0, 33
   ret
