# ALGORITMO PARA CONVERSAO DE CARACTERES MINUSCULOS EM MAIUSCULOS

.data
	msg1: .asciiz "Digite uma string: "
	string: .space 100
	
.text
main:
	jal leitura_string
	jal transforma
	move $a0, $t3
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	
	
leitura_string:
	
	# Printando string de 
	la $a0, msg1
	li $v0, 4
	syscall
	
	# Recebendo string do usuario
	la $a0, string
	li $a1, 100
	li $v0, 8
	syscall
	jr $ra
	
	
transforma:
	move $t3, $a0		
L1:	lb $t0, ($a0)		
	beqz $t0, L2		
	move $t1, $t0		
	subi $t1, $t1, 32	
	sb $t1, ($a0)		
	addi $a0,$a0, 1		
	beq $t0, 10, L2		
	j L1

L2:
	subi $a0, $a0, 1
	sb $zero, ($a0)
	jr $ra
