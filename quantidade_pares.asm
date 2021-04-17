# ALGORITMO PARA ENCONTRAR A QUANTIDADE DE NUMEROS PARES DO VETOR

.data 
	vetor: .word 51,7,805,12,801,135,15,20,150,100
	msg: .asciiz "Quantidade de pares: "

.text
numero_de_pares:
	la $s0, vetor			# Carregando o endereço do vetor em $s0
	li $t0, 10			# Inicializando o contador com o valor 10
	li $t3, 0			# t3 sera o contador inicializado com zero

	loop_3:
	lw $t1, ($s0)    		# Carrega valor atual do vetor em $t1
	rem $t4, $t1, 2 		# Faz o resto da divisao do valor atual por 2
	beqz $t4, acres_pares		# Faz a comparacao se o resto da divisao é zero, caso for, pula para a diretiva
	j at_loop_3			# Caso nao seja igual a zero, da um jump para a atualizacao do loop
	
	acres_pares:
	addi $t3, $t3, 1		# Soma +1 ao contador
			
	at_loop_3:
	subi $t0, $t0, 1  		# Decrementa o contador do laco de repeticao
	addi $s0, $s0, 4		# Incrementa o indice do vetor (i++)
	bgtz $t0, loop_3		# Repete enquanto o contador for maior que zero
	
	li $v0, 4			# Carregando instrucao de printar string
	la $a0, msg			# Carregando qual string printar
	syscall				# Chamada de sistema
	li $v0, 1			# Carregando instrucao de printar inteiro
	la $a0, ($t3)			# Carregando qual valor vai printar
	syscall				# Chamada de sistema
