                .global guess

                .data
msg_guess_1:    .asciz  "\nGuessing "
msg_guess_2:    .asciz  " at position ("
msg_guess_3:    .asciz  ", "
msg_guess_4:    .asciz  ")\n"
                .text

# guess(board, table, position) ->
#     0 -> success
#     1 -> failure
guess:
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

        mv      s0, a0          # board = s0              
        mv      s1, a1
        mv      s2, s2
        #position_value:
        slli    s3, s2, 1
        add     s3, s3, s0
        lh      s3, (s3)
        li      s4, 1           # guess
        
        li      t1, 9           # max_guess
        
        #mask = slli     mask, guess, 1
        #cell_value = board[position_value]

    1:  #while loop over guesses (1 to 9)
        li      t1, 9
        bgt     s4, t1, end      # while guess <= max_guess: 
        slli    s5, s4, 1
        
        and     s5, s5, s3
        
        mv      a0, s0
        mv      a1, s1
        call    guess           #(guess, position)

        #Set cell to the guess value
        #board[position] = mask

        mv      a0, s0
        mv      a1, s1
        call    solve
        bnez    a0, continue
        li      a0, 0
        ret

    continue:
        addi    s4, s4, 1    

    no_solution:
        li      a0, 1
        ret


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
