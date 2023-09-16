                .global am_or_fm
                .text
am_or_fm:
    li t0, 1605 	# t0 = hard max
    blt a0, t0, 2f      # if less than, branch for other tests. otherwise return a0 with 0(False)
    li a0, 0		# load a value to indicate too large into a0 and return
    ret
2:  li t0, 535		# a0 must be less than hard ceiling. if it's also less than FM-min, evaluate for AM
    blt a0, t0, 3f 	# if a0 is less than FM-min, branch to check AM. otherwise it is now min < a0 > max
    li a0, 1		# assign a0 our new return value: representing its FM truth
    ret 
3:  li t0, 88		# determine if a0 is less than floor. If not, continue to check AM-max. 
    blt a0, t0, 4f	# branch to 4 if a0 less than AM min
    li t0, 535		#
    blt a0, t0, 5f	# a0 was less than AM max, and was not less than AM min - send to 5 to return AM truthy val
4:  li a0, 0		# a0 was less than floor. so return a value indicating such.
    ret
5:  li a0, 2
    ret
