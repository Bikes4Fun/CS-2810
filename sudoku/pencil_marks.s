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

            mv      s0, a0
            mv      s1, a1
            #       s2 = value for count bits to count
            li      s3, 0            # used
            li      s4, 0            # iter

    1:      li      t0, 9
            bgt     s4, t0, 2f
            add     t0, s1, s4       # t0 = address of number needed from table: table + index
            lb      t0, 0(t0)        # t0 = element in table address
            slli    t0, t0, 1        # t0 = a0 shifted t0 times
            add     t0, s0, t0       
            lh      s2, 0(t0)
            mv      a0, s2
            call count_bits
            li      t0, 1
            bne     a0, t0, 3f
            or      s3, s3, s2
    3:      addi    s4, s4, 1        # Return the “used” list as a set with one bit per used number (currently returning total used)
            j       1b
    2:      mv      a0, s3
            
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
