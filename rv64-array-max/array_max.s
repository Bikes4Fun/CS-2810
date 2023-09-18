                .global array_max
                .text

# int array_max(int *array, int count)
array_max:
   # array_max(array_address, array_count)
   #     greatest_array_int = array_address[0]
	#current_address = array_address
	#next_address += next_address_value
	#largest_address = array_address + array_count
    lw a0, 0(a0)
    mv t0, a0
    ret
# int array_max(int *array, int count)
array_max:
   # array_max(array_address, array_count)
   #     greatest_array_int = array_address[0]
	#current_address = array_address
	#next_address += next_address_value
	#largest_address = array_address + array_count
    lw t0, 0(a0)
    lw t2, 0(a1)
    blt t2, 2, 1f		
    li a0, 666
1:  mv a0, t0
    ret
