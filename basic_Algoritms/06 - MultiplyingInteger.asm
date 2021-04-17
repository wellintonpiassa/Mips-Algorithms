
.text
	addi $s2, $zero, 10
	addi $s1, $zero, 4
	
	#Formas de fazer multiplicação
	mul $t0, $s0, $s1
	
	
	li $v0, 1
	add $a0, $zero, $t0
	syscall