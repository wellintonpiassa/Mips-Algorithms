# ALGORITMO FATORIAL RECURSIVO

.text
main:
	li $a0, 3		# Carregando $a0 com o valor fatorial a ser calculado
	jal fatorial		# Chamada da subrotina para calcular fatorial
	
	move $a0, $v0		# Carrega em $a0 o retorno da subrotina, que e justamente o resultado do fatorial
	li $v0, 1		# Carregando instrucao para printar inteiro
	syscall			# Chamada de sistema
	
	li $v0, 10		# Carregando instrucao para finalizar programa
	syscall			# Chamada de sistema


fatorial:
	addi $sp, $sp, -8	# Colocaremos 2 itens na pilha
	sw $ra, 4 ($sp)		# Salvamoso endereço de retorno
	sw $a0, 0 ($sp)		# Salvamos o argumento n
	
	slti $t0, $a0, 1	# n e menor que 1?
	beq $t0, $zero, L1	# vai para L1 se (n >= 1)
	
	addi $v0, $zero, 1	# retorna 1 se (n < 1)
	addi $sp, $sp, 8	# retira dois itens da pilha
	jr $ra			# retorna
	
	L1:
	addi $a0, $a0, -1	# (n-1) se (n>=1)
	jal fatorial		# chama fatorial novamente com argumento decrementado
	
	lw $a0, 0($sp)		# restaura o argumento n
	lw $ra, 4($sp)		# restaura o endereco de retorno
	addi $sp, $sp, 8	# Ajusta stack pointer - retira dois itens da pilha
	
	mul $v0, $a0, $v0	# retorna n * fatorial (n-1)
	jr $ra			# retorna para procedimento que chamou