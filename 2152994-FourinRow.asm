.data
	welcome: .asciiz "\n\n +------------------------------------------+\n +  Welcome to four in a row - new version  +\n +------------------------------------------+\n\n"
	lineofnum: .asciiz "\n | * | 1 | 2 | 3 | 4 | 5 | 6 | 7 | \n"
	lineofseperate: .asciiz " ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n"
	downline: .asciiz " +---+---+---+---+---+---+---+---+\n"
	downline1: .asciiz "\n +---+---+---+---+---+---+---+---+"
	lash: .asciiz " |"
	space: .asciiz " "
	newline: .asciiz "\n"
	nameplayer1: .space 20
	nameplayer2: .space 20
	enter: .asciiz " Enter your name: "
	enter1: .asciiz " Next, enter your name: "
	player1: .asciiz "\n You are player 1: "
	player2: .asciiz "\n And you are player 2: "
	randomchoose: .asciiz "\n Randomly choose piece (X) or (O) for each player: \n"
	player1X2O: .asciiz "\n PLayer 1 is choosen with (X) and PLayer 2 is choosen with (O).\n"
	player1O2X: .asciiz "\n PLayer 1 is choosen with (O) and PLayer 2 is choosen with (X).\n"
	playerXturn: .asciiz "\n\n Player X turn: "
	playerOturn: .asciiz "\n\n Player O turn: "
	playerturns: .asciiz "\n Your turn decision to undo your current move, enter (0) if no and (1) if yes ^^: "
	playerturnsr: .asciiz "\n Your turn decision to reomve one arbitrary piece of the opponent, enter (0) if no and (1) if yes ^^: "
	enterrowr: .asciiz "\n Enter the row: "
	entercolumnr: .asciiz "\n Enter the column: "
	playerblock: .asciiz "\n Do you want to block your opponent next move? Enter (0) if no and (1) if yes ^^: "
	tryblockagain: .asciiz "\n Please enter (0) or (1) to not block or block your opponent next move !.! : "
	entercolumn: .asciiz "\n\n Enter the column you want to drop into (1-7): "
	invalidenternum: .asciiz "\n\n Your selected column is full or not exist.\n\n Please enter again the column you want: "
	firstmove: .asciiz "\n\n Your first move must be in the center column, please enter the center column again: "
	enterfirstmove: .asciiz "\n\n Your first move must be in the center column, please enter the center column! "
	tryundoagain: .asciiz "\n Please enter (0) or (1) !!!: "
	tryremoveagain: .asciiz "\n Please enter the row in the interval[1,6] and the column in the interval [1,7]: "
	numundoX: .asciiz "\n Player X has "
	undo: .asciiz" undo times !!!\n"
	numundoO: .asciiz "\n Player O has "
	printdraw: .asciiz "\n Unfortunately, the match is drawn, and no one win ^.^"
	startagain: .asciiz "\n Press space button to rematch the game or another button to exit the game: "
	violation: .asciiz "\n Violent remaining is: "
	wrongtomuch: .asciiz "\n\n Wrong over 3 times ^.^"
	printOwin: .asciiz "\n The winner player is: "
	printXwin: .asciiz "\n The winner player is: "
	winner: .asciiz "\n Congratulations to the winner of this match is "
	notblock: .asciiz "\n Your opponent has a chance to win so you can not use the block function!"
	# Global variables
	EachColumn: .word 5, 5, 5, 5, 5, 5, 5
	ROW: .word 6
	COL: .word 7
	BoardArray: .space 42
	Player: .space 1 # Initializing Player, don't need to enter
	array: .word 3,3,1,1,1,1,1,1,0,0,3,3,1,2,3,4,5,6 #undoX,undoO,middleX,midleO,blockX,blockO,removeX,removeO,checkfirstblockX,checkfirstblockO
	array1: .word 3,3,1,1,1,1,1,1,0,0,3,3,1,2,3,4,5,6
##################################################################################################################################################	
.text
Startagain:
# Data reset
	li $t0, 0
Loopre:
	beq $t0, 19, Exitre
	
	sll $t1, $t0, 2
	lw $t2, array1($t1)
	sw $t2, array($t1)
	addi $t0, $t0, 1
	j Loopre
Exitre:

	la $s4, EachColumn 
	li $t0, 0	# i
	li $t1, 5
	
Initial: 
	beq $t0, 7, Initialize
	sw $t1, 0($s4)
	addi $s4, $s4, 4
	addi $t0, $t0, 1
	j Initial
Initialize:
# Set data
   	lw $s1, ROW
   	lw $s2, COL
   	la $s3, BoardArray
   	la $s4, EachColumn
   	lb $s5, Player
   	la $s6, array
 	li $t2, ' '
   	li $t4, 'X'
   	li $t5, 'O'    
# Welcome
	li $v0, 4
	la $a0, welcome
	syscall
# Set ' ' to the array
	li $t0, 0  # i
loopi: 
	beq $t0, 6, exiti # 6 rows
   	li $t1, 0	# j
	loopj:
		beq $t1, $s2, exitj # 7 columns
		
		mul $t6, $t0, 7      # i * col
            	add $t6, $t6, $t1      # i * col + j
            	sb $t2, BoardArray($t6)         # BoardArray[i][j] = ' ' 
		
		addi $t1, $t1, 1
		j loopj
	exitj:
	addi $t0, $t0, 1
	j loopi
exiti:
# Enter name
	li $v0, 4
	la $a0, enter
	syscall
	# Read name
	li $v0, 8
	la $a0, nameplayer1
	li $a1, 40
	syscall
	li $v0, 4
	la $a0, player1
	syscall
	li $v0, 4
	la $a0, nameplayer1
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	li $v0, 4
	la $a0, enter1
	syscall
	# Read name
	li $v0, 8
	la $a0, nameplayer2
	li $a2, 40
	syscall
	li $v0, 4
	la $a0, player2
	syscall
	li $v0, 4
	la $a0, nameplayer2
	syscall
# Random piece
	li $v0, 4
	la $a0, randomchoose
	syscall
	# Sleep 1 seconds
	la $a0, 1000
	li $v0, 32
	syscall
	li $v0, 41 # random int
	syscall
	and $a0, $a0, 1
	beq $a0, $zero, chooseO
	li $v0, 4
	la $a0, player1X2O
	syscall
	j XO
chooseO:
	li $v0, 4
	la $a0, player1O2X
	syscall
# Main part
OX:
	jal printboardarray
OX_1:
	li $v0, 4
	la $a0, playerOturn
	syscall
	
	li $v0, 4
	la $a0, nameplayer1
	syscall
	
	jal RemoveX
	jal Win
	addi $s5, $zero, 'O'
	beq $v0, 1, Exitprogram1
	li $t1, 6
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	beq $a0, $t1, remove1
	
	jal Omove_1
	
	jal Win
	beq $v0, 1, Exitprogram1
	jal Draw
	beq $v0, $zero, Exitprogram1
	jal printboardarray
	
	li $v0, 4
	la $a0, newline
	syscall
	li $v0, 4
	la $a0, space
	syscall
	li $v0, 4
	la $a0, nameplayer1
	syscall

	jal UndoOX
	
	#jal printboardarray
	
	li $t1, 5
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	beq $a0, $t1, blockO2
    	bne $a0, $t1, player2X

blockO2:
	jal BlockO
	
    	li $t1, 5
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	beq $a0, $t1, player2X
    	bne $a0, $t1, player1O
    	
