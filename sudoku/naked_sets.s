                .global naked_sets, single_pass, gather_set, clear_others
                .text

# gather_set(board, group, key) ->
#   set of pencil marks for cells identified by key
gather_set:
    # gather_set(board, group, key)
        #     set = 0
        #     for index = 0; index < 9; index++
        #         #if key & (1<<index) != 0
        #             board_index = group[index]
        #             elt = board[board_index]
        #             set = set | elt
        #     return set

        #a0 = board
        #a1 = group
        #a2 = key
        li      a3, 0        # set
        li      a4, 0        # iter
        li      a5, 9        # max iter
        li      a6, 1        # shifted index times

    1:  bge     a4, a5, 2f
        and     t0, a2, a6    # put the tester value of key and shifted value into temp
        beqz    t0, 3f        # if the anded key and shift mask == 0, perform iteration calculations cand mrestart

        ##else:
        add     t1, a1, a4    # address of lookup table item = group_address(a1) +iteration
        lb      t1, 0(t1)     # value at lookup table item = lookup table address[0]
        slli    t1, t1, 1     # I still don't understand why we do this enough to expalin it but it's something about the size of the item vs how big the register is.
        add     t2, a0, t1    # board[board_index] = board address + value at lookup table address
        lh      t2, 0(t2)     # element is board[board_index][0] or the value at board[board_index]

        #set = set union (OR) element at board[board_index]
        or      a3, a3, t2

    3:  # index ++, lli a6, a6, 1 or sll a6, index?
        addi     a4, a4, 1
        slli     a6, a6, 1
        j        1b

    2:  mv a0, a3          # move set to return register
        ret

# clear_others(board, group, key, set) ->
#    0: nothing changed
#    1: something changed
clear_others:
    #a0,                # board
        #a1,                # group
        #a2,                # key
        #a3,                # set

        li a4, 0            # change
        li a5, 0            # iter   
        li a6, 1            # shifter
        not a7, a3          # not_set = ~set


    clear_others(board, group, key, set)
        changed = 0
        notset = ~set (flip all the bits)
        for index = 0; index < 9; index++
            if key & (1<<index) == 0
                board_index = group[index]
                elt = board[board_index]
                new_elt = elt & notset
                if elt != new_elt
                    board[board_index] = new_elt
                    changed = 1
        return changed

    # main loop
    1:  li t0, 9            # iter max
        bge  a5, t0, 2f     # return calculations 
        and t0, a2, a6      # key && shifter
        
        bnez t0, 3f         # if key && shifter == 0: continue, else calculate iteration
        add t1, a1, a5      # group + iter (address saved for later)
        lb t1, 0(t1)        # (group+iter)[0]
        slli t1, t1, 1      # add+lb+slli collectively = 'elt'
        add  t1, t1, a0
        lh   t2, 0(t1)      # element

        and t3, t2, a7      # new_elt = elt && not_set
        beq t3, t2, 3f      # if elt == new_elt, continue, else calculate nextiteration
        sh  t1, t3  
        li a4, 1            # changed = True

    # iteration calculation
    3:  addi a5, a5, 1
        slli a6, a6, 1
        j 1b  # jump to target
        
    # return calculation
    2:  mv a0, a4
        ret


# single_pass(board, group) ->
#   0: nothing change
#   1: something changed
single_pass:
    # count from 1 to 510 inclusive (511 would have all 9 bits set).
        # This will give us every possible bit pattern with between 1 and 8 bits set.
        
        # iterate over those 510 possible key values.
            # try to identify a naked set for each one.

        # For each key:
            # *   Call `count_bits` on the key to see how big the subset is
            # *   Call `gather_set` to gather the candidates present in the pencil marks for those cells
            # *   Call `count_bits` on the set that you gathered to see the combined number of candidate values used by that subset
            # *   If the size of the subset matches the size of the candidate set, you have found a naked set of that size, so:
            # *   call `clear_others` to cross those values off any other cells

    # Track and return if changes occured (clear_others)
    # prelude:
    #     addi    sp, sp, -72
    #     sd      ra, 64(sp)
    #     sd      s7, 56(sp)
    #     sd      s6, 48(sp)
    #     sd      s5, 40(sp)
    #     sd      s4, 32(sp)
    #     sd      s3, 24(sp)
    #     sd      s2, 16(sp)
    #     sd      s1, 8(sp)
    #     sd      s0, 0(sp)

    # # set variables / registers
    #     #a0, board
    #     #a1, group
    #     mv s0, a0           # saved board
    #     mv s1, a1           # saved group
    #     #s2-s11
    #     li s2, 0            # changes
    #     li s3, 0            # iteration
    #     li s4, 510          # max iteration
    #     # saved register, candidate set
    #     # saved register, subset

    # 1:  #main iteration
        
    #     # Call `count_bits` on the key to see how big the subset is
    #         # count_bits(n) -> # of bits set in n (only counting bits 0-9 inclusive)
    #     mv a0, s3           # iteration value 1-510 = key. move to a0 as argument for count_bits
    #     call count_bits
    #     mv subset, a0       # subset is saved for comparing later

    #     # Call `gather_set` to gather the candidates present in the pencil marks for those cells
    #         # gather_set(board, group, key) ->
    #             # set of pencil marks for cells identified by key
    #     mv a0, s0           # put board into a0 to call gather_set
    #     mv a1, s1           # put group into a1 to call gather_set
    #     mv key, subset      # is subset the key passed to gather_set? 

    #     # Call `count_bits` on the set that you gathered to see the combined number of candidate values used by that subset
    #     call count_bits     # use return from gather_set which is already in a0?

    #     # *If: the size of the subset matches the size of the candidate set:
    #     bne subset, a0(candidate set), calculate next iteration?
    #     # Call `clear_others` to cross those values off any other cells
    #         # clear_others(board, group, key, set) ->
    #             # 0: nothing changed
    #             # 1: something changed
    # #
    
    # # postlude
    #     ld      ra, 64(sp)
    #     ld      s7, 56(sp)
    #     ld      s6, 48(sp)
    #     ld      s5, 40(sp)
    #     ld      s4, 32(sp)
    #     ld      s3, 24(sp)
    #     ld      s2, 16(sp)
    #     ld      s1, 8(sp)
    #     ld      s0, 0(sp)
    #     addi    sp, sp, 72

        ret

# naked_sets(board, table) ->
#   0: nothing changed
#   1: something changed
naked_sets:















                ret
