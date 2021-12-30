############################################################################
# 
#                       EC413
#
#    		Assembly Language Lab -- Programming with Loops.
#
############################################################################
#  DATA
############################################################################
        .data           # Data segment
Hello:  .asciiz " \n Hello Ande! \n"  # declare a zero terminated string
AnInt:	.word	17      # a word initialized to 17
space:	.asciiz	" "	    # declare a zero terminate string
AnotherInt: .word 23	# another word, this time initialized to 23
WordAvg:   .word 0		# use this variable for part 4
ValidInt:  .word 0		#
ValidInt2: .word 0		#
lf:     .byte	10, 0	# string with carriage return and line feed
InLenW:	.word   4       # initialize to number of words in input1 and input2
InLenB:	.word   16      # initialize to number of bytes in input1 and input2
        .align  4       # pad to next 16 byte boundary (address % 16 == 0)
Input1_TAG: .ascii "Input1 starts on next line"
		.align	4
Input1:	.word	0x01020304,0x05060708	# 1 2  3  4  5  6  7  8
	    .word	0x090A0B0C,0x0D0E0F10	# 9 10 11 12 13 14 15 16
        .align  4
Input2_TAG: .ascii "Input2 starts on next line"
        .align  4
Input2: .word   0x01221117,0x090b1d1f   # input
        .word   0x0e1c2a08,0x06040210
        .align  4
Copy_TAG: .ascii "Copy starts on next line"
        .align  4
Copy:  	.space  128		# space to copy input word by word
        .align  4
Input3_TAG: .ascii "Input3 starts on next line"
        .align  4
Input3:	.space	400		# space for data to be transposed
Transpose_TAG: .ascii "Transpose starts on next line"
        .align  4
Transpose: .space 400	# space for transposed data
 
############################################################################
#  CODE
############################################################################
        .text                   # code segment
#
# print out greeting.  
# Task 2:  change the message so that it prints out your name.
main:
        la	$a0,Hello		# address of string to print
        li	$v0,4			# system call code for print_str
        syscall				# print the string
# Output:  Hello Ande!

#
# Print the integer value of AnInt
# Task 3: modify the code so that it prints out two integers
# separated by a space.
		lw	$a0,AnInt		# load I/O register with value of AnInt
		li	$v0,1			# system call code for print_int
		syscall				# print the integer
		la	$a0,space		# load I/O register with address of space
		li	$v0,4			# system call code for print_string
		syscall				# print the string
		lw	$a0,AnotherInt	# load I/O register with value of AnotherInt
		li	$v0,1			# system call code for print_int
		syscall				# print the second integer
		la	$a0, lf			# print new line
		li	$v0,4
		syscall
# Output: 17 23

#
# Print the integer values of each byte in the array Input1
# Task 4a: modify the code so that it prints spaces between the integers
		la	$s0,Input1		# load pointer to array Input1
		lw	$s1,InLenB		# get length of array Input1 in bytes = 16
task4:	
		ble	$s1,$zero,done4	# test if done
		lb	$a0,($s0)		# load next byte into I/O register
		li	$v0,1			# specify print integer
		syscall				# print the integer
		la	$a0,space		# load I/O register with address of space
		li	$v0,4			# system call code for print_string
		syscall				# print the string
		add	$s0,$s0,1		# point to next byte
		sub	$s1,$s1,1		# decrement index variable
		j	task4			# do it again
done4:
		la	$a0, lf			# print new line
		li	$v0,4
		syscall
# Output:  4 3 2 1 8 7 6 5 12 11 10 9 16 15 14 13

#
# Task 4b: copy the Task 4 code and paste here.  Modify the code to print
# the array backwards.
	la	$s0,Input1			# load pointer to array Input1
	lw	$s1,InLenB			# get length of array Input1 in bytes = 16
	sub	$s2,$s1,1			# get index of last element of array
	add $s0,$s0,$s2			# set pointer to last element of array
task4a:
	ble	$s1,$zero,done4a	# test if done
	lb	$a0,($s0)			# load next byte into I/O register
	li	$v0,1				# specify print integer
	syscall					# print the integer
	la	$a0,space			# load I/O register with address of space
	li	$v0,4				# system call code for print_string
	syscall					# print the string
	sub	$s0,$s0,1			# point to previous byte
	sub	$s1,$s1,1			# decrement index variable
	j	task4a				# do it again
done4a:
	la	$a0, lf				# print new line
	li	$v0,4
	syscall
# Output: 13 14 15 16 9 10 11 12 5 6 7 8 1 2 3 4

#
# Code for Task 5 -- copy the contents of Input2 to Copy
		la	$s0,Input2		# load pointer to array Input2
		la	$s1,Copy		# load pointer to array Copy
		lw	$s2,InLenB		# get length of array Input2 in bytes
