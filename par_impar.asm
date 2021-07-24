# ALGORITMO PARA VERIFICAR SE O VALOR INSERIDO PELO USUARIO É PAR OU IMPAR

.data
	msgInput: .asciiz "\nDigite um numero inteiro: "
	msgPar:   .asciiz "\nO numero digitado é par. "	
	msgImpar: .asciiz "\nO numero digitado é impar. "
	
.text
main:
	li $v0, 4 # Impressao da msgInput
	la $a0, msgInput
	syscall
	
	li $v0, 5 # Leitura do valor inteiro 
	syscall
	
	move $t0, $v0 	# Carrega em $t0 o valor lido
	div $t1,$t0, 2	# Divide o valor lido por 2
	mfhi $a2	# Foi movido o resto para $a2
	
	beq $a2, $zero, par
	bne $a2, $zero, impar
	
par: 
	li $v0, 4
	la $a0, msgPar
	syscall
	j fim
	
impar:
	li $v0,4 
	la $a0, msgImpar
	syscall
	j fim
	
fim:
	li $v0, 10
	syscall	
