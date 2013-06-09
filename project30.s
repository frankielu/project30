######################
#                    #
# Project Submission #
#                    #
######################

# Linked list structure
# int data 4 bytes
# node next_address 4 bytes

	.data
printIntro:	.asciiz "The linked list contains:\n"
printSorted:	.asciiz "The sorted linked list contains:\n"
printNL:	.asciiz "\n"
printComma:	.asciiz ", "
arrLen:		.word 500
randnums:	.word 3859,-4698,2684,3580,-107,4685,2850,-2449,-850,-1513,-2140,105,2233,-2255,-4245,2723,4385,-4781,1573,2270,3205,2186,-3573,-4601,-3505,2872,3146,4352,-3905,117,-3086,2223,323,-578,-1371,1228,-585,3545,848,-2233,672,1070,-551,2185,540,-2147,3327,-2468,-1561,4438,146,-4290,-3697,2505,-1186,3404,2836,2229,-3906,3931,-2162,4472,-2467,-301,-46,1628,4990,-2767,-4455,741,-2150,-291,-371,2066,-4070,-3566,-4225,3741,-1629,-4965,643,-2242,-3023,1547,-232,3631,988,-3355,-2687,3596,-1731,1559,3179,3211,-1577,-194,1671,-2274,3655,4451,1322,-3859,-3260,-1541,3965,-1357,-125,3344,-1702,1550,4705,2725,45,569,-1192,-4556,1392,-2905,3719,2989,3775,3113,3894,3698,-4001,3399,-4575,-412,1496,1488,-3,-2256,2242,-3827,-3535,-2522,2837,-3307,-2331,-2763,4856,3323,-4800,646,1505,4187,-4171,4142,693,4669,-3651,-811,-3186,-4490,3600,3045,-1797,-4572,-1617,3526,-1744,1903,4634,-2280,-582,1586,2787,-577,1382,3537,3886,1956,-620,-1354,2237,1787,4546,-3845,-2873,-1088,2101,4266,-2527,1995,3105,-2350,-2009,-4175,-1033,3710,-1355,-1208,-3800,-1142,-964,3603,-1383,-2622,-314,-4221,2203,553,-3585,3100,-1399,2588,678,-195,1262,-2534,-4298,-2759,-448,4708,414,4627,-1304,-4573,-4881,4181,-4279,2012,4711,2137,2329,2828,-1125,2214,-166,883,1649,4519,-3457,294,4509,2569,-4022,2888,-2342,2348,3657,2679,3581,3570,1919,4868,-4985,4343,1466,214,-849,1027,4047,-460,3345,855,31,375,2566,-3337,-1989,1146,708,-1239,-3117,-3220,-3083,3817,1964,4139,2201,-407,2692,-1464,-4887,-799,-355,3591,-3423,-67,-3839,1622,-4733,383,-1414,1740,-3761,4154,-1704,4398,1355,-4219,658,4790,-3878,-4422,-3606,3062,-2250,-4841,3799,-2976,602,761,-4849,819,1295,-2700,-3514,-3681,-4707,-131,-4738,4663,3801,849,-2896,-573,3883,4100,1709,-3075,-509,-1499,-4793,-4260,-1290,-36,4875,-2380,2002,1521,-2604,-4867,-2710,4857,-2835,2838,-498,4226,-239,3732,4169,928,3060,4344,4821,4439,-4033,4,-4528,1857,-4866,2834,-2407,-1537,-3042,-1062,3094,-4874,2287,2083,-4503,-116,1170,86,3216,4567,-745,-863,-3680,3670,-2206,-333,3348,4814,1017,357,-2792,1345,577,845,4444,3625,-2703,3840,498,-433,4683,4935,-1569,-3901,-1263,-2236,-4606,-4844,-4603,4516,3663,4297,-2744,-3746,-2926,-2367,-1039,2527,4102,3666,-1473,-4128,-2794,-2807,-8,2366,-1990,-2311,1940,2150,4499,-3286,-2287,1548,-3892,2084,2498,1873,1503,-3804,3171,2108,1088,-2292,3137,-3214,-2851,-4695,996,-2770,3731,1095,1714,1743,2668,2259,3662,-1416,810,4832,-127,-3842,4355,-3812,801,1432,-3109,-570,814,-2559,4568,-2563,3954,2533,-218,922,-1103,293,-4535,3676,1657,1315,-3545,2621,2113,2475,-3247,4964,-3469,3333,-918,-2469,-1246,2429,-4675,3789,-640,-3135,797,-4116,506,1400,-2750,-3174,22,3193,3358,40,1103,-1830,574,1752


	.globl main
	.globl root
	.globl push
	.globl mergeSort
	.globl mergeUp
	.globl splitHalf
	.globl printList
	.globl importList

	.text
