# ALGORITMO PARA ENCONTRAR A SOMA DOS ELEMENTOS IMPARES DO VETOR

.data 
	vetor: .word 51,7,805,12,801,135,15,20,150,100
	msg: .asciiz "Soma dos impares: "

.text
soma_elementos_impares:
	la $s0, vetor			# Carregando o endereço do vetor em $s0
	li $t0, 10			# Inicializando o contador com o valor 10
	
	loop_procura_impar2:
	lw $t1, ($s0)    		# Carrega valor atual do vetor em $t1
	rem $t4, $t1, 2 		# Faz o resto da divisao do valor atual por 2
	beqz $t4, at_loop_procura_impar2# Faz a comparacao se o resto da divisao é zero, caso for, pula para a diretiva
	
	primeiro_impar2:
	lw $s1, ($s0)			# Insere o primeiro par do vetor no registrador de comparacoes futuras	
	j somar_impares			# Depois de pegar o primeiro par, é dado um jump de continuacao do codigo
	
	at_loop_procura_impar2:
	subi $t0, $t0, 1  		# Decrementa o contador do laco de repeticao
	addi $s0, $s0, 4		# Incrementa o indice do vetor (i++)
	bgtz $t0, loop_procura_impar2	# Repete enquanto o contador for maior que zero
	
	somar_impares:
	la $s0, vetor			# Carregando o endereço do vetor em $s0
	li $t0, 10			# Inicializando o contador com o valor 10
	li $t3, 0			# t3 sera o contador inicializado com zero
	
	loop_6:
	lw $t1, ($s0)    		# Carrega valor atual do vetor em $t1
	rem $t4, $t1, 2 		# Faz o resto da divisao do valor atual por 2
	beqz $t4, at_loop_6		# Faz a comparacao se o resto da divisao é zero, caso for, pula para a diretiva
	
	somar_impar:
	add $t3, $t3, $t1		# t3 = t3 + t1			

	at_loop_6:
	subi $t0, $t0, 1  		# Decrementa o contador do laco de repeticao
	addi $s0, $s0, 4		# Incrementa o indice do vetor (i++)
	bgtz $t0, loop_6		# Repete enquanto o contador for maior que zero

	li $v0, 4			# Carregando instrucao de printar string
	la $a0, msg			# Carregando qual string printar
	syscall				# Chamada de sistema
	li $v0, 1			# Carregando instrucao de printar inteiro
	la $a0, ($t3)			# Carregando qual valor vai printar
	syscall				# Chamada de sistema
