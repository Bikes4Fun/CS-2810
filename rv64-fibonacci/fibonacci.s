        		.global fibonacci
        		.text

fibonacci:
	# write your code here
	# n = a0
	# num1 = a1
	# num2 = a2 
	# i = a3
	# num1 + num2 = t0
	li a1, 1	# 
	li a2, 1 
	li a3, 2
	li t0, 0
1:  add t0, a1, a2	# num1 + num2 = num3
	mv a1, a2 	# override num1 with num2
	mv a2, t0	# override num2 with num3 
	addi a3, a3, 1	# i += 1
	blt a3, a0, 1b	# while i < n, return to num3 = num1+num2 
	mv a0, a2 
ret