############
#   main   #
############

main:

	                    # (your code here)
	la $a0, randnums    # grab array starting memory address 
	
	la $t1, arrLen	    # grab the array length from memory
	lw $a1, 0($t1)
	
	#addi $a1, $zero, 20 # load the first 20 elements for testing
	
	addi $sp, $sp, -4   # shift stack register and push 
	sw $ra, 0($sp)	    # $ra onto it

	jal importList      # import the list from the given array

	addu $s7, $v0, $0   #save linked list head
	
	la $a0, printIntro  # print out preamble to printList
	addiu $v0, $zero, 4
	syscall 

	addu $a0, $s7, $0   # restore $a0 to linked list header
			            # before calling printList

	jal printList

	addu $a0, $s7, $0   # no guarantees printList didn't affect
			            # $a0, so reload from saved point
	jal mergeSort
	
	addu $s7, $v0, $0   #save the new linked list head 
	
	la $a0, printSorted # print out preamble to sorted printList
	addiu $v0, $zero, 4
	syscall 

	addu $a0, $s7, $0   # restore $a0 to linked list header
			            # before calling printList

	jal printList
	
	lw $ra, 0($sp)	    # pop the stack to restore $ra 
	addi $sp, $sp, 4    # increment stack pointer to release memory for reuse
	
	# return to caller
	jr 	$ra


#################
#   root_node   #
#################

root:

	# $a0 holds the value to store
	# $v0 returns the new head of the linked list

	#create single element linked list
	move $t0, $a0     # move data from a0 into t0
	li $a0, 8         # prepare to syscall sbrk with n = 8 bytes
	li $v0, 9         # prepare to syscall sbrk
	syscall
	sw $t0, 0($v0)    # store the value of t0 into the address of v0
	sw $zero, 4($v0)  # the tail of v0 is set to null

	jr $ra            # jump back to importList
	
#################
#   push_node   #
#################

push:

	# $a0 holds the value to store
	# $a1 holds the head of the linked list
	# $v0 holds the new head of the linked list

	move $t0, $a0  # move data from a0 into t0
	li $a0, 8      # prepare to syscall sbrk with n = 8 bytes
	li $v0, 9      # prepare to syscall sbrk
	syscall
	sw $t0, 0($v0) # store the value of t0 into the address of v0 obtained by sbrk
	sw $a1, 4($v0) # store head of old linked list into tail of this one

	jr 	$ra        # jump back to importList


#################
#  Merge_Sort   #
#################

mergeSort:

	# $a0 holds the address of the top of the linked list
	# $v0 holds the header of the sorted merge
	
	# callee procedures (initial)
	addi $sp, $sp, -20       # decrement stack pointer
	sw $s0, 16($sp)          # save head of first list
	sw $s1, 12($sp)          # save head of second list
	sw $ra, 8($sp)           # save return address
	sw $fp, 4($sp)           # save old frame pointer
	addi $fp, $sp, 20        # set frame pointer
	
	move $v0, $a0            # if head / next is null, the addr of the node head will be returned
	beq $a0, $zero, mergeEnd # if head == null, return head
	lw $t0, 4($a0)           # load the tail of the first node
	beq $t0, $zero, mergeEnd # if head -> next == null, return head
	
	jal splitHalf            # gets the list split into two
	move $s1, $v1            # head of second list into s1
	
	jal mergeSort            # recursive call on mergeSort on first list
	move $s0, $v0            # put sorted first list into s0
	move $a0, $s1            # move head of second list into a0
	
	jal mergeSort            # recursive call on mergeSort on second list
	move $a0, $s0            # put sorted first list into a0
	move $a1, $v0            # put sorted second list into a1
	
	jal mergeUp              # mergeUp will return the head of the sorted list as v0
	
