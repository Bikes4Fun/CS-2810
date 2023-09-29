                .global array_sum
                .text

# int array_sum(int *array, int count, int threshold)
array_sum:
        # a0 array address
        # a1 len of array
        # a2 threshold - sum elements greater or equal 
        # a3 sum - current total sum - initiate at 0
        # t0 i: counter to += each iteration while < a1 len of array
        # t1 increment register address by counter * increment
        # t3 current value

        li a3, 0        #load SUM as 0
        ld t3, 0(a0)    #load CURRENT as 0
        li t0, 1        #load COUNTER as 0 !!!!!! testing w 1
        li t1, 8        #load register incrementer as 8
        #if a0 > a2: add a2 to t2: else make a0 = 33: return
	
        bgt a1, t0, 3f
        bge t3, a2, 1f
	
        ld t3, 8(a0)
	li t0, 2
	
        bgt a1, t0, 3f
        bge t3, a2, 1f
	
        ld t3, 16(a0) #load our current value 16 beyond a0
        li t0, 3
	bgt, a1, t0, 2f #if temporary i counter is greater than len array, branch and return
	bge t3, a2, 1f
3:      li a0, 33
        j 1
2:	add a3, a3, a0  #to our total(a3) load current(t3)
        j 3
	mv a0, a3
1:      ret


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

# leaf function:
#     no need to set up a stack frame.
#     do everything using scratch registers.
