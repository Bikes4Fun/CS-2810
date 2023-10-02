                .global array_sum
                .text

# int array_sum(int *array, int count, int threshold)
array_sum:
                # a0 = was array[a0] but now = sum
                # a1 = array size
                # a2 = threshold to compare if current >= threshold, sum += current
                # a3 = start of array: reassigned from a0 to use a0 as sum
                # a4 = current value
                # t0 = i counter
                # t1 = temp, noting as reserved for readability 

                # 1  = initiation of while loop
                # 2  = exit

                # |--- initiate variables ---|
             
                ld      a4, 0(a0)       # initiate current to value of a0
                li      a3, 0           # initiate sum/return register to 0
                li      t0, 0           # initiate i counter to 0
                li      t1, 0           # do nothing with tX, but visualize its use as a temp

                # |--- initiate while loop ---|
        1:      bge     t0, a1, 2f         # if i >= size of array, branch to exit

                # |---validated while loop---|
                slli    t1, t0, 3         # calculate incrementor of new address: i * 2^3 ?
                add     t1, a0, t1         # temp = address of new current = address of start plus incrementor 
                ld      a4, 0(t1)           # current = address start[0]
                addi    t0, t0, 1         # i+=1

                # |--- if: current >= threshold else ---|
                blt     a4, a2, 1b          # if: current < threshold, start over, else: continue
                add     a2, a2, a4         # else: sum += current
                j       1b
        2:      
		mv	a0, a2
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

# leaf function:
#     no need to set up a stack frame.
#     do everything using scratch registers.
