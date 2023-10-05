                .global pencil_marks, get_used, clear_used, count_bits
                .text

# count_bits(n) -> # of bits set in n (only counting bits 0-9 inclusive)
count_bits:
        li t0, 0        # val to AND with bit 
        li t1, 0        # store incrementer, store current, store bool(n[0] AND 0)
        li a1, 0        # bits total
        li a2, 0        # i
        li a3, 9        # range max inclusive

    1:  bgt a2, a3, 2f  # if i > range max, branch to exit sequence, else continue with 'while'
        sll t1, a0, a2  # t1 = address of a[i]
        ld  t1, 0(t1)   # t1 = value at a0[i], which is stored in t1  

                ret

# get_used(board, group) -> used
get_used:
                ret

# clear_used(board, group, used)
clear_used:
                ret

# pencil_marks(board, table)
pencil_marks:
                ret
