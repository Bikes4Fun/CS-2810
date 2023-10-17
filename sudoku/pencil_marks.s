                .global pencil_marks, get_used, clear_used, count_bits
                .text

# count_bits(n) -> # of bits set in n (only counting bits 0-9 inclusive)
count_bits:
        #     while index <= 9:
        #         mask = 1<<index
        #         temp = n & mask
        ##         if temp != 0:
        #             count += 1
        #         index += 1
        #     return count

        li t0, 1	# mask
        li t1, 0        # result of AND t0 with a0
        li a1, 0        # count = 0
        li a2, 0        # index = 0
        li a3, 9        # range max = 9
        beqz a0, 2f

    1:  bgt  a2, a3, 2f  # if index > range max: branch to exit sequence, else continue 'while'
        and  t1, a0, t0  # temp = function arument & mask value
        bnez t1, 3f      # if temp != 0: branch to next

    4:  addi a2, a2, 1   # next: index += 1
        slli t0, t0, 1
        j    1b          # jump to 'while' loop

    3:  addi a1, a1, 1   # else: count += 1
        j    4b

    2:  mv  a0, a1
        ret

# get_used(board, group) -> used
get_used:
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

            #prelude
            addi    sp, sp, -48
            sd      ra, 40(sp)
            sd      s4, 32(sp)
            sd      s3, 24(sp)
            sd      s2, 16(sp)
            sd      s1, 8(sp)
            sd      s0, 0(sp)

            li      s0, 0            # used
            li      s1, 0            # iter
            li      s2, 9            # max
    1:      bgt     s1, s2, 2f
            add     t0, a1, s1       # t0 = address of number needed from table: table + index
            lb      t0, 0(t0)        # t0 = element in table address
            add     t0, a0, t0
            lb      t0, 0(t0)
            addi    s1, s1, 1
            j       1b
    2:      mv      a0, t0
            
            # postlude
            addi    sp, sp, 48
            ld      ra, 40(sp)
            ld      s4, 32(sp)
            ld      s3, 24(sp)
            ld      s2, 16(sp)
            ld      s1, 8(sp)
            ld      s0, 0(sp)
            ret

# clear_used(board, group, used)
clear_used:
                ret

# pencil_marks(board, table)
pencil_marks:
                ret
