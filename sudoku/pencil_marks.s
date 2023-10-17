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
    # used = 0
    # for group_index = 0; group_index < 9; group_index++
    #     board_index = group[group_index]  #iterate through groups. board_index = group 0, 1, 2 ...
    #     element = board[board_index]      #iterate through boards? elem = board 0, 1, 2, etc           

    #     # note: looking up an element (the two lines above)
    #     # is really a 5-step process detailed here:
    #     group_element_address = group + group_index
    #     board_index = lb (group_element_address)
    #     scaled_board_index = board_index << 1
    #     board_element_address = board + scaled_board_index
    #     element = lh (board_element_address)

    #     # count the number of set bits in the element
    #     count = count_bits(element)

    #     if count == 1 (indicating a solved square):
    #         used = used | element

    # return used
                ret

# clear_used(board, group, used)
clear_used:
                ret

# pencil_marks(board, table)
pencil_marks:
                ret