mergeEnd:

	# callee procedures (exit)
	lw $s0, 16($sp)          # restore head of first list
	lw $s1, 12($sp)          # restore head of second list
	lw $ra, 8($sp)           # restore return address
	lw $fp 4($sp)            # restore frame pointer
	addiu $sp, $sp, 20       # increment stack pointer
	
	jr $ra                   # return to caller

###################
#     mergeUp     #
###################

mergeUp:
	# $a0 - head address of first sub-list (A)
	# $a1 - head address of second sub-list (B)
	# $v0 - head address of the combined list

	# callee procedures (initial)
	addiu $sp, $sp, -20        # decrement stack pointer
	sw $s0, 16($sp)            # save s0
	sw $s1, 12($sp)            # save s1
	sw $ra, 8($sp)             # save return address
	sw $fp, 4($sp)             # save frame pointer
	addiu $fp, $sp, 20         # set frame pointer

	beq $a0, $zero, returnB    # if head of A is null return B
	beq $a1, $zero, returnA    # if head of B is null return A
	
	# caller procedures (initial) ###### try testing stack pointer with less!
	addiu $sp, $sp, -8        # decrement stack pointer
	sw $a0, 8($sp)             # save head of A
	sw $a1, 4($sp)             # save head of B
	
	lw $s0, 0($a0)             # put data from A into s0
	lw $s1, 0($a1)             # put data from B into s1
	slt $s0, $s1, $s0          # if B is less than A, s0 = 1
	bne $s0, $zero, BlessthanA # branch if B is less than A
	
	# A <= B
	lw $a0, 4($a0)             # get the head of the next node
	                           # a1 is still the same 
	jal mergeUp                # recursively call mergeUp
	
	# caller procedures (exit)
	lw $a0, 8($sp)             # restore head of A
	lw $a1, 4($sp)             # restore head of B
	addiu $sp, $sp, 8          # increment stack pointer
	
	sw $v0, 4($a0)             # store head of sorted list into tail of higher element
	move $v0, $a0              # move head to output
	
	j mergeUpEnd               # move to callee procedures (exit)
	
BlessthanA:
	# B < A
	lw $a1, 4($a1)             # get the head of the next node
	                           # a0 is still the same
	jal mergeUp                # recursively call mergeUp
	
	# caller procedures (exit)
	lw $a0, 8($sp)             # restore head of A
	lw $a1, 4($sp)             # restore head of B
	addiu $sp, $sp, 8         # increment stack pointer
	
	sw $v0, 4($a1)             # store head of sorted list into tail of higher element
	move $v0, $a1              # move head to output
	
mergeUpEnd:
	# callee procedures (exit)
	lw $s0, 16($sp)            # restore s0
	lw $s1, 12($sp)            # restore s1
	lw $ra, 8($sp)             # restore return address
	lw $fp 4($sp)              # restore frame pointer
	addiu $sp, $sp, 20         # increment stack pointer
	
	jr $ra                     # return to caller

returnA:
	move $v0, $a0              # move head of A to output
	j mergeUpEnd               # jump to callee procedures (exit)
	
returnB:
	move $v0, $a1              # move head of B to output
	j mergeUpEnd               # jump to callee procedures (exit)

#############
# splitHalf #
#############

splitHalf:
	# $a0 head address linked list
	# $v0 head address of first sub-list
	# $v1 head address of second sub-list
	
	move $t1, $a0             # copy a0 into t1
	beq $a0, $zero, firstNull # if head is null, stop
	addi $t0, $a0, 4          # 2x counter is t0
	lw $t0, 0($t0)            # load address of node #2 into t0
	beq $t0, $zero, stopSplit #if t0 encounters a null, stop
	addi $t1, $t1, 4          # move 1x counter up one word
	
