                .global _start
                .equ    sys_exit, 93

                .data
intro_msg:      .asciz  "\nTesting pencil_marks with the following board:\n\n"
return_msg:     .asciz  "\nThe return value is "
new_board_msg:  .asciz "After pencil_marks returned the board is now:\n\n"
newline:        .asciz  "\n"

                .text
_start:
				.option	push
				.option norelax
				la		gp, __global_pointer$
				.option pop

                # s0: board
                # s1: table
                # s2: return value

                # reserve stack space for a board
                # 81*2 = 162 so reserve 176
                addi    sp, sp, -176
                mv      s0, sp

                # reserve stack space for the table
                # 27*9 = 243 so reserve 256
                addi    sp, sp, -256
                mv      s1, sp

                # read a board from stdin
1:              mv      a0, s0
                call    read_board
                bnez    a0, 1b

                # generate the lookup table
                mv      a0, s1
                call    make_group_table

                # print the initial board
                la      a0, intro_msg
                call    puts
                mv      a0, s0
                call    print_board

                # call pencil_marks
2:              mv      a0, s0
                mv      a1, s1
                la      a4, pencil_marks
                call    call_function
                mv      s2, a0
                la      a0, return_msg
                call    puts
                mv      a0, s2
                call    print_n
                la      a0, newline
                call    puts

                # print the updated board
                la      a0, new_board_msg
                call    puts
                mv      a0, s0
                call    print_board
                bnez    s2, 2b

                # clean up stack
                addi    sp, sp, 256
                addi    sp, sp, 176

                # exit
                li      a0, 0
                li      a7, sys_exit
                ecall