player2X:
	jal Win
	addi $s5, $zero, 'O'
	beq $v0, 1, Exitprogram1
	
	li $v0, 4
	la $a0, playerXturn
	syscall
	
	li $v0, 4
	la $a0, nameplayer2
	syscall
	
	jal RemoveO
	jal Win
	addi $s5, $zero, 'X'
	beq $v0, 1, Exitprogram1
	li $t1, 7
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	beq $a0, $t1, remove2
	
	jal Xmove_1
	
	jal Win
	beq $v0, 1, Exitprogram1
	jal Draw
	beq $v0, $zero, Exitprogram1
	jal printboardarray
	
	li $v0, 4
	la $a0, newline
	syscall
	li $v0, 4
	la $a0, space
	syscall
	li $v0, 4
	la $a0, nameplayer2
	syscall

	jal UndoOX
	
	#jal printboardarray
	
	li $t1, 4
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	beq $a0, $t1, blockX2
    	bne $a0, $t1, player1O

blockX2:
	jal BlockX
	
    	li $t1, 4
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	beq $a0, $t1, player1O
    	bne $a0, $t1, player2X
    	
player1O:
	jal Win
	addi $s5, $zero, 'X'
	beq $v0, 1, Exitprogram1
	
	j OX_1

remove1:
	li $t1, 6
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, 2
	sw $a0, array($t2)	
	j player2X
	
remove2:
	li $t1, 7
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, 2
	sw $a0, array($t2)	
	j player1O
##################################################################################################################################################
XO:
	jal printboardarray
XO_1:	
	li $v0, 4
	la $a0, playerXturn
	syscall
	
	li $v0, 4
	la $a0, nameplayer1
	syscall
	
	jal RemoveO
	jal Win
	addi $s5, $zero, 'X'
	beq $v0, 1, Exitprogram2
	li $t1, 7
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	beq $a0, $t1, player2O
	
	jal Xmove
	
	jal Win
	beq $v0, 1, Exitprogram2
	jal Draw
	beq $v0, $zero, Exitprogram2
	jal printboardarray

	li $v0, 4
	la $a0, newline
	syscall
	li $v0, 4
	la $a0, space
	syscall
	li $v0, 4
	la $a0, nameplayer1
	syscall
	
	jal UndoXO
	
	#jal printboardarray
	
	li $t1, 4
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	beq $a0, $t1, blockX1
    	bne $a0, $t1, player2O

blockX1:
	jal BlockX
	
    	li $t1, 4
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	beq $a0, $t1, player2O
    	bne $a0, $t1, player1X
    	
player2O:
	jal Win
	addi $s5, $zero, 'X'
	beq $v0, 1, Exitprogram2
	
	li $v0, 4
	la $a0, playerOturn
	syscall
	
	li $v0, 4
	la $a0, nameplayer2
	syscall
	
	jal RemoveX
	jal Win
	addi $s5, $zero, 'O'
	beq $v0, 1, Exitprogram2
	li $t1, 6
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	beq $a0, $t1, player1X
	
	jal Omove
	
	jal Win
	beq $v0, 1, Exitprogram2
	jal Draw
	beq $v0, $zero, Exitprogram2
	jal printboardarray

	li $v0, 4
	la $a0, newline
	syscall
	li $v0, 4
	la $a0, space
	syscall
	li $v0, 4
	la $a0, nameplayer2
	syscall

	jal UndoXO
	
	#jal printboardarray
	
	li $t1, 5
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	beq $a0, $t1, blockO1
    	bne $a0, $t1, player1X

blockO1:
	jal BlockO
	
    	li $t1, 5
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	beq $a0, $t1, player1X
    	bne $a0, $t1, player2O
    	
player1X:
	jal Win
	addi $s5, $zero, 'X'
	beq $v0, 1, Exitprogram2
	
	j XO_1

remove3:
	li $t1, 6
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, 2
	sw $a0, array($t2)	
	j player1X
	
remove4:
	li $t1, 7
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, 2
	sw $a0, array($t2)	
	j player2O
	
##################################################################################################################################################	
Exitprogram1:
	jal printboardarray
	jal Draw
	beq $v0, $zero, Printdraw
Printwinner:
	li $v0, 4
	la $a0, winner
	syscall
	
	addi $t0, $zero, 'X'
	beq $t0, $s5, printX1
	
	li $v0, 4
	la $a0, nameplayer1
	syscall
			
	li $v0, 4
	la $a0, startagain
	syscall
	
	li $v0, 12
	syscall
	beq $v0, ' ', Startagain
	
	li $v0, 10
	syscall
	
	printX1:
	
	li $v0, 4
	la $a0, nameplayer2
	syscall
			
	li $v0, 4
	la $a0, startagain
	syscall
	
	li $v0, 12
	syscall
	beq $v0, ' ', Startagain
	
	li $v0, 10
	syscall
Printdraw:
	li $v0, 4
	la $a0, printdraw
	syscall
	
	li $v0, 4
	la $a0, startagain
	syscall
	
	li $v0, 12
	syscall
	beq $v0, ' ', Startagain
	
	li $v0, 10
	syscall

##################################################################################################################################################	
Exitprogram2: #XO
	jal printboardarray
	jal Draw
	beq $v0, $zero, Printdraw2
Printwinner2:
	li $v0, 4
	la $a0, winner
	syscall
	
	addi $t0, $zero, 'X'
	beq $t0, $s5, printX2
	
	li $v0, 4
	la $a0, nameplayer2
	syscall
			
	li $v0, 4
	la $a0, startagain
	syscall
	
	li $v0, 12
	syscall
	beq $v0, ' ', Startagain
	
	li $v0, 10
	syscall
	
	printX2:
	
	li $v0, 4
	la $a0, nameplayer1
	syscall
			
	li $v0, 4
	la $a0, startagain
	syscall
	
	li $v0, 12
	syscall
	beq $v0, ' ', Startagain
	
	li $v0, 10
	syscall
Printdraw2:
	li $v0, 4
	la $a0, printdraw
	syscall
	
	li $v0, 4
	la $a0, startagain
	syscall
	
	li $v0, 12
	syscall
	beq $v0, ' ', Startagain
	
	li $v0, 10
	syscall

##################################################################################################################################################
Xmove:
# Stack
	addi $sp, $sp, -12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t3, 8($sp)

# Handling
	li $t1, 0
	li $v0, 4
	la $a0, numundoX
	syscall
	sll $t1, $t1, 2
	lw $a0, array($t1)
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, undo
	syscall

	li $v0, 4
	la $a0, violation
	syscall
	li $t3, 10
	sll $t3, $t3, 2
	lw $a0, array($t3)
	li $v0, 1
	syscall

	addi $s5, $zero, 'X'
	subi $t0, $s5, 'X'

	li $t1, 2
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	beq $a0, $t1, firstmove1
	bne $a0, $t1, middle1
	
middle:
	li $v0, 12
	syscall
	subi $v0, $v0, '0'
	move $v1, $v0	# assign enternum to $v1
	
	li $t1, 2
	sll $t2, $t1, 2
	lw $a0, array($t2)

	beq $t0, $a0, enterwrongX
	bne $t0, $a0, enterwrongXmidllefirstX
firstmove1:
	li $v0, 4
	la $a0, enterfirstmove
	syscall
	j middle