findMid:	
	addi $t0, $t0, 4          # move 2x counter up one word
	lw $t0, 0($t0)            # load addr into 2x counter
	beq $t0, $zero, stopSplit # if null found, we stop
	addi $t0, $t0, 4          # move 2x counter up one word
	lw $t0, 0($t0)            # load addr into 2x counter
	lw $t1, 0($t1)            # load addr into 1x counter
	addi $t1, $t1, 4          #move 1x counter up one word
	beq $t0, $zero, stopSplit #if t0 encounters a null, stop
	j findMid

stopSplit:
	move $v0, $a0             # head of first list to v0
	lw $v1, 0($t1)            # head of second list to v1
	sw $zero, 0($t1)          # null terminate t1
	jr $ra                    # return to caller
	
firstNull:
	move $v0, $zero           # if head address is null
	move $v1, $zero           # if head address is null
	jr $ra                    # return to caller
	
################
#  print_list  #
################

printList:

	# Prints the data in list from head to tail
	# $a0 contains head address of list

	addu $t0, $a0, $zero 	   # since $a0 is used for syscalls, 
				               # move pointer to temp register

printloop:

	beq $t0, $zero, printDone  # jump out once end of list found
	lw $t1, 4($t0)		       # grab next pointer and store in $t1
	lw $a0, 0($t0)		       # grab value at present node
	addiu $v0, $zero, 1	       # prepare to print integer
	syscall
	
	la $a0, printComma	       # load comma and print string
	addiu $v0, $zero, 4
	syscall
	
	addu $t0, $t1, $zero	   # move next pointer into $t0 for next loop
	j printloop

printDone:
	la $a0, printNL		       # load newling character and print
	addiu $v0, $zero, 4
	syscall

	# return to caller
	jr 	$ra

#################
#  import_list  #
#################

importList:

	# $a0 holds array address
	# $a1 holds array length
	# $v0 returns header to linked list
	
	#callee procedures (initial)
	addiu $sp, $sp, -12        # decrement the stack pointer
	sw $ra, 8($sp)             # save return address
	sw $fp, 4($sp)             # save old frame pointer
	addiu $fp, $sp, 12         # set frame pointer

	beq $a0, $zero, null       # return 0 if address is null
	beq $a1, $zero, null       # return 0 if arrayLength is null
	
	lw $t0, ($a0)              # load first element in array
	
	#caller procedures (initial)
	addiu $sp, $sp, -16        # decrement the stack pointer
	sw $a0, 12($sp)            # save a0
	sw $a1, 8($sp)             # save a1
	sw $t0, 4($sp)             # save t0
	move $a0, $t0              # move current array data into a0

	jal root                   # jump to root procedure

	#caller procedures (exit)
	lw $a0, 12($sp)            # restore a0
	lw $a1, 8($sp)             # restore a1
	lw $t0, 4($sp)             # restore t0
	addiu $sp, $sp, 16         # increment stack pointer
	
	j y                        # jump to y
	
beginImport: 
	beq $a1, $zero, stopImport # stop once arrayLength decrements to 0
	lw $t0, 0($a0)             # load the data from a0 to t0

	#caller procedures (initial)
	addiu $sp, $sp, -16        # decrement the stack pointer
	sw $a0, 12($sp)            # save a0
	sw $a1, 8($sp)             # save a1
	sw $t0, 4($sp)             # save t0
	
	move $a0, $t0              # move current array data into a0
	move $a1, $v0              # move head of linked list to a1

	jal push                   # jump to push procedure

	#caller procedures (exit)
	lw $a0, 12($sp)            # restore a0
	lw $a1, 8($sp)             # restore a1
	lw $t0, 4($sp)             # restore t0
	addiu $sp, $sp, 16         # increment stack pointer

y:
	addi $a1, $a1, -1          # decrement arrayLength by 1
	addi $a0, $a0, 4           # increment address by 4

	j beginImport              # proceed with the next data segment

null:
	add $v0, $zero, $zero      # set to 0 if a0 = null or a1 = 0

stopImport:

	#callee procedures (exit)
	lw $ra, 8($sp)             # restore return address
	lw $fp, 4($sp)             # restore frame pointer
	addiu $sp, $sp, 12         # increment stack pointer
	jr $ra                     # jump back to main
	
