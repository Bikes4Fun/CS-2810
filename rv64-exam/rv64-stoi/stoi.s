                .global stoi
                .text
stoi:
                # your code goes here

    		li a1, 0     # 

    1: 		ld a2, 0(a0)  
    		li a3, 48      # ASCII '0'
    		li t0, 57      # ASCII '9'
   	 
    		beq a2, 45, 3f
    		blt a2, a3, 4f
	
    2:		bge a2, t0, 4f
    		mul a0, a0, 10  # Multiply n by 10
    		add a0, a0, a2  # Add the digit to n
    		addi a0, a0, 1  # Move to the next character
    		j 1b
    
   3:
    		addi a0, a0, 1
    li a1, 1  # Set a1 to 1 to indicate a negative number
    j 1b
    
   4: 
    beqz a1, 3f  # If it's not a negative number, skip the negation
    neg a0, a0  # Negate the result
    
    ret