middle1:	
	li $v0, 4
	la $a0, entercolumn
	syscall
	j middle
	enterwrongXmidllefirstX:		
		sge $t6, $v1, 4        # set greater equal
		add $t1, $t6, $zero
		slti $t6, $v1, 5
		add $t1, $t6, $t1
		
            	addi $t6, $v1, -1      		# enternum-1
            	mul $t6, $t6, 4      		# enternum
            	lw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
            	sge $t0, $t0, 0
            	add $t1, $t1, $t0
            	
            	beq $t1, 3, exitenterwrongX
            	li $t3, 10
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	beq $a0, 0, loseimmediatly
            	addi $a0, $a0, -1
            	sw $a0, array($t3)
            	
            	li $v0, 4
		la $a0, newline
		syscall
            	
            	li $v0, 4
		la $a0, violation
		syscall
		li $t3, 10
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	li $v0, 1
		syscall
		
            	li $v0, 4
		la $a0, firstmove
		syscall
		
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $v1, $v0	# assign enternum to $v1
		
		j enterwrongXmidllefirstX
	
	enterwrongX:
		
		sge $t6, $v1, 1        # set greater equal
		add $t1, $t6, $zero
		slti $t6, $v1, 8
		add $t1, $t6, $t1
		
            	addi $t6, $v1, -1      		# enternum-1
            	mul $t6, $t6, 4      		# enternum
            	lw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
            	sge $t0, $t0, 0
            	add $t1, $t1, $t0
            	
            	beq $t1, 3, exitenterwrongX
            	li $t3, 10
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	beq $a0, 0, loseimmediatly
            	li $t3, 10
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	addi $a0, $a0, -1
            	sw $a0, array($t3)
            	
            	li $v0, 4
		la $a0, newline
		syscall
            	
            	li $v0, 4
		la $a0, violation
		syscall
		li $t3, 10
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	li $v0, 1
		syscall
		
            	li $v0, 4
		la $a0, invalidenternum
		syscall
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $v1, $v0	# assign enternum to $v1
		
		j enterwrongX	
            	
	exitenterwrongX:
	
	addi $t0, $v1, -1      		# enternum-1
	mul $t1, $t0, 4        		# (enternum-1) * 4
    	lw $t1, EachColumn($t1)		# EachColumn[enternum-1] (Base + Offset)
    	mul $t6, $t1, 7      		# EachColumn[enternum-1] * col
        add $t6, $t6, $t0     		# EachColumn[enternum-1] * col + enternum-1
	addi $t0, $zero, 'X'
	sb $t0, BoardArray($t6)        # boardArray[i][j] = 'X' (Base + Offset)
	
	addi $t6, $v1, -1      		# enternum-1
	mul $t6, $t6, 4        		# (enternum-1) * 4
	lw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
	addi $t0, $t0, -1
	sw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
	
# Close stack
exitXmove:
	lw $t3, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 12
	
	jr $ra

##################################################################################################################################################
Omove:
# Stack
	addi $sp, $sp, -12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t3, 8($sp)
# Handling
	li $t1, 1
	li $v0, 4
	la $a0, numundoO
	syscall
	sll $t1, $t1, 2
	lw $a0, array($t1)
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, undo
	syscall
	
	li $v0, 4
	la $a0, violation
	syscall
	li $t3, 11
	sll $t3, $t3, 2
	lw $a0, array($t3)
	li $v0, 1
	syscall

	# Check if firstmove or not
	addi $s5, $zero, 'O'	
	subi $t0,$s5, 'O'

	li $t1, 3
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	beq $a0, $t1, firstmove2
	bne $a0, $t1, middle3
	
middle2:
	li $v0, 12
	syscall
	subi $v0, $v0, '0'
	move $v1, $v0	# assign enternum to $v1

	li $t1, 3
	sll $t2, $t1, 2
	lw $a0, array($t2)

	beq $t0, $a0, enterwrongO
	bne $t0, $a0, enterwrongXmidllefirstO
firstmove2:
	li $v0, 4
	la $a0, enterfirstmove
	syscall
	j middle2
middle3:	
	li $v0, 4
	la $a0, entercolumn
	syscall
	j middle2
	enterwrongXmidllefirstO:
		
		sge $t6, $v1, 4        # set greater equal
		add $t1, $t6, $zero
		slti $t6, $v1, 5
		add $t1, $t6, $t1
		
            	addi $t6, $v1, -1      		# enternum-1
            	mul $t6, $t6, 4      		# enternum
            	lw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
            	sge $t0, $t0, 0
            	add $t1, $t1, $t0
            	
            	beq $t1, 3, exitenterwrongO
            	li $t3, 11
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	beq $a0, 0, loseimmediatly
            	addi $a0, $a0, -1
            	sw $a0, array($t3)

            	li $v0, 4
		la $a0, newline
		syscall
            	
            	li $v0, 4
		la $a0, violation
		syscall
		li $t3, 11
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	li $v0, 1
		syscall
            	
            	li $v0, 4
		la $a0, firstmove
		syscall
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $v1, $v0	# assign enternum to $v1
		
		j enterwrongXmidllefirstO
	
	
	enterwrongO:

		sge $t6, $v1, 1        # set greater equal
		add $t1, $t6, $zero
		slti $t6, $v1, 8
		add $t1, $t6, $t1
		
            	addi $t6, $v1, -1      		# enternum-1
            	mul $t6, $t6, 4      		# enternum
            	lw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
            	sge $t0, $t0, 0
            	add $t1, $t1, $t0
            	
            	beq $t1, 3, exitenterwrongO
            	li $t3, 11
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	beq $a0, 0, loseimmediatly
            	li $t3, 11
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	addi $a0, $a0, -1
            	sw $a0, array($t3)
            	
            	li $v0, 4
		la $a0, newline
		syscall
            	
            	li $v0, 4
		la $a0, violation
		syscall
		li $t3, 11
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	li $v0, 1
		syscall
            	
            	li $v0, 4
		la $a0, invalidenternum
		syscall
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $v1, $v0	# assign enternum to $v1
		
		j enterwrongO
            	
	exitenterwrongO:
	
	addi $t0, $v1, -1      		# enternum-1
	mul $t1, $t0, 4        		# (enternum-1) * 4
    	lw $t1, EachColumn($t1)		# EachColumn[enternum-1] (Base + Offset)
    	mul $t6, $t1, 7      		# EachColumn[enternum-1] * col
        add $t6, $t6, $t0     		# EachColumn[enternum-1] * col + enternum-1
	addi $t0, $zero, 'O'
	sb $t0, BoardArray($t6)        # boardArray[i][j] = 'X' (Base + Offset)
	
	addi $t6, $v1, -1      		# enternum-1
	mul $t6, $t6, 4        		# (enternum-1) * 4
	lw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
	addi $t0, $t0, -1
	sw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
	
# Close stack
exitOmove:
	lw $t3, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 12
	
	jr $ra
loseimmediatly: #XO
	li $v0, 4
	la $a0, wrongtomuch
	syscall
	
	addi $t0, $zero, 'X'
	bne $t0, $s5, printX
	
	li $v0, 4
	la $a0, printOwin
	syscall
	li $v0, 4
	la $a0, nameplayer2
	syscall
	j End
printX:
	li $v0, 4
	la $a0, printXwin
	syscall
	li $v0, 4
	la $a0, nameplayer1
	syscall
	j End
End:
	li $v0, 4
	la $a0, startagain
	syscall
	
	li $v0, 12
	syscall
	beq $v0, ' ', Startagain
	
	li $v0, 10
	syscall

##################################################################################################################################################
Xmove_1:
# Stack
	addi $sp, $sp, -12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t3, 8($sp)

# Handling
	li $t1, 0
	li $v0, 4
	la $a0, numundoX
	syscall
	sll $t1, $t1, 2
	lw $a0, array($t1)
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, undo
	syscall

	li $v0, 4
	la $a0, violation
	syscall
	li $t3, 10
	sll $t3, $t3, 2
	lw $a0, array($t3)
	li $v0, 1
	syscall

	addi $s5, $zero, 'X'
	subi $t0, $s5, 'X'

	li $t1, 2
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	beq $a0, $t1, firstmove1_1
	bne $a0, $t1, middle1_1
	
middle_1:
	li $v0, 12
	syscall
	subi $v0, $v0, '0'
	move $v1, $v0	# assign enternum to $v1

	li $t1, 2
	sll $t2, $t1, 2
	lw $a0, array($t2)

	beq $t0, $a0, enterwrongX_1
	bne $t0, $a0, enterwrongXmidllefirstX_1
firstmove1_1:
	li $v0, 4
	la $a0, enterfirstmove
	syscall
	j middle_1
middle1_1:	
	li $v0, 4
	la $a0, entercolumn
	syscall
	j middle_1
	enterwrongXmidllefirstX_1:
		
		sge $t6, $v1, 4        # set greater equal
		add $t1, $t6, $zero
		slti $t6, $v1, 5
		add $t1, $t6, $t1
		
            	addi $t6, $v1, -1      		# enternum-1
            	mul $t6, $t6, 4      		# enternum
            	lw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
            	sge $t0, $t0, 0
            	add $t1, $t1, $t0
            	
            	beq $t1, 3, exitenterwrongX_1
            	li $t3, 10
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	beq $a0, 0, loseimmediatly
            	addi $a0, $a0, -1
            	sw $a0, array($t3)
            	
            	li $v0, 4
		la $a0, newline
		syscall
            	
            	li $v0, 4
		la $a0, violation
		syscall
		li $t3, 10
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	li $v0, 1
		syscall
            	
            	li $v0, 4
		la $a0, firstmove
		syscall
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $v1, $v0	# assign enternum to $v1
		
		j enterwrongXmidllefirstX_1
	
	enterwrongX_1:
		
		sge $t6, $v1, 1        # set greater equal
		add $t1, $t6, $zero
		slti $t6, $v1, 8
		add $t1, $t6, $t1
		
            	addi $t6, $v1, -1      		# enternum-1
            	mul $t6, $t6, 4      		# enternum
            	lw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
            	sge $t0, $t0, 0
            	add $t1, $t1, $t0
            	
            	beq $t1, 3, exitenterwrongX_1
            	li $t3, 10
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	beq $a0, 0, loseimmediatly
            	li $t3, 10
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	addi $a0, $a0, -1
            	sw $a0, array($t3)

            	li $v0, 4
		la $a0, newline
		syscall

            	li $v0, 4
		la $a0, violation
		syscall
		li $t3, 10
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	li $v0, 1
		syscall
            	
            	li $v0, 4
		la $a0, invalidenternum
		syscall
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $v1, $v0	# assign enternum to $v1
		
		j enterwrongX_1	
            	
	exitenterwrongX_1:
	
	addi $t0, $v1, -1      		# enternum-1
	mul $t1, $t0, 4        		# (enternum-1) * 4
    	lw $t1, EachColumn($t1)		# EachColumn[enternum-1] (Base + Offset)
    	mul $t6, $t1, 7      		# EachColumn[enternum-1] * col
        add $t6, $t6, $t0     		# EachColumn[enternum-1] * col + enternum-1
	addi $t0, $zero, 'X'
	sb $t0, BoardArray($t6)        # boardArray[i][j] = 'X' (Base + Offset)
	
	addi $t6, $v1, -1      		# enternum-1
	mul $t6, $t6, 4        		# (enternum-1) * 4
	lw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
	addi $t0, $t0, -1
	sw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
	
# Close stack
exitXmove_1:
	lw $t3, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 12
	
	jr $ra

##################################################################################################################################################
Omove_1:
# Stack
	addi $sp, $sp, -12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t3, 8($sp)
# Handling
	li $t1, 1
	li $v0, 4
	la $a0, numundoO
	syscall
	sll $t1, $t1, 2
	lw $a0, array($t1)
	li $v0, 1
	syscall
	li $v0, 4
	la $a0, undo
	syscall

	li $v0, 4
	la $a0, violation
	syscall
	li $t3, 11
	sll $t3, $t3, 2
	lw $a0, array($t3)
	li $v0, 1
	syscall

	# Check if firstmove or not
	addi $s5, $zero, 'O'	
	subi $t0,$s5, 'O'
	
	li $t1, 3
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	beq $a0, $t1, firstmove2_1
	bne $a0, $t1, middle3_1
	
middle2_1:
	li $v0, 12
	syscall
	subi $v0, $v0, '0'
	move $v1, $v0	# assign enternum to $v1

	li $t1, 3
	sll $t2, $t1, 2
	lw $a0, array($t2)

	beq $t0, $a0, enterwrongO_1
	bne $t0, $a0, enterwrongXmidllefirstO_1
firstmove2_1:
	li $v0, 4
	la $a0, enterfirstmove
	syscall
	j middle2_1
middle3_1:	
	li $v0, 4
	la $a0, entercolumn
	syscall
	j middle2_1
	enterwrongXmidllefirstO_1:
		
		sge $t6, $v1, 4        # set greater equal
		add $t1, $t6, $zero
		slti $t6, $v1, 5
		add $t1, $t6, $t1
		
            	addi $t6, $v1, -1      		# enternum-1
            	mul $t6, $t6, 4      		# enternum
            	lw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
            	sge $t0, $t0, 0
            	add $t1, $t1, $t0
            	
            	beq $t1, 3, exitenterwrongO_1
            	li $t3, 11
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	beq $a0, 0, loseimmediatly1
            	addi $a0, $a0, -1
            	sw $a0, array($t3)

            	li $v0, 4
		la $a0, newline
		syscall

            	li $v0, 4
		la $a0, violation
		syscall
		li $t3, 11
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	li $v0, 1
		syscall
            	
            	li $v0, 4
		la $a0, firstmove
		syscall
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $v1, $v0	# assign enternum to $v1
		
		j enterwrongXmidllefirstO_1
	
	
	enterwrongO_1:

		sge $t6, $v1, 1        # set greater equal
		add $t1, $t6, $zero
		slti $t6, $v1, 8
		add $t1, $t6, $t1
		
            	addi $t6, $v1, -1      		# enternum-1
            	mul $t6, $t6, 4      		# enternum
            	lw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
            	sge $t0, $t0, 0
            	add $t1, $t1, $t0
            	
            	beq $t1, 3, exitenterwrongO_1
            	li $t3, 11
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	beq $a0, 0, loseimmediatly1
            	li $t3, 11
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	addi $a0, $a0, -1
            	sw $a0, array($t3)

            	li $v0, 4
		la $a0, newline
		syscall

            	li $v0, 4
		la $a0, violation
		syscall
		li $t3, 11
            	sll $t3, $t3, 2
            	lw $a0, array($t3)
            	li $v0, 1
		syscall
            	
            	li $v0, 4
		la $a0, invalidenternum
		syscall
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $v1, $v0	# assign enternum to $v1
		
		j enterwrongO_1
            	
	exitenterwrongO_1:
	
	addi $t0, $v1, -1      		# enternum-1
	mul $t1, $t0, 4        		# (enternum-1) * 4
    	lw $t1, EachColumn($t1)		# EachColumn[enternum-1] (Base + Offset)
    	mul $t6, $t1, 7      		# EachColumn[enternum-1] * col
	add $t6, $t6, $t0     		# EachColumn[enternum-1] * col + enternum-1
	addi $t0, $zero, 'O'
	sb $t0, BoardArray($t6)        # boardArray[i][j] = 'X' (Base + Offset)
	
	addi $t6, $v1, -1      		# enternum-1
	mul $t6, $t6, 4        		# (enternum-1) * 4
	lw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
	addi $t0, $t0, -1
	sw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
	
# Close stack
exitOmove_1:
	lw $t3, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 12
	
	jr $ra
loseimmediatly1:
	li $v0, 4
	la $a0, wrongtomuch
	syscall
	
	addi $t0, $zero, 'X'
	bne $t0, $s5, printX_1
	
	li $v0, 4
	la $a0, printOwin
	syscall
	li $v0, 4
	la $a0, nameplayer1
	syscall
	j End_1
printX_1:
	li $v0, 4
	la $a0, printXwin
	syscall
	li $v0, 4
	la $a0, nameplayer2
	syscall
	j End_1
End_1:
	li $v0, 4
	la $a0, startagain
	syscall
	
	li $v0, 12
	syscall
	beq $v0, ' ', Startagain
	
	li $v0, 10
	syscall

##################################################################################################################################################
printboardarray:
# Stack
	addi $sp, $sp, -16
	sw $t0, 0($sp)
	sw $t1, 4($sp) 
	sw $t8, 8($sp)
	sw $t2, 12($sp)
# Print array
	li $v0, 4
	la $a0, downline1
	syscall
	li $v0, 4
	la $a0, lineofnum
	syscall
	#li $v0, 4
	#la $a0, lineofseperate
	#syscall
	li $v0, 4
	la $a0, downline
	syscall
	
	li $t8, 12
	li $t0, 0	# i
loopi1:
	beq $t0, 6, exiti1
   	li $t1, 0	# j
   	
   	li $v0, 4
	la $a0, lash
	syscall
	
	li $v0, 4
	la $a0, space
	syscall
	
	sll $t2, $t8, 2
	lw $a0, array($t2)
	li $v0, 1
	syscall
	addi $t8, $t8, 1
	
	li $v0, 4
	la $a0, lash
	syscall 
	
	loopj1:
		beq $t1, 7, exitj1
		
		li $v0, 4
		la $a0, space
		syscall
		
		mul $t6, $t0, 7      # i * col
            	add $t6, $t6, $t1      # i * col + j
            	lb $a0, BoardArray($t6)         # print BoardArray[i][j] (Base + Offset)
            	li $v0, 11
            	syscall
            	
            	li $v0, 4
		la $a0, lash
		syscall 
		
		addi $t1, $t1, 1
		j loopj1
	exitj1:
	
	li $v0, 4
	la $a0, newline
	syscall
	li $v0, 4
	la $a0, downline
	syscall
	
	addi $t0, $t0, 1
	j loopi1
exiti1:
	li $v0, 4
	la $a0, lineofseperate
	syscall
# Close stack
	lw $t2, 12($sp)
	lw $t8, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 16

	jr $ra

##################################################################################################################################################
UndoXO:
# Stack
	addi $sp, $sp, -12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t3, 8($sp)

# Handling
	# Check if still have undo move(s) or not
	li $t1, 2
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	beq $a0, $t1, exitundo2
	li $t1, 1
	beq $a0, $t1, exitundo2

exitundo2:
	li $t1, 4
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	beq $a0, $t1, checkfirstX

not:	
	li $t1, 2
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	beq $a0, $t1, exitundo3
	addi $a0, $a0, -1
	sw $a0, array($t2)
	j exitundo

checkfirstX:
	li $t1, 3
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	beq $a0, $t1, jumphere

	li $t1, 8
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	bne $a0, $t1, not

checkfirstX_1:
	li $t1, 8
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, 1
	sw $a0, array($t2)
	j exitundo
	
exitundo3:
	li $t1, 3
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	beq $a0, $t1, exitundo4
	j jumphere
	
exitundo4:
	li $t1, 3
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, -1
	sw $a0, array($t2)
	j exitundo
	
jumphere:	
	subi $t0, $s5, 'X'
	
	li $t1, 0
	sll $t2, $t1, 2
	lw $a0, array($t2)
	beq $t0, $a0, exitundo
	
	subi $t0,$s5, 'O'
	
	li $t1, 1
	sll $t2, $t1, 2
	lw $a0, array($t2)

	beq $t0, $a0, exitundo
	
	li $v0, 4
	la $a0, playerturns
	syscall
	
	li $v0, 12
	syscall
	subi $v0, $v0, '0'
	move $t3, $v0 		# undonum
	
	undowrong:
		beq $t3, 1, exitundowrong
		beq $t3, 0, exitundo
		
		li $v0, 4
		la $a0, tryundoagain
		syscall
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $t3, $v0 		# undonum
		j undowrong
		
	exitundowrong:
	
	addi $t6, $v1, -1      		# enternum-1
	mul $t6, $t6, 4        		# enternum-1 * 4
	lw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
	addi $t0, $t0, 1
	sw $t0, EachColumn($t6)        # EachColumn[enternum-1]++
	
	addi $t0, $v1, -1      		# enternum-1
	mul $t1, $t0, 4        		# enternum-1 * 4
    	lw $t1, EachColumn($t1)        # EachColumn[enternum-1] (Base + Offset)
    	mul $t6, $t1, $s2      		# EachColumn[enternum-1] * col
        add $t6, $t6, $t0      	# EachColumn[enternum-1] * col + enternum -1
        li $t2, ' '
	sb $t2, BoardArray($t6)        # BoardArray[i][j] = ' ' (Base + Offset)

# Close stack
	lw $t3, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 12
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal printboardarray
	
	beq $s5, 'X', undoXremove
	
	li $t1, 1
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, -1
	sw $a0, array($t2)
	addi $t1, $t1, 1
	
	jal Omove
	jal printboardarray
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	undoXremove:
	
	li $t1, 0
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, -1
	sw $a0, array($t2)

	jal Xmove
	jal printboardarray
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
exitundo:
	lw $t3, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 12
	
	jr $ra
	
##################################################################################################################################################
UndoOX:
# Stack
	addi $sp, $sp, -12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t3, 8($sp)

# Handling
	# Check if still have undo move(s) or not
	li $t1, 3
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	beq $a0, $t1, exitundo2_2
	li $t1, 1
	beq $a0, $t1, exitundo2_2

exitundo2_2:
	li $t1, 5
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	beq $a0, $t1, checkfirstX_2

not_2:	
	li $t1, 3
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	beq $a0, $t1, exitundo3_2
	addi $a0, $a0, -1
	sw $a0, array($t2)
	j exitundo_2

checkfirstX_2:
	li $t1, 2
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	beq $a0, $t1, jumphere_2

	li $t1, 9
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	bne $a0, $t1, not_2

checkfirstX_1_2:
	li $t1, 9
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, 1
	sw $a0, array($t2)
	j exitundo_2
	
exitundo3_2:
	li $t1, 2
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	beq $a0, $t1, exitundo4_2
	j jumphere_2
	
exitundo4_2:
	li $t1, 2
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, -1
	sw $a0, array($t2)
	j exitundo_2
	
jumphere_2:
	subi $t0, $s5, 'X'
	
	li $t1, 0
	sll $t2, $t1, 2
	lw $a0, array($t2)
	beq $t0, $a0, exitundo_2
	
	subi $t0,$s5, 'O'
	
	li $t1, 1
	sll $t2, $t1, 2
	lw $a0, array($t2)

	beq $t0, $a0, exitundo_2
	
	li $v0, 4
	la $a0, playerturns
	syscall
	
	li $v0, 12
	syscall
	subi $v0, $v0, '0'
	move $t3, $v0 		# undonum
	
	undowrong_2:
		beq $t3, 1, exitundowrong_2
		beq $t3, 0, exitundo_2
		
		li $v0, 4
		la $a0, tryundoagain
		syscall
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $t3, $v0 		# undonum
		j undowrong_2

	exitundowrong_2:
	
	addi $t6, $v1, -1      		# enternum-1
	mul $t6, $t6, 4        		# enternum-1 * 4
	lw $t0, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
	addi $t0, $t0, 1
	sw $t0, EachColumn($t6)        # EachColumn[enternum-1]++
	
	addi $t0, $v1, -1      		# enternum-1
	mul $t1, $t0, 4        		# enternum-1 * 4
    	lw $t1, EachColumn($t1)        # EachColumn[enternum-1] (Base + Offset)
    	mul $t6, $t1, $s2      		# EachColumn[enternum-1] * col
        add $t6, $t6, $t0      	# EachColumn[enternum-1] * col + enternum -1
        li $t2, ' '
	sb $t2, BoardArray($t6)        # BoardArray[i][j] = ' ' (Base + Offset)

# Close stack
	lw $t3, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 12
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal printboardarray
	
	beq $s5, 'X', undoXremove_2
	
	li $t1, 1
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, -1
	sw $a0, array($t2)
	
	jal Omove
	jal printboardarray
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
	undoXremove_2:
	
	li $t1, 0
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, -1
	sw $a0, array($t2)

	jal Xmove
	jal printboardarray
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
exitundo_2:
	lw $t3, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 12
	
	jr $ra
	
##################################################################################################################################################	
BlockX:
# Stack
	addi $sp, $sp, -16
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t3, 8($sp)
	sw $ra, 12($sp)
# Handling
	jal Block_conditionO
	bne $v0, $zero, exitblockX_1
	
	subi $t0, $s5, 'X'
	
	li $t1, 4
	sll $t2, $t1, 2
	lw $a0, array($t2)
	beq $t0, $a0, exitblockX
	
	li $v0, 4
	la $a0, playerblock
	syscall
	
	li $v0, 12
	syscall
	subi $v0, $v0, '0'
	move $t3, $v0
	
	blockwrongX:
		beq $t3, 1, exitblockwrongX
		beq $t3, 0, exitblockX
		
		li $v0, 4
		la $a0, tryblockagain
		syscall
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $t3, $v0
		j blockwrongX
	exitblockwrongX:
	li $t1, 4
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, -1
	sw $a0, array($t2)

# Close stack
exitblockX:		
	lw $ra, 12($sp)
	lw $t3, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 16
	
	jr $ra

exitblockX_1:
	lw $ra, 12($sp)
	lw $t3, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 16
	
	li $v0, 4
	la $a0, notblock
	syscall
	
	jr $ra
	
##################################################################################################################################################	
BlockO:
# Stack
	addi $sp, $sp, -16
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t3, 8($sp)
	sw $ra, 12($sp)
# Handling
	jal Block_conditionX
	bne $v0, $zero, exitblockO_1
	
	subi $t0, $s5, 'O'
	
	li $t1, 5
	sll $t2, $t1, 2
	lw $a0, array($t2)
	beq $t0, $a0, exitblockO
	
	li $v0, 4
	la $a0, playerblock
	syscall
	
	li $v0, 12
	syscall
	subi $v0, $v0, '0'
	move $t3, $v0

	blockwrongO:
		beq $t3, 1, exitblockwrongO
		beq $t3, 0, exitblockO
		
		li $v0, 4
		la $a0, tryblockagain
		syscall
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $t3, $v0
		j blockwrongO

	exitblockwrongO:
	li $t1, 5
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, -1
	sw $a0, array($t2)

# Close stack
exitblockO:		
	lw $ra, 12($sp)
	lw $t3, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 16
	
	jr $ra

exitblockO_1:
	lw $ra, 12($sp)
	lw $t3, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 16
	
	li $v0, 4
	la $a0, notblock
	syscall
	
	jr $ra
	
##################################################################################################################################################	
Block_conditionX:
# Stack
	addi $sp, $sp, -24
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t6, 12($sp)
	sw $t8, 16($sp)
	sw $ra, 20($sp)

	li $t8, 0
Loopcb:
	beq $t8, 7, Exitcb
	
	# Select 1 piece each col
	mul $t1, $t8, 4        		
    	lw $t1, EachColumn($t1)		# EachColumn[enternum-1] (Base + Offset)
    	mul $t6, $t1, 7      		# EachColumn[enternum-1] * col
        add $t6, $t6, $t8     		# EachColumn[enternum-1] * col + enternum-1
	addi $t0, $zero, 'X'
	sb $t0, BoardArray($t6)        # boardArray[i][j] = 'X' (Base + Offset)
	
	jal Win

	mul $t1, $t8, 4        		# enternum-1 * 4
    	lw $t1, EachColumn($t1)        # EachColumn[enternum-1] (Base + Offset)
    	mul $t6, $t1, $s2      		# EachColumn[enternum-1] * col
        add $t6, $t6, $t8      	# EachColumn[enternum-1] * col + enternum -1
        li $t2, ' '
	sb $t2, BoardArray($t6)        # BoardArray[i][j] = ' ' (Base + Offset)

	beq $v0, 1, Exitcb
	addi $t8, $t8,1
	j Loopcb
Exitcb:
# Close stack
	lw $ra, 20($sp)
	lw $t8, 16($sp)
	lw $t6, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 24
	
	jr $ra

##################################################################################################################################################	
Block_conditionO:
# Stack
	addi $sp, $sp, -24
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t6, 12($sp)
	sw $t8, 16($sp)
	sw $ra, 20($sp)

	li $t8, 0
Loopcb_1:
	beq $t8, 7, Exitcb_1
	
	# Select 1 piece each col
	mul $t1, $t8, 4        		
    	lw $t1, EachColumn($t1)		# EachColumn[enternum-1] (Base + Offset)
    	mul $t6, $t1, 7      		# EachColumn[enternum-1] * col
        add $t6, $t6, $t8     		# EachColumn[enternum-1] * col + enternum-1
	addi $t0, $zero, 'O'
	sb $t0, BoardArray($t6)        # boardArray[i][j] = 'O' (Base + Offset)
	
	jal Win

	mul $t1, $t8, 4        		# enternum-1 * 4
    	lw $t1, EachColumn($t1)        # EachColumn[enternum-1] (Base + Offset)
    	mul $t6, $t1, $s2      		# EachColumn[enternum-1] * col
        add $t6, $t6, $t8      	# EachColumn[enternum-1] * col + enternum -1
        li $t2, ' '
	sb $t2, BoardArray($t6)        # BoardArray[i][j] = ' ' (Base + Offset)

	beq $v0, 1, Exitcb_1
	addi $t8, $t8,1
	j Loopcb
