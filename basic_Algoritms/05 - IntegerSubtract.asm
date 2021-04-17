.data 
	value_1: 18
	value_2: 13
	
.text
	lw $t0, value_1		# Carrega o valor de Value_A para o registrador $t0
	lw $t1, value_2		# Carrega o valor de Value_B para o registrador $t1
	
	sub $s0, $t0, $t1	# Subtrai o valor de value_1 e value_2
	 
	li $v0, 1		# Carregando em $v0 a instrução de impressão de inteiro
	la $a0,($s0)		# Carregando em $a0 o valor do inteiro a ser impresso
	syscall			# Chamada da funçao do sistema