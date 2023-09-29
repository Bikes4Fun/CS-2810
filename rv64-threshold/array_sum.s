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

        li a3, 0
        mv a0, a3
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
