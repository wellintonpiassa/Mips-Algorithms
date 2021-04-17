# ALGORITMO PARA ENCONTRAR O MAIOR ELEMENTO PAR DO VETOR

.data 
	vetor: .word 51,7,806,12,801,135,15,20,150,100
	msg: .asciiz "Maior elemento par: "

.text
maior_elemento_par:
	la $s0, vetor			# Carregando o endereço do vetor em $s0
	li $t0, 10			# Inicializando o contador com o valor 9
	
	loop_procura_par1:
	lw $t1, ($s0)    		# Carrega valor atual do vetor em $t1
	rem $t4, $t1, 2 		# Faz o resto da divisao do valor atual por 2
	beqz $t4, primeiro_par1		# Faz a comparacao se o resto da divisao é zero, caso for, pula para a diretiva
	addi $s0, $s0, 4		# Incrementa o indice do vetor (i++)
	j at_loop_procura_par1		# Caso nao seja igual a zero, da um jump para a atualizacao do loop
	
	primeiro_par1:
	lw $s1, ($s0)			# Insere o primeiro par do vetor no registrador de comparacoes futuras	
	j procurar_maior_par		# Depois de pegar o primeiro par, é dado um jump de continuacao do codigo
	
	at_loop_procura_par1:
	subi $t0, $t0, 1  		# Decrementa o contador do laco de repeticao
	bgtz $t0, loop_procura_par1	# Repete enquanto o contador for maior que zero
	
	procurar_maior_par:
	la $s0, vetor			# Carregando o endereço do vetor em $s0
	li $t0, 9			# Inicializando o contador com o valor 9
	
	loop_4:
	addi $s0, $s0, 4		# Incrementa o indice do vetor (i++)
	lw $t1, ($s0)    		# Carrega valor atual do vetor em $t1
	rem $t4, $t1, 2 		# Faz o resto da divisao do valor atual por 2
	beqz $t4, maior_par		# Faz a comparacao se o resto da divisao é zero, caso for, pula para a diretiva
	j at_loop_4			# Caso nao seja igual a zero, da um jump para a atualizacao do loop
	
	maior_par:
	bge $t1, $s1, muda_maior_par  	# Verifica se o valor do vetor[i+1] e maior do que o maior atual
	j at_loop_4
	
	muda_maior_par:
	lw $s1, ($s0)

	at_loop_4:
	subi $t0, $t0, 1  		# Decrementa o contador do laco de repeticao
	bgtz $t0, loop_4		# Repete enquanto o contador for maior que zero
	
	li $v0, 4			# Carregando instrucao de printar string
	la $a0, msg			# Carregando qual string printar
	syscall				# Chamada de sistema
	li $v0, 1			# Carregando instrucao de printar inteiro
	la $a0, ($s1)			# Carregando qual valor vai printar
	syscall				# Chamada de sistema
