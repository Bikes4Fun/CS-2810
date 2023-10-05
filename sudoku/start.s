                .global _start
                .equ    sys_exit, 93

                .data
pre_msg:        .asciz  "Calling count_bits with input: "
post_msg:       .asciz  "Return value is: "
newline:        .asciz  "\n"
the_set_msg_1:  .asciz  " (the set "
the_set_msg_2:  .asciz  ")\n"

                .text
_start:
				.option	push
				.option norelax
				la		gp, __global_pointer$
				.option pop

                # s0: i
                # s1: count

                # for i from [0, 1100) step 41
                li      s0, 0

1:              la      a0, pre_msg
                call    puts
                mv      a0, s0
                call    print_n
                la      a0, the_set_msg_1
                call    puts
                mv      a0, s0
                call    print_set
                la      a0, the_set_msg_2
                call    puts

                # call count_bits
                mv      a0, s0
                la      a4, count_bits
                call    call_function
                mv      s1, a0

                la      a0, post_msg
                call    puts
                mv      a0, s1
                call    print_n
                la      a0, newline
                call    puts

                # next i
                addi    s0, s0, 37
                li      t0, 1100
                blt     s0, t0, 1b

                li      a0, 0
                li      a7, sys_exit
                ecall
