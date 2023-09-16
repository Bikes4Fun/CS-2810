                .global am_or_fm
                .text
am_or_fm:
    li t0, 1605 	# t0 = hard max
    ble a0, t0, 2f  # if a0 is <= 1605, branch for other tests. otherwise return a0 with 0(False)
    li a0, 0		# load a value to indicate too large into a0 and return
    ret
2:  li t0, 535		# a0 was less than AM max, now we check AM min. 
    blt a0, t0, 3f 	# if a0 is less than AM-min, branch to check FM. otherwise it is now min < a0 > max
    li a0, 1		# assign a0 our new return value: representing its FM truth
    ret 
3:  li t0, 108		# load FM max to check if in range of FM. 
    ble a0, t0, 4f	# branch to 4 if a0 is not less than FM max - continue, else, branch to check FM min.
    li a0, 0		# since a0 was not less than or equal to FM max, then it is above range.
    ret 	        # a0 was greater than FM max, so it's been assigned 0 and returned.
4:  li t0, 88		# a0 was less than or equal to FM max, so it will be evalutated to FM min
    blt a0, t0, 5f  # if a0 less than FM min, branch to 5. 
    li a0, 2        # a0 was >= than or equal to FM min. and it was <= FM max - so return 2.
    ret
5:  li a0, 0
    ret