task5:
		ble	$s2,$zero,done5	# test if done
		lb	$t0,($s0)		# get the next byte
		sb	$t0,($s1)		# put the byte
		add	$s0,$s0,1		# increment input pointer
		add	$s1,$s1,1		# increment output point
		sub	$s2,$s2,1		# decrement index variable
		j	task5			# continue
done5:
#
# Task 5:  copy the Task 5 code and paste here.  Modify the code to copy
# the data in words rather than bytes.
	la	$s0,Input2			# load pointer to array Input2
	la	$s1,Copy			# load pointer to array Copy
	lw	$s2,InLenB			# get length of array Input2 in bytes
task5b:
	ble	$s2,$zero,done5b	# test if done
	lw	$t0,($s0)			# get the next word
	sw	$t0,($s1)			# put the word
	add	$s0,$s0,4			# increment input pointer
	add	$s1,$s1,4			# increment output point
	sub	$s2,$s2,1			# decrement index variable
	j	task5b				# continue
done5b:

#
# Code for Task 6 -- 
# Print the integer average of the contents of array Input2 (bytes)
	la	$s0,Input2			# load pointer to array Input2
	lw	$s1,InLenB			# get length of array Input2 in bytes
	lw	$s2,InLenB			# get length of array Input2 in bytes (loop counter)
	lw	$s3,WordAvg			# get variable for average of words
task6:
	ble	$s2,$zero,done6		# test if done	
	lb	$t1,($s0)			# get the next byte
	add	$s3, $s3, $t1		# sum elements of Input2
	add	$s0,$s0,1			# increment input pointer
	sub	$s2,$s2,1			# decrement index variable
	j	task6				# continue
done6:
	div $s3,$s1				# divide sum of elements by number of elements
	mflo $t2				# move contents of lo to $t2
	la	$a0,($t2)			# load quotient from division
	li	$v0,1				# specify print integer
	syscall					# print the integer
	la	$a0, lf				# print new line
	li	$v0,4
	syscall
# Output:  17

#
# Code for Task 7 --  
# Print the integers 0 - 24 that are divisible by 7 (with spaces)

	li		$s0, 0				# load 25 into $s0
	li  	$s1, 7				# load the divisor 7 into $s1
task7:
	beq		$s0, 25, done7	# if $s0 == 0 then branch to done7
divide:	
	div		$s0, $s1			# $s0 / st1
	mfhi	$t1					# $t1 = remainder of $s0/$s1
	bne		$t1, $zero, donedivide	# if $t0 != 0 then target
	la		$a0,($s0)			# load quotient from division
	li		$v0,1				# specify print integer
	syscall						# print the integer
	la		$a0,space			# load I/O register with address of space
	li		$v0,4				# system call code for print_string
	syscall					# print the string
donedivide:
	add		$s0, $s0, 1,		# $s0 = $s0 - 1	
	j		task7				# jump to task7
done7:
	la	$a0, lf				# print new line
	li	$v0,4
	syscall
# Output: 21 14 7

#
# The following code initializes Input3 for Task8
		la	$s0,Input3		# load pointer to Input3
		li	$s1,100			# load size of array in bytes
		li	$t0,3			# start with 3
init8a:
		ble	$s1,$zero,done8a	# test if done
		sb	$t0,($s0)		# write out another byte
		add	$s0,$s0,1		# point to next byte
		sub	$s1,$s1,1		# decrement index variable
		add	$t0,$t0,1		# increase value by 1
		j 	init8a			# continue
done8a:
#
# Code for Task 8 --
# Transpose the 10x10 byte array in Input3 into Transpose
		la	$s0,Input3				# get pointer to Input3
		la  $s1,Transpose			# get pointer to Transpose
		li	$s2,0					# initialize first loop counter
outerloop:		
		beq $s2,10, outerloopend	# check if outer loop is done
		li  $s3,10					# initialize second loop counter
innerloop:		
		ble $s3,$zero, innerloopend	# check if inner loop is done
		lb	$t0,($s0)				# get the nth byte of Input3
		sb	$t0,($s1)				# store that byte to Tranpose
		add	$s0,$s0,1				# increment input pointer
		add	$s1,$s1,10				# increment output point
		sub $s3,$s3,1				# decrement inner loop counter
		j	innerloop				# return to top of inner loop
innerloopend:
		la	$s1,Transpose			# reset pointer to Transpose
		add $s2,$s2,1				# increment outer loop counter
		add $s1,$s1,$s2				# move pointer of Transpose to the second column		
		j   outerloop
outerloopend:		

# ALL DONE!
Exit:
jr $ra