# ALGORITMO PARA ENCONTRAR O MENOR ELEMENTO IMPAR DO VETOR

.data 
	vetor: .word 51,7,805,12,0,135,15,20,150,100
	msg: .asciiz "Menor elemento impar: "

.text
menor_elemento_impar:
	la $s0, vetor			# Carregando o endereço do vetor em $s0
	li $t0, 10			# Inicializando o contador com o valor 9
	
	loop_procura_impar1:
	lw $t1, ($s0)    		# Carrega valor atual do vetor em $t1
	rem $t4, $t1, 2 		# Faz o resto da divisao do valor atual por 2
	beqz $t4, at_loop_procura_impar1# Faz a comparacao se o resto da divisao é zero, caso for, pula para a diretiva
	
	primeiro_impar1:
	lw $s1, ($s0)			# Insere o primeiro par do vetor no registrador de comparacoes futuras	
	j procurar_menor_impar		# Depois de pegar o primeiro par, é dado um jump de continuacao do codigo
	
	at_loop_procura_impar1:
	subi $t0, $t0, 1  		# Decrementa o contador do laco de repeticao
	addi $s0, $s0, 4		# Incrementa o indice do vetor (i++)
	bgtz $t0, loop_procura_impar1	# Repete enquanto o contador for maior que zero
	
	procurar_menor_impar:
	la $s0, vetor			# Carregando o endereço do vetor em $s0
	li $t0, 10			# Inicializando o contador com o valor 9
	
	loop_5:
	lw $t1, ($s0)    		# Carrega valor atual do vetor em $t1
	rem $t4, $t1, 2 		# Faz o resto da divisao do valor atual por 2
	beqz $t4, at_loop_5		# Faz a comparacao se o resto da divisao é zero, caso for, pula para a diretiva
	
	menor_impar:
	ble $t1, $s1, muda_menor_impar	# Verifica se o valor do vetor[i+1] e maior do que o maior atual
	j at_loop_5
	
	muda_menor_impar:
	lw $s1, ($s0)

	at_loop_5:
	subi $t0, $t0, 1  		# Decrementa o contador do laco de repeticao
	addi $s0, $s0, 4		# Incrementa o indice do vetor (i++)
	bgtz $t0, loop_5		# Repete enquanto o contador for maior que zero
	
	li $v0, 4			# Carregando instrucao de printar string
	la $a0, msg			# Carregando qual string printar
	syscall				# Chamada de sistema
	li $v0, 1			# Carregando instrucao de printar inteiro
	la $a0, ($s1)			# Carregando qual valor vai printar
	syscall				# Chamada de sistema
