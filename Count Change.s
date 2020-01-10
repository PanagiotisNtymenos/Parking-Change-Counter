# Author:Panagiotis Ntymenos
# Date:12/11/2017
# Description:
#	t0=euros
#	t1=cents
# 	t3=money in cents
#	t4,t5=temporary,for multiply,divide and add purposes

.data
	Start: .asciiz "-- Parking Ticket Payment -- \n"
	NewLine: .asciiz " \n"
	printfee: .asciiz "Fee: 5 euros and 24 cents \n"
	readeuros: .asciiz "Euros (<= 20): "
	readcents: .asciiz "Cents (< 100): "
	Error: .asciiz "Error, Please try again..! \n"
	Change: .asciiz "Change: "
	ChError: .asciiz "Error, Not enough money..! \n "
	ChEqual: .asciiz "Change: 0 \n "
	ChangeG: .asciiz "Change:  "	
	e10:.asciiz " x 10 euros\n"
	e5:.asciiz " x 5 euros\n"
	e2:.asciiz " x 2 euros\n"
	e1:.asciiz " x 1 euro\n"
	c50:.asciiz " x 50 cents\n"
	c20:.asciiz " x 20 cents\n"
	c10:.asciiz " x 10 cents\n"
	c5:.asciiz " x 5 cents\n"
	c2:.asciiz " x 2 cents\n"
	c1:.asciiz " x 1 cent\n"
.text

main:

	#Print Start
	li $v0 , 4
	la $a0 , Start
	syscall
	
	
	#Print the Fee
	li $v0 , 4
	la $a0 , printfee
	syscall

	#Display readeuros
	li $v0 , 4
	la $a0 , readeuros
	syscall 	
		
	#Read Euros
	li $v0, 5
	syscall		
			
	#Store Euros in t0
	move $t0,$v0

	#Display readcents
	li $v0 , 4 
	la $a0 , readcents
	syscall	

	#Read Cents
	li $v0, 5
	syscall
	
	#Store Cents in t1
	move $t1,$v0
	
	#Check if Euros are less than 20	
	bgt $t0, 20, exit
		
	#Check if Cents are less than 99
	bgt $t1, 99, exit

	
	#Storing Euros and Cents in t3 as Cents!
	#pseudocode:
	#t2=t0*100
	#t3=t2+t1
	mul $t2, $t0, 100    #Converting Euros to Cents
	add $t3, $t2, $t1
	
	#New Line
	li $v0 , 4
	la $a0 , NewLine
	syscall

		
	#COUNT CHANGE!
	blt $t3, 524, ChangeError
	beq $t3, 524, ChangeEqual
	bgt $t3, 524, ChangeToGive			
																																								
											
	#END OF THE PROGRAM!!!!
	li $v0, 10
	syscall
	
	#Functions
	
	ChangeError:
		#New Line
		li $v0 , 4
		la $a0 , NewLine
		syscall
	
		li $v0 , 4
		la $a0 , ChError
		syscall
		#END OF THE PROGRAM!!!!
		li $v0, 10
		syscall
	ChangeEqual:
		#New Line
		li $v0 , 4
		la $a0 , NewLine
		syscall
		
		li $v0 , 4
		la $a0 , ChEqual
		syscall
		#END OF THE PROGRAM!!!!
		li $v0, 10
		syscall
	ChangeToGive:
		#New Line
		li $v0 , 4
		la $a0 , NewLine
		syscall 
	
		#Display Change Message
		li $v0 , 4
		la $a0 , ChangeG
		syscall
		
		#New Line
		li $v0 , 4
		la $a0 , NewLine
		syscall	
		sub $t3, $t3, 524
		
	# t4 = t4 / 100
	#	if(t4 == 0){
	#		break
	#	}
	#t5 = t4 * 1000
	#t3 = t3 - t5
	#print result		
		#10 euros		
		div $t4, $t3, 1000
	beq $t4, 0, exit1000			
		mul $t5, $t4, 1000
		sub $t3, $t3, $t5
		#Display Number of euro Coins/Paper
		li $v0, 1
		move $a0, $t4
		syscall
		li $v0 , 4 
		la $a0 , e10
		syscall
	exit1000:						
		#5 euros
		div $t4, $t3, 500
	beq $t4, 0, exit500
		mul $t5, $t4, 500
		sub $t3, $t3, $t5
		#Display Number of euro Coins/Paper
		li $v0, 1
		move $a0, $t4
		syscall	
		li $v0 , 4 
		la $a0 , e5
		syscall	
	exit500:	
		#2 euros
		div $t4, $t3, 200
	beq $t4, 0, exit200	
		mul $t5, $t4, 200
		sub $t3, $t3, $t5
		#Display Number of euro Coins/Paper
		li $v0, 1
		move $a0, $t4
		syscall
		li $v0 , 4 
		la $a0 , e2
		syscall
	exit200:	
		#1 euro
		div $t4, $t3, 100
	beq $t4, 0, exit100	
		mul $t5, $t4, 100
		sub $t3, $t3, $t5
		#Display Number of euro Coins/Paper
		li $v0, 1
		move $a0, $t4
		syscall
		li $v0 , 4 
		la $a0 , e1
		syscall
	exit100:	
		#50 cents
		div $t4, $t3, 50
	beq $t4, 0, exit50	
		mul $t5, $t4, 50
		sub $t3, $t3, $t5
		#Display Number of euro Coins/Paper
		li $v0, 1
		move $a0, $t4
		syscall	
		li $v0, 4
		la $a0, c50
		syscall
	exit50:
		#20 cents
		div $t4, $t3, 20
	beq $t4, 0, exit20	
		mul $t5, $t4, 20
		sub $t3, $t3, $t5
		#Display Number of euro Coins/Paper
		li $v0, 1
		move $a0, $t4
		syscall
		li $v0, 4
		la $a0, c20
		syscall
	exit20:	
		#10 cents
		div $t4, $t3, 10
	beq $t4, 0, exit10	
		mul $t5, $t4, 10
		sub $t3, $t3, $t5
		#Display Number of euro Coins/Paper
		li $v0, 1
		move $a0, $t4
		syscall
		li $v0, 4
		la $a0, c10
		syscall
	exit10:
		#5 cents
		div $t4, $t3, 5
	beq $t4, 0, exit5	
		mul $t5, $t4, 5
		sub $t3, $t3, $t5
		#Display Number of euro Coins/Paper
		li $v0, 1
		move $a0, $t4
		syscall
		li $v0, 4
		la $a0, c5
		syscall
	exit5:
		#2 cents
		div $t4, $t3, 2
	beq $t4, 0, exit2	
		mul $t5, $t4, 2
		sub $t3, $t3, $t5
		#Display Number of euro Coins/Paper
		li $v0, 1
		move $a0, $t4
		syscall
		li $v0, 4
		la $a0, c2
		syscall
	exit2:
		#1 cent
		div $t4, $t3, 1
	beq $t4, 0, exit1	
		mul $t5, $t4, 1
		sub $t3, $t3, $t5
		#Display Number of euro Coins/Paper
		li $v0, 1
		move $a0, $t4
		syscall
		li $v0, 4
		la $a0, c1
		syscall
	exit1:
		#END OF THE PROGRAM!!!!
		li $v0, 10
		syscall
exit:		
	ErrorMess:
		#Display Error
		li $v0 , 4 
		la $a0 , Error
		syscall	

		#END OF THE PROGRAM!!!!				
		li $v0, 10
		syscall				
							
								
									
										
												
