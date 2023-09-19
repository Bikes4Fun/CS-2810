                .global array_max
                .text

# int array_max(int *array, int count)
array_max:
   # array_max(array_address, array_count)
   #     greatest_array_int = array_address[0]
	#current_address = array_address
	#next_address += next_address_value
	#largest_address = array_address + array_count
    ld a1, 0(a0)
    ld a0, 0(a1)
    ret
