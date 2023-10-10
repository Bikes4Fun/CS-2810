                .global count_jumps
                .text

# int count_jumps(int *array, int size)
count_jumps:
    	#   array   = a0
    	#   size    = a1
   	#   count   = a2 = 0
   	#   t0 = 1
    	#   index   = a3 = size - t0              
	#   max     = a4 = index starting val
			
		li a2, 0              
	   	li t0, 1                             
	   	sub a3, a1, t0 
		addi a4, a3, 0      
	2:   	bltz a3, 1f       #if a3(index) < 0: break
	   	blt a4, a3, 1f    #if a4(max) < a3(index) break 
	   	sll t0, a0, a3      #t0 = address of a0 shifted index amount?
           	ld t0, 0(t0)        #t0 = value at t0 
	   	add a3, a3, t0      #a3 = index + t0 (current value at array[index])
	   	addi a2, a2, 1
		j 2b
	1:	mv a0, a2                
	ret
