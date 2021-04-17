# ALGORITMO PARA ENCONTRAR O PRODUTO DOS ELEMENTOS PARES DO VETOR

.data
	vetor: .word 1,2,3,4,5,6,7,8,9,10
	msg: .asciiz "Produto dos pares: "

.text
produto_elementos_pares:	
	la $s0, vetor			# Carregando o endereço do vetor em $s0
	li $t0, 10			# Inicializando o contador com o valor 9
	
	loop_procura_par2:
	lw $t1, ($s0)    		# Carrega valor atual do vetor em $t1
	rem $t4, $t1, 2 		# Faz o resto da divisao do valor atual por 2
	beqz $t4, primeiro_par2		# Faz a comparacao se o resto da divisao é zero, caso for, pula para a diretiva
	addi $s0, $s0, 4		# Incrementa o indice do vetor (i++)
	j at_loop_procura_par2		# Caso nao seja igual a zero, da um jump para a atualizacao do loop
	
	primeiro_par2:
	lw $s1, ($s0)			# Insere o primeiro par do vetor no registrador de comparacoes futuras	
	j produto_dos_pares		# Depois de pegar o primeiro par, é dado um jump de continuacao do codigo
	
	at_loop_procura_par2:
	subi $t0, $t0, 1  		# Decrementa o contador do laco de repeticao
	bgtz $t0, loop_procura_par2	# Repete enquanto o contador for maior que zero
	
	produto_dos_pares:		
	la $s0, vetor			# Carregando o endereço do vetor em $s0
	li $t0, 10			# Inicializando o contador com o valor 9
	li $t3, 1			# t3 sera o contador inicializado com zero
	
	loop_7:
	lw $t1, ($s0)    		# Carrega valor atual do vetor em $t1
	rem $t4, $t1, 2 		# Faz o resto da divisao do valor atual por 2
	beqz $t4, calcular_produto	# Faz a comparacao se o resto da divisao é zero, caso for, pula para a diretiva
	j at_loop_7			# Caso nao seja igual a zero, da um jump para a atualizacao do loop
	
	calcular_produto:
	mul $t3, $t3, $t1 
	
	at_loop_7:
	subi $t0, $t0, 1  		# Decrementa o contador do laco de repeticao
	addi $s0, $s0, 4		# Incrementa o indice do vetor (i++)
	bgtz $t0, loop_7		# Repete enquanto o contador for maior que zero
	
	li $v0, 4			# Carregando instrucao de printar string
	la $a0, msg			# Carregando qual string printar
	syscall				# Chamada de sistema
	li $v0, 1			# Carregando instrucao de printar inteiro
	la $a0, ($t3)			# Carregando qual valor vai printar
	syscall				# Chamada de sistema
