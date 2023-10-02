                .global array_sum
                .text

# int array_sum(int *array, int count, int threshold)
array_sum:
                # a0 = array initial address
                # a1 = array size
                # a2 = threshold to compare if current >= threshold, sum += current

                # a3 = sum
                # a4 = current value
                # t0 = i counter
                # t1 = temp, noting as reserved for readability 

                # 1  = initiation of while loop
                # 2  = exit


                # |--- initiate variables ---|     
                ld      a4, 0(a0)         # current (first)  value = array[0] 
                li      a3, 0             # sum = 0
                li      t0, 0             # i (counter) = 0
                li      t1, 0             # visualize will be temp

       		# |---initiate while loop---|
        1:      bge     t0, a1, 2f        # if i >= len(array): exit

       		# |---continue while loop---|
                slli    t1, t0, 3         # increment = (i*2^3)  0*2^3=0, 1*2^3=8, 2*2^3=16, 3*2^3=24 ...etc
                add     t1, a0, t1        # a0+t1 (address start+incrementor) = new address saved to t1 
                ld      a4, 0(t1)         # current = value at t1[0] or address of a0[i*2^3]
                addi    t0, t0, 1         # i++

        	# |---if inside while loop ---|
                blt     a4, a2, 1b         # if: current(a4) < threshold(a2) return to while; else:
                add     a3, a3, a4         # sum += current
                j       1b                 # return to while
        
        2:      		      
		mv	a0, a3
                ret



# count some of the values in an array.
# implement int array_count(int *array, int count, int threshold)
#     x`int` values mean 64-bit integers

# array: address of array of 64-bit integers
# count: number of entries in the array
#     total memory used by the array is `8 × count`
# threshold: lowest int to sum greater or equal ints

# compute and return:
#     sum of elements in array greater or equal to `threshold`.
#     Ignore values in array less than `threshold`.

# Pseudo-code:
# int array_count(int *array, int count, int threshold) {
#     sum = 0
#     for i = 0; i < count; i++ {
#     '''if array[i] >= threshold {
#             sum += array[i]
#         }
#     }
#     return sum
# }
