                .global array_sum
                .text

# int array_sum(int *array, int count)
array_sum:
            #                       64
            #       +-------------+
            #       | saved ra    | 56
            #       +-------------+
            #       | saved s4    | 48
            #       +-------------+
            #       | saved s3    | 40
            #       +-------------+
            #       | saved s2    | 32
            #       +-------------+
            #       | saved s1    | 24
            #       +-------------+
            #       | saved s0    | 16
            #       +-------------+
            #       |             | 8
            #       +-------------+
            # sp -> |             | 0
            #       +-------------+

            addi    sp, sp, -64
            sd      ra, 56(sp)
            sd      s4, 48(sp)
            sd      s3, 40(sp)
            sd      s2, 32(sp)
            sd      s1, 24(sp)
            sd      s0, 16(sp)
                ret
