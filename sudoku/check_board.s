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
        li      s1, 0           # iterate
        li      s2, 10          # most constrained count
        li      s3, 81          # iterate / most constrained index
        li      s4, 0           # kill value
	li	s5, 81		#
        ## while iterate < 81:
        ## board value = board+iterator, lh[0]? mv, a0, board_value
        ## if: count_bits returns 0: li 10, -1 and return
        ## else: iterate++, jump to while loop

    1:  bge     s1, s5, 3f
        addi    s0, s0, 1
        lh      a0, (s0)
        call    count_bits
        bne     a0, s4, 1b
        li      s4, -1

    3:  # calculate return
        mv      a0, s4

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
