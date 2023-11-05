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
        li      a6, 0        # shifted index times

    1:  bgt     a4, a5, 2f
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
                ret

# single_pass(board, group) ->
#   0: nothing change
#   1: something changed
single_pass:
                ret

# naked_sets(board, table) ->
#   0: nothing changed
#   1: something changed
naked_sets:
                ret