Exitcb_1:
# Close stack
	lw $ra, 20($sp)
	lw $t8, 16($sp)
	lw $t6, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 24
	
	jr $ra

##################################################################################################################################################	
Draw:
# Stack
	addi $sp, $sp, -12
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)

# Handling
	li $t0, 0 # i
Looprow:
	beq $t0, $s1, Exitdrawrow
	li $t1, 0 # j
	Loopcolumn:
		beq $t1, $s2, Exitdrawcolumn
		
		mul $t6, $t0, $s2 # i * col
		add $t6, $t6, $t1 # i * col + j
		lb $a0, BoardArray($t6) # arr[i][j] (Base + Offset)
		
		li $t2, ' '
		beq $a0, $t2, Notdraw
		
		addi $t1, $t1, 1
		j Loopcolumn	
	Exitdrawcolumn:
	addi $t0, $t0, 1
	j Looprow
	
Exitdrawrow:
# Close stack
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	addi $sp, $sp, 12

	li $v0, 0
	jr $ra

Notdraw:
# Close stack
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	addi $sp, $sp, 12
	
	li $v0, 1
	jr $ra

##################################################################################################################################################	
Win:
# Stack
	addi $sp, $sp,-28
	lw $t0, 0($sp)	# i
	lw $t1, 4($sp)	# j
	lw $t2, 8($sp)	# hori
	lw $t3, 12($sp)	# verti
	lw $t4, 16($sp)	# rightdia
	lw $t5, 20($sp) # leftdia
	lw $t7, 24($sp) # k

# Handling	
	li $t0, 0 # i
Looprow1:
	beq $t0, $s1, Exitrow1
	li $t1, 0
	Loopcolumn1:
		beq $t1, $s2, Exitcolumn1
		li $t2, 0	# hori
		li $t3, 0	# verti
		li $t4, 0	# rightdia
		li $t5, 0	# leftdia
		
		li $t7, 0
		Loopk:
			beq $t7, 4, Exitloopk
			
			hori:
			slti $t6, $t1, 4 # j < 4
			beq $t6, $zero, verti
			
			#find arr[i][j+k]
			mul $t6, $t0, $s2 # i * col
			add $t6, $t6, $t1 # i * col + j
			add $t6, $t6, $t7 # i * col + j + k
			lb $t6, BoardArray($t6)	# arr[i][j+k]
			
			bne $t6, $s5, verti
			addi $t2, $t2, 1
			
			verti:
			slti $t6, $t0, 3	# i < 3
			beq $t6, $zero, rightdia
			
			#find arr[i+k][j]
			add $t6, $t0, $t7	# i + k
			mul $t6, $t6, $s2	# i + k * col
			add $t6, $t6, $t1	# i + k * col + j
			lb $t6, BoardArray($t6)	# arr[i+k][j]
			
			bne $t6, $s5, rightdia
			addi $t3, $t3, 1
			
			rightdia:
			slti $t6, $t0, 3	# i < 3
			beq $t6, $zero, leftdia
			slti $t6, $t1, 4	# j < 4
			beq $t6, $zero, leftdia
			
			#find arr[i+k][j+k]
			add $t6, $t0, $t7	# i + k
			mul $t6, $t6, $s2	# i + k * col
			add $t6, $t6, $t1	# i + k * col + j
			add $t6, $t6, $t7	# i + k * col + j + k
			lb $t6, BoardArray($t6)	# arr[i+k][j+k]
			
			bne $t6, $s5, leftdia
			addi $t4, $t4, 1
		
			leftdia:
			slti $t6, $t0, 3	# i < 3
			beq $t6, $zero, Loopagain
			sge $t6, $t1, 3		# j > 2
			beq $t6, $zero, Loopagain
			
			#find arr[i+k][j-k]
			add $t6, $t0, $t7	# i + k
			mul $t6, $t6, $s2	# i + k * col
			add $t6, $t6, $t1	# i + k * col + j
			sub $t6, $t6, $t7	# i + k * col + j - k
			lb $t6, BoardArray($t6)	# arr[i+k][j-k]
			
			bne $t6, $s5, Loopagain
			addi $t5, $t5, 1
			
			
			Loopagain:
			addi $t7, $t7, 1
			j Loopk
		
		Exitloopk:
		
		beq $t2, 4, jumptrue
		beq $t3, 4, jumptrue
		beq $t4, 4, jumptrue
		beq $t5, 4, jumptrue
		
		addi $t1, $t1, 1
		j Loopcolumn1
	Exitcolumn1:
	addi $t0, $t0, 1
	j Looprow1
Exitrow1:
# Close stack
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	lw $t3, 12($sp)
	lw $t4, 16($sp)
	lw $t5, 20($sp)
	lw $t7, 24($sp)
	addi $sp, $sp, 28
	
	li $v0, 0
	jr $ra

jumptrue:
# Close stack
	lw $t0, 0($sp)
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	lw $t3, 12($sp)
	lw $t4, 16($sp)
	lw $t5, 20($sp)
	lw $t7, 24($sp)
	addi $sp, $sp, 28
	
	li $v0, 1
	jr $ra

##################################################################################################################################################	
RemoveX:
# Stack
	addi $sp, $sp, -24
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $t4, 16($sp)
	sw $t5, 20($sp)

# Handling
	li $t1, 3
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	bne $a0, $t1, exitremove_2
	
	li $t1, 6
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	bne $a0, $t1, exitremove_2
	
	subi $t0,$s5, 'X'

	li $t1, 6
	sll $t2, $t1, 2
	lw $a0, array($t2)
	beq $t0, $a0, exitremove_2
	
	li $v0, 4
	la $a0, playerturnsr
	syscall
	
	li $v0, 12
	syscall
	subi $v0, $v0, '0'
	move $t3, $v0 		# removenum
	
	removewrongf:
		beq $t3, 1, exitremoverongf
		beq $t3, 0, exitremove_2
		
		li $v0, 4
		la $a0, tryundoagain
		syscall
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $t3, $v0 		# removenum
		j removewrongf

	exitremoverongf:
	
	li $v0, 4
	la $a0, enterrowr
	syscall
	
	li $v0, 12
	syscall
	subi $v0, $v0, '0'
	move $t2, $v0 		# row
	
	li $v0, 4
	la $a0, entercolumnr
	syscall
	
	li $v0, 12
	syscall
	subi $v0, $v0, '0'
	move $t3, $v0 		# col
	
	slti $t1, $t2, 1
	bne $t1, $zero, removewrong
	sge $t1, $t2, 7
	bne $t1, $zero, removewrong
	
	slti $t1, $t3, 1
	bne $t1, $zero, removewrong
	sge $t1, $t3, 8
	bne $t1, $zero, removewrong
	
	li $t1, 0
	beq $t1, $zero, exitremovewrong
	
	removewrong:
		li $v0, 4
		la $a0, enterrowr
		syscall
	
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $t2, $v0 		# row
	
		li $v0, 4
		la $a0, entercolumnr
		syscall
	
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $t3, $v0 		# col
		slti $t1, $t2, 1
		bne $t1, $zero, removewrong
		sge $t1, $t2, 7
		bne $t1, $zero, removewrong
	
		slti $t1, $t3, 1
		bne $t1, $zero, removewrong
		sge $t1, $t3, 8
		bne $t1, $zero, removewrong
	exitremovewrong:
	
	addi $t6, $t3, -1      		# enternum-1
	mul $t6, $t6, 4        		# enternum-1 * 4
	lw $t1, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
	addi $t1, $t2, -1		# 6 - 5, 5 - 4, 4 - 3
	sw $t1, EachColumn($t6)        # EachColumn[enternum-1]

	addi  $t3, $t3, -1
	add $t4, $t2, $t4  # i
Loopiremove: 
	beq $t4, 1, exitiremove # 6 rows
	
		addi $t4, $t4, -2
		
		mul $t6, $t4, 7      # i * col
            	add $t6, $t6, $t3      # i * col + j
            	lb $t0, BoardArray($t6)

            	addi $t4, $t4, 1
            	mul $t6, $t4, 7      # i * col
            	add $t6, $t6, $t3      # i * col + j
            	sb $t0, BoardArray($t6)
            	
            	beq $t0, ' ', exitiremove2
		addi $t6, $t3, 0     		# enternum-1
		mul $t6, $t6, 4        		# (enternum-1) * 4
		lw $t1, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
            	addi $t1, $t1, -1
            	sw $t1, EachColumn($t6)
            	
	j Loopiremove
exitiremove:
	addi $t4, $t4, -1
	mul $t6, $t4, 7
	add $t6, $t6, $t3
	li $t2, ' '
	sb $t2, BoardArray($t6)
exitiremove2:
		addi $t6, $t3, 0     		# enternum-1
		mul $t6, $t6, 4        		# (enternum-1) * 4
		lw $t1, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
            	addi $t1, $t1, 1
            	sw $t1, EachColumn($t6)
# Close stack
	lw $t5, 20($sp)
	lw $t4, 16($sp)
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	lw $t5, 20($sp)
	lw $t4, 16($sp)
	addi $sp, $sp, 24
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t1, 6
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, -1
	sw $a0, array($t2)
	
	jal printboardarray
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra
exitremove_2:

	lw $t5, 20($sp)
	lw $t4, 16($sp)
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	lw $t5, 20($sp)
	lw $t4, 16($sp)
	addi $sp, $sp, 24
	
	jr $ra
	
##################################################################################################################################################	
RemoveO:
# Stack
	addi $sp, $sp, -24
	sw $t0, 0($sp)
	sw $t1, 4($sp)
	sw $t2, 8($sp)
	sw $t3, 12($sp)
	sw $t4, 16($sp)
	sw $t5, 20($sp)

# Handling
	li $t1, 2
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 0
	bne $a0, $t1, exitremove_2_1
	
	li $t1, 7
	sll $t2, $t1, 2
	lw $a0, array($t2)
	li $t1, 1
	bne $a0, $t1, exitremove_2
		
	subi $t0,$s5, 'O'

	li $t1, 7
	sll $t2, $t1, 2
	lw $a0, array($t2)
	beq $t0, $a0, exitremove_2_1

	li $v0, 4
	la $a0, playerturnsr
	syscall
	
	li $v0, 12
	syscall
	subi $v0, $v0, '0'
	move $t3, $v0 		# removenum
	
	removewrongf_1:
		beq $t3, 1, exitremoverongf_1
		beq $t3, 0, exitremove_2
		
		li $v0, 4
		la $a0, tryundoagain
		syscall
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $t3, $v0 		# removenum
		j removewrongf_1

	exitremoverongf_1:

	li $v0, 4
	la $a0, enterrowr
	syscall
	
	li $v0, 12
	syscall
	subi $v0, $v0, '0'
	move $t2, $v0 		# row
	
	li $v0, 4
	la $a0, entercolumnr
	syscall
	
	li $v0, 12
	syscall
	subi $v0, $v0, '0'
	move $t3, $v0 		# col
	
	slti $t1, $t2, 1
	bne $t1, $zero, removewrong_1
	sge $t1, $t2, 7
	bne $t1, $zero, removewrong_1
	
	slti $t1, $t3, 1
	bne $t1, $zero, removewrong_1
	sge $t1, $t3, 8
	bne $t1, $zero, removewrong_1

	li $t1, 0
	beq $t1, $zero, exitremovewrong_1

	removewrong_1:
		li $v0, 4
		la $a0, enterrowr
		syscall
	
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $t2, $v0 		# row
	
		li $v0, 4
		la $a0, entercolumnr
		syscall
	
		li $v0, 12
		syscall
		subi $v0, $v0, '0'
		move $t3, $v0 		# col
		slti $t1, $t2, 1
		bne $t1, $zero, removewrong_1
		sge $t1, $t2, 7
		bne $t1, $zero, removewrong_1
	
		slti $t1, $t3, 1
		bne $t1, $zero, removewrong_1
		sge $t1, $t3, 8
		bne $t1, $zero, removewrong_1
	exitremovewrong_1:
	
	addi $t6, $t3, -1      		# enternum-1
	mul $t6, $t6, 4        		# enternum-1 * 4
	lw $t1, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
	addi $t1, $t2, -1
	sw $t1, EachColumn($t6)        # EachColumn[enternum-1]

	addi  $t3, $t3, -1
	add $t4, $t2, $t4  # i
Loopiremove_1: 
	beq $t4, 1, exitiremove_1 # 6 rows
	
		addi $t4, $t4, -2
		
		mul $t6, $t4, 7      # i * col
            	add $t6, $t6, $t3      # i * col + j
            	lb $t0, BoardArray($t6)

            	addi $t4, $t4, 1
            	mul $t6, $t4, 7      # i * col
            	add $t6, $t6, $t3      # i * col + j
            	sb $t0, BoardArray($t6)

		beq $t0, ' ', exitiremove2_1
		addi $t6, $t3, 0     		# enternum-1
		mul $t6, $t6, 4        		# (enternum-1) * 4
		lw $t1, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
            	addi $t1, $t1, -1
            	sw $t1, EachColumn($t6)
            	
	j Loopiremove_1
exitiremove_1:
	addi $t4, $t4, -1
	mul $t6, $t4, 7
	add $t6, $t6, $t3
	li $t2, ' '
	sb $t2, BoardArray($t6)
exitiremove2_1:
		addi $t6, $t3, 0     		# enternum-1
		mul $t6, $t6, 4        		# (enternum-1) * 4
		lw $t1, EachColumn($t6)        # EachColumn[enternum-1] (Base + Offset)
            	addi $t1, $t1, 1
            	sw $t1, EachColumn($t6)
# Close stack
	lw $t5, 20($sp)
	lw $t4, 16($sp)
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	lw $t5, 20($sp)
	lw $t4, 16($sp)
	addi $sp, $sp, 24
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t1, 7
	sll $t2, $t1, 2
	lw $a0, array($t2)
	addi $a0, $a0, -1
	sw $a0, array($t2)
	
	jal printboardarray
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4

	jr $ra
exitremove_2_1:

	lw $t5, 20($sp)
	lw $t4, 16($sp)
	lw $t3, 12($sp)
	lw $t2, 8($sp)
	lw $t1, 4($sp)
	lw $t0, 0($sp)
	lw $t5, 20($sp)
	lw $t4, 16($sp)
	addi $sp, $sp, 24

	jr $ra
