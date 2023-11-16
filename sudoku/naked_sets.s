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
    # clear_others(board, group, key, set)
        # changed = 0
        # notset = ~set (flip all the bits)
        # for index = 0; index < 9; index++
        #     #if key & (1<<index) == 0
        #         board_index = group[index]
        #         elt = board[board_index]
        #         new_elt = elt & notset
        #         #if elt != new_elt
        #             board[board_index] = new_elt
        #             changed = 1
    # return changed

    #a0,                # board
        #a1,                # group
        #a2,                # key
        #a3,                # set

        li      a4, 0            # change
        li      a5, 0            # iter
        li      a6, 1            # shifter
        not     a7, a3          # not_set = ~set

    # main loop
    1:  li      t0, 9            # iter max
        bge     a5, t0, 2f     # return calculations
        and     t0, a2, a6      # key && shifter

        bnez    t0, 3f         # if key && shifter == 0: continue, else calculate iteration
        add     t1, a1, a5      # group + iter (address saved for later)
        lb      t1, 0(t1)        # (group+iter)[0]
        slli    t1, t1, 1      # add+lb+slli collectively = 'elt'
        add     t1, t1, a0
        lh      t2, 0(t1)      # element

        and     t3, t2, a7      # new_elt = elt && not_set
        beq     t3, t2, 3f      # if elt == new_elt, continue, else calculate nextiteration
        sh      t3, (t1)
        li      a4, 1            # changed = True

    # iteration calculation
    3:  addi    a5, a5, 1
        slli    a6, a6, 1
        j 1b    # jump to target

    # return calculation
    2:  mv      a0, a4
        ret


# single_pass(board, group) -> 0: nothing change 1: something changed
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
        #a1     group
        mv      s0, a0          # saved board
        mv      s1, a1          # saved group
        li      s2, 0           # iteration(key)?
        #mv     s3, a0          # bits from key: return of first count_bits(key) call
        #don't need. nvm this is subset? mv s4, a0  # gathered set, return of gather_set(board, group, key) call
        li      s5, 0           # changes
        #mv     s6, a0          # second call to count_bits? this is candidate set?
        li      s7, 510         # max iteration

    1:  #main   iteration       0-510 inclusive
        bgt     s2, s7, 3f  
        
    #   call    count_bits:     on the key to see how big the subset is #of bits set in n (only counting bits 0-9 inclusive)
        mv      a0, s2          # iteration value 1-510 = key. move to a0 as argument for count_bits
        call    count_bits
        mv      s3, a0          # subset is saved for comparing later

    #   call    gather_set:     gather candidates in the pencil marks for those cells set of pencil marks for cells identified by key
        mv      a0, s0          # board into a0 to call gather_set
        mv      a1, s1          # group into a1 to call gather_set
        mv      a2, s2          # key(iteration?) passed to gather_set? or subset?
        call    gather_set
        mv      s4, a0          #shouldn't need to save this?(possibly the error)
        
    #   call    count_bits:     on gathered to see the combined number of candidate values used by that subset
        call    count_bits      # use return from gather_set which is already in a0?
        mv      s6, a0          # candidate = count_bits second time with gather_set return, obtaining 'candidate'
       
    #   If      sets match:     continue, else: break
        bne     s3, s6, 2f      #calculate next iteration?
        
    #   call    clear_others:   cross values off cells: 0(no change) 1(changed)
        mv      a0, s0          # should be board
        mv      a1, s1          # should be group
        mv      a2, s3          # s2 should be key/iter? (changed to counted bits of iter)
        mv      a3, s4          # s3 should be subset/current set? nvm s3 was bits in the key, s4 is subset?
        call    clear_others
        beqz    a0, 2f          # if 0(no change) perform iteration
        li      s5, 1

    2:  #iter   calculations
        addi    s2, s2, 1
        j       1b
    
    3:  mv      a0, s5          # if changes from clear others

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

# naked_sets(board, table) -> 0: no change, 1: changed
naked_sets:















                ret
