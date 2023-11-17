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
#       prelude:
        addi    sp, sp, -176    # 
        sd      ra, 168(sp)     # Save return address
        sd      s0, 160(sp)     # Save s0
        sd      s1, 152(sp)     # Save s1
        sd      s2, 144(sp)     # Save s2
        sd      s3, 136(sp)     # Save s3
        sd      s4, 128(sp)     # Save s4
        sd      s5, 120(sp)     # Save s5
        sd      s6, 112(sp)     # Save s6
        sd      s7, 104(sp)     # Save s7
        sd      s8, 96(sp)      # Save s8
        sd      s9, 88(sp)      # Save s9
        sd      s10, 80(sp)     # Save s10
        sd      s11, 72(sp)     # Save s11

#       variables
        mv      s0, a0                       
        mv      s1, a1
        mv      s2, s2
        #position_value:
        slli    s3, s2, 1
        add     s3, s3, s0
        lh      s3, (s3)
        li      s4, 1           # guess
        li      s5, 0           # save s5 for mask
        li      t1, 9           # max_guess

1:      #while loop over guesses (1 to 9)
        li      t1, 9
        bgt     s4, t1, 3f      # while guess <= max_guess: 
        slli    s5, s4, 1       # mask? #mask = slli mask, guess, 1
        add     t0, s5, s0      # cell_value? cell_value = board[position_value]
        and     s5, s5, t0      # if (cell_value & mask)
        ##if    s5: then: 
        mv      a0, s0
        mv      a1, s1
        call    guess           #(guess, position)

        #board[position] = mask  #Set cell to the guess value

        mv      a0, s0
        mv      a1, s1
        call    solve
        
        bnez    a0, 2f
        li      a0, 0
        ret

2:      addi    s4, s4, 1 
        j       1b   

3:      li      a0, 1
        ret

#       postlude:
        ld      ra, 168(sp)     # Restore return address
        ld      s0, 160(sp)     # Restore s0
        ld      s1, 152(sp)     # Restore s1
        ld      s2, 144(sp)     # Restore s2
        ld      s3, 136(sp)     # Restore s3
        ld      s4, 128(sp)     # Restore s4
        ld      s5, 120(sp)     # Restore s5
        ld      s6, 112(sp)     # Restore s6
        ld      s7, 104(sp)     # Restore s7
        ld      s8, 96(sp)      # Restore s8
        ld      s9, 88(sp)      # Restore s9
        ld      s10, 80(sp)     # Restore s10
        ld      s11, 72(sp)     # Restore s11
        addi    sp, sp, 176     
        
        ret
