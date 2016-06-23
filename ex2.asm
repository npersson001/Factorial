.data 0x0
	newline:	.asciiz "\n"
	LEN:		.word 22
	terminator:	.asciiz "\0"
	string: 	.space 22

.text 0x3000
.globl main

main:
	ori     $sp, $0, 0x2ffc     # Initialize stack pointer to the top word below 
	addi    $fp, $sp, -4        # Set $fp to the start of main's stack frame

Loop:
	la $a0, string		#set string location in memeory
	addiu $a1, $0, 22	#set max length
	addiu $v0, $0, 8	#take in string
	syscall
	
	jal a_to_i		#call procedure ($a0 should be argument passed)
	addu $a0, $0, $v0	#set argument as the return from a to i
	jal factorial		#call procedure factorial
	
	addu $a0, $0, $v0	#print number
	ori $v0, $0, 1
	syscall
	
	la $a0, newline		#print newLine
	ori $v0, $0, 4
	syscall
	
	beq $t0, $0, exit_from_main	#if loop = false exit
	beq $0, $0, Loop		#loop back up if loop was true
	
a_to_i:
	addiu $t0, $0, 0	#set number as 0
	la $t1, string		#use $t1 for string pointer
	ori $t4, $0, 10
	
Loop2:
	lbu $t2, 0($t1)		#get wanted character from the array of char
	beq $t2, $t4, a_to_i_exit	#exit procedure if character is the null terminator
	subiu $t2, $t2, 48	#sub 48 from our char
	
	addiu $t3, $0, 10	#get int 10 to use in mult
	multu $t0, $t3		#multiply number by 10
	mflo $t0		#set value mult back in number
	
	addu $t0, $t0, $t2	#add char value and number value * ten
	
	addiu $v0, $t0, 0	#put number into return variable
	addiu $t1, $t1, 1	#increase the char being looked at
	beq $0, $0, Loop2	#loop back to Loop2
	
a_to_i_exit: 
	jr $ra			#return to the main method
	
factorial:
	addi $sp, $sp, -8	#make space on stack
	sw $s0, 0($sp)		#create the variable we will be using recursively
	sw $ra, 4($sp)		#save address back home
	
	ori $s0, $a0, 0		#set $s0 as the variable
	addiu $v0, $0, 1	#set $v0 as 1
	slti $t5, $s0, 1
	beq $t5, $v0, end_factorial	#check if recursion is over
	addi $a0, $s0, -1	#factorial minus 1
	jal factorial			#call factorial again with the n-1 argument in $a0
	mult $v0, $s0		#multiply n and n-1 recursively
	mflo $v0		#return value
	j exit_factorial 	#return overall value
	
end_factorial:
	ori $v0, $0, 1		#return 1
	
exit_factorial:
	lw $ra, 4($sp)		#reset $ra
	lw $s0, 0($sp)		#reset $s0
	addi $sp, $sp, 8	#reset stack
	jr $ra			#return

exit_from_main:
ori     $v0, $0, 10     # System call code 10 for exit
syscall                 # Exit the program
end_of_main:
