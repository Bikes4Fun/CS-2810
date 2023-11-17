                .global pencil_marks, get_used, clear_used, count_bits
                .text

# count_bits(n) -> # of bits set in n (only counting bits 0-9 inclusive)
count_bits:
        li      t0, 1	        # mask
        li      t1, 0           # result of AND t0 with a0
        li      a1, 0           # count = 0
        li      a2, 0           # index = 0
        li      a3, 9           # range max = 9
        beqz    a0, 2f

1:      bgt     a2, a3, 2f      # if index > range max: branch to exit sequence, else continue 'while'
        and     t1, a0, t0      # temp = function arument & mask value
        bnez    t1, 3f          # if temp != 0: branch to next

4:      addi    a2, a2, 1       # next: index += 1
        slli    t0, t0, 1
        j       1b              # jump to 'while' loop

3:      addi    a1, a1, 1       # else: count += 1
        j    4b

2:      mv      a0, a1          # return how many bits in set
        ret

# get_used(board, group) -> used
get_used:
#       prelude
        addi    sp, sp, -48 
        sd      ra, 40(sp)
        sd      s4, 32(sp)
        sd      s3, 24(sp)
        sd      s2, 16(sp)
        sd      s1, 8(sp)
        sd      s0, 0(sp)

        mv      s0, a0
        mv      s1, a1
        li      s3, 0           # used
        li      s4, 0           # iter

1:      li      t0, 9
        bge     s4, t0, 2f
        add     t0, s1, s4      # t0 = address of number needed from table: table + index
        lb      t0, 0(t0)       # t0 = element in table address
        slli    t0, t0, 1       # t0 = a0 shifted t0 times
        add     t0, s0, t0
        lh      s2, 0(t0)
        mv      a0, s2
        call count_bits
        li      t0, 1
        bne     a0, t0, 3f
        or      s3, s3, s2
3:      addi    s4, s4, 1       # Return the “used” list as a set with one bit per used number (currently returning total used)
        j       1b

2:      mv      a0, s3          # ret

#       postlude
        ld      ra, 40(sp)
        ld      s4, 32(sp)
        ld      s3, 24(sp)
        ld      s2, 16(sp)
        ld      s1, 8(sp)
        ld      s0, 0(sp)
        addi    sp, sp, 48
    ret

# clear_used(board, group, used)
clear_used:	
#       prelude:
        addi    sp, sp, -72
        sd      ra, 64(sp)
        sd      s7, 56(sp)
        sd      s6, 48(sp)
        sd      s5, 40(sp)
        sd      s4, 32(sp)
        sd      s3, 24(sp)
        sd      s2, 16(sp)
        sd      s1, 8(sp)
        sd      s0, 0(sp)

#       variables
        mv      s0, a0          # board
        mv      s1, a1          # group
        mv      s2, a2          # used
        not     s2, s2          # used' (not used)
        li      s3, 0           # group_index
        li      s4, 0           # changes
        #       s5              # element
        #       s6              # element address
        li      t0, 9           # iteration max
        #       t1              # board_index
        #       t2              # element

1:      li      t0, 9           # iteration max
        bge     s3, t0, 2f      # while group index < 9: iterate and group ++
        #t1     = s1[s3]        # board_index = group[group_index]
        add     t1, s1, s3      # t1 = group + iteration count
        lb      t1, 0(t1)       # t1 = value at table address
        slli    t1, t1, 1       # t1 = t1 shifted 1 times
        add     t1, s0, t1      #
        mv      s6, t1          # save element address
        lh      s5, 0(t1)       # element = board[board_index]
        mv      a0, s5
        call count_bits
        mv      t3, a0
        li      t0, 1
        beq     t3, t0, 3f
        and     t3, s5, s2      # new_element = clear the bits indicated by used
        beq     t3, s5, 3f      # continue if bits need to be cleared
        sh      t3, (s6)        # board[board_index] = new_element
        li      s4, 1
3:      addi    s3, s3, 1       # group_index iterate counter ++
        j       1b
# |+--- end loop ---+|

2:      mv      a0, s4
#       postlude
        ld      ra, 64(sp)
        ld      s7, 56(sp)
        ld      s6, 48(sp)
        ld      s5, 40(sp)
        ld      s4, 32(sp)
        ld      s3, 24(sp)
        ld      s2, 16(sp)
        ld      s1, 8(sp)
        ld      s0, 0(sp)
        addi    sp, sp, 72
        ret

# pencil_marks(board, table) -> group iteration table
pencil_marks:
    # calculate pencil markings for the entire board, use the helper functions from the previous steps.
    # 0: no changes  1: something changed
    # psuedo
        # changed = 0
        # group_start = 0
        # while group_start < 27*9:
            #  start = table + group_start
            #  used = get_used(board, start) pass get used the group to calculate
            ## if clear_used(board(a0), table+group_start(a1), used(a2)) != 0:
                # changed = 1

#       prelude:
        addi    sp, sp, -72
        sd      ra, 64(sp)
        sd      s7, 56(sp)
        sd      s6, 48(sp)
        sd      s5, 40(sp)
        sd      s4, 32(sp)
        sd      s3, 24(sp)
        sd      s2, 16(sp)
        sd      s1, 8(sp)
        sd      s0, 0(sp)

#       variables
        mv      s0, a0            # board
        mv      s1, a1            # table
        li      s2, 0             # changed
        li      s3, 0             # group_start
        li      s4, 243           # iterate max
        li      s5, 0             # group
        #temps: t1 = start...

1:      bgt     s3, s4, 2f        # if s3 > 27*9 then target
        add     s5, s1, s3        # address of start(s5) = (table(s1) + group_start(s3))
        mv      a1, s5
        mv      a0, s0
        call get_used

        mv      a2, a0            # put 'used' into a2 (third placed passing value)
        mv      a1, s5            # put group into a1 to pass to clear used
        mv      a0, s0            # put my current board back into a0
        call clear_used

        beqz    a0, 3f
        li      s2, 1

3:      addi    s3, s3, 9
        j       1b

2:      mv      a0, s2

#       postlude
        ld      ra, 64(sp)
        ld      s7, 56(sp)
        ld      s6, 48(sp)
        ld      s5, 40(sp)
        ld      s4, 32(sp)
        ld      s3, 24(sp)
        ld      s2, 16(sp)
        ld      s1, 8(sp)
        ld      s0, 0(sp)
        addi    sp, sp, 72
        ret
