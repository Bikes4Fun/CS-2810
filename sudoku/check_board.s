                .global check_board
                .text

# check_board(board) ->
#     -1: board is unsolvable
#     0-80: position of most-constrained cell
#     81: board is solved
check_board:
    # prelude:
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

    #set variables/registers
        #s2-s11
        #a0     board
        mv      s0, a0
        mv      s1, a0          # iterated board
        li      s2, 10          # most constrained count
        li      s3, 81          # iterate / most constrained index
        addi    s4, a0, 81      # kill loop
        ## while iterate < 81:
        ## board value = board+iterator, lh[0]? mv, a0, board_value
        ## if: count_bits returns 0: li 10, -1 and return
        ## else: iterate++, jump to while loop

    1:  bge     s1, s4, 3f
        lh      a0, (s1)
        call    count_bits
        bnez    a0, 2f
        li      s3, -1
        j       3f
        
    2:  bge     a0, s2, 4f      # if bits are greater or == to current lowest bits
        mv      s2, a0
        sub     s3, s1, s0      # move address of lesser bits into most constrained address
    
    4:  addi    s1, s1, 1
        j       1b

    3:  # calculate return
        mv      a0, s3

    # postlude
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
