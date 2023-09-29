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
        ##if a0 > a2: add a2 to t2: else make a0 = 33: return
        
        bge t3, a2, 2f  #if current(t3) >= threshold(a2) branch and add, then return
        
        ld t3, 8(a0)    #manually load a new item into current
        bge t3, a2, 2f  #if new current(t3) >= threshold(a2) branch and add
        
        ld t3, 16(a0)   #load our current value 16 beyond a0
	bge t3, a2, 2f

3:      li a0, 33       #if none of them are >=, make a0 33
        j 1             #jump to return
2:	add a3, a3, t3  #to total(a3) load current(t3)
	mv a0, a3       #move sum to return
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
