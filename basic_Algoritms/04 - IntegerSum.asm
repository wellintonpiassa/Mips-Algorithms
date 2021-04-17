.data 
	value_A: .word 75	# Define o valor 75 para a Value_A
	value_B: .word 25	# Define o valor 25 para a Value_B

.text 
	lw $t0, value_A		# Carrega o valor de Value_A para o registrador $t0
	lw $t1, value_B		# Carrega o valor de Value_B para o registrador $t1
	
	add $s0, $t0, $t1	# Somando os valores do registrador $t0 e $t1 e colocando resultado em $s0
	
	li $v0, 1		# Carregando em $v0 a instrução de impressão de inteiro
	la $a0,($s0)		# Carregando em $a0 o valor do inteiro a ser impresso
	syscall			# Chamada da funçao do sistema
