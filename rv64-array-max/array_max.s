                .global array_max
                .text

# int array_max(int *array, int count)
array_max:
   # array_max(array_address, array_count)
   # a0 - array param
   # a1 - array count param
   # a2 - largest value initiated at index 0 or a0
   	# a3 - i: counter to compute current address
   	#t0 - current address computed with a0 = t0+4
  	# a4 - value to compare
	ld a2, 0(a0)
	li a3, 1
    2: 	bge a3, a1, 1f
   	slli t0, a3, 3		#shift current address by 4 (counter + 3)
   	addi a3, a3, 1 		#increm counter
   	add t0, a0, t0 		#
  	ld a4, (t0)    		# place value of current address into compare 
  	bgt a4, a2, 3f   	# if compare is greater than current greatest, branch to swap 
   	j 2b	      		# if compare is less than current greates, keep comparing
    3: mv a2, a4
	j 2b
    1: mv a0, a2
    ret
