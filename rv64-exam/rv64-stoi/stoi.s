                .global stoi
                .text
stoi:
                # your code goes here


    1: 		ld a2, 0(a0)  
    		li a3, 48      # ASCII '0'
    		li t0, 57      # ASCII '9'
   	 
    		#beq a2,...
    		blt a2, a3, 4f
	
    2:		bge a2, t0, 4f
		li t1, 10
    		mul a1, a0, t1  # Multiply n by 10
    		add a1, a1, a2  # Add the digit to n
    		ld a2, 1(a0)  # Move to the next character
    		#j 1b
    
    4:		#mv a0 ...
	ret

