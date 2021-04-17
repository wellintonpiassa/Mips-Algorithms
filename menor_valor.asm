# ALGORITMO PARA ENCONTRAR O MENOR VALOR DO VETOR

.data
	vetor: .word 51,7,805,12,801,135,15,20,150,1
	msg: .asciiz "Menor elemento: "

.text
menor_elemento_vetor:
	la $s0, vetor			# Carregando o endereço do vetor em $s0
	li $t0, 9			# Iniciaizando o contador com o valor 9
	lw $s1, ($s0)			# Carrega o valor que esta na memoria (vetor[i])
	
	loop_2:		
	addi $s0, $s0, 4		# Incrementa o indice do vetor (i++)
	lw $t1, ($s0)    		# Carrega valor atual do vetor em $t1
	ble $t1, $s1, mudar_menor   	# Verifica se o valor do vetor[i+1] e maior do que o maior atual
	j at_loop_2			# Caso nao tenha que mudar o valor, pulamos para atualizar o loop
					
	mudar_menor: 
	lw $s1, ($s0)			# Faz a troca entre o maior atual e o vetor[i+1]
	
	at_loop_2:
	subi $t0, $t0, 1  		# Decrementa o contador do laco de repeticao
	bgtz $t0, loop_2		# Repete enquanto o contador for maior que zero
	
	li $v0, 4			# Carregando instrucao de printar string
	la $a0, msg			# Carregando qual string printar
	syscall				# Chamada de sistema
	li $v0, 1			# Carregando instrucao de printar inteiro
	la $a0, ($s1)			# Carregando qual valor vai printar
	syscall				# Chamada de sistema
