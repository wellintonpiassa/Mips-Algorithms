# ALGORITMO PARA ENCONTRAR E DESTACAR NUMEROS PRIMOS
# O algoritmo busca todos os numeros primos do vetor X (que é lido do usuario) e adiciona-os no Vetor Y.
# No final do programa, são impressos os numeros impares que estao contidos no vetor Y.

.data 

X: .space 60		# 15 posicoes * 4bytes para cada inteiro
Y: .space 60		# 15 posicoes * 4bytes para cada inteiro

msg1: .asciiz "Vet["
msg2: .asciiz "] = "
msg3: .asciiz "\nNumero de inteiros primos: "
msg4: .asciiz "\nPrimos: { "
msg5: .asciiz " "
msg6: .asciiz "}\n"
# ---- MAIN ----
# s1: Quantidade de posicoes do vetor X

.text
main:
	li $s1, 15			# Definindo a quantidade de posicoes do Vetor

	jal ler_vetor		 	# Procendimento de leitura de dados do vetor
	jal primos		 	# Procedimento de busca da quantidade de inteiros primos 
	jal printar_vetor		# Procedimento para printar os elementos primos

	li $v0,10		 	# Carregando instrucao de finalizacao de programa
	syscall			 	# Chamada de sistema para finalizar programa
	


# ----- DETECTANDO PRIMOS -----	

# s0: Endereço base do vetor Y
# s3: Contador de primos / Quantidade de elementos do vetor Y

# t0: endereço base do vetor
# t1: Contador do loop de divisores
# t2: Guarda o valor da posicao atual do vetor
# t4: Contador do loop principal que percorre os elementos do vetor
# t5: resto da divisao

primos:
	la $t0, X			# Carrega em $t0 o endereço base do vetor X
	li $t4, 1  			# Inicia o contador com 1
	la $s0, Y			# Carrega em $s0 o endereço base do vetor Y
	  
loop_primos:
	lw $t2, ($t0)			# Carrega valor atual do vetor para $t2 (auxiliar)
	
	beq $t2, 1, excessao1		# Verifica se o valor atual do vetor é igual a 1 (Caso de excessao)
	beq $t2, 2, excessao2		# Verifica se o valor atual do vetor é igual a 2 (Caso de excessao)
	
	li $t1, 2 			# Carrega o valor 2 a qual o loop se inicia
	loop_verifica_primo:		
	rem $t5, $t2, $t1		# Divide $t2 por $t1 e o resto coloca em $t5 para verificação
	beqz $t5, incrementa_contador	# Verifica se o resto da divisao anterior é igual a zero
	
	addi $t1, $t1, 1		# Acrescenta o contador do loop de divisores
	blt $t1, $t2, loop_verifica_primo # if($t1 < $t2)
	
	# Nessa parte, adiciona o valor atual no novo vetor de primos e remover linha de baixo
	sw $t2, ($s0)			# Adicionando valor no vetor de primos
	add $s0, $s0, 4			# Aponta para o proximo elemento do vetor Y
	addi $s3, $s3, 1		# Acrescenta o contador de primos
	
	incrementa_contador:
	addi $t4, $t4, 1 		# Incrementa o contador do loop do vetor
	bgt $t4, $s1, fim_loop_primos	# Verifica se chegou ao final do loop
	addi $t0, $t0, 4		# Aponta para o proximo elemento do vetor
	j loop_primos			# Caso ainda não tenha chego ao final, ocorre um salto para o loop
	
excessao1:
	addi $t4,$t4,1			# Incrementa o contador do loop dos elementos vetor
	bgt $t4, $s1, fim_loop_primos	# Verifica se deve voltar para o loop	
	addi $t0, $t0,4			# Aponta para o proximo elemento do vetor
	j loop_primos			# Caso precisa, salta para o loop

excessao2:
	# Nessa parte, adiciona o valor atual no novo vetor de primos
	sw $t2, ($s0)			# Adicionando valor no vetor de primos
	add $s0, $s0, 4			# Aponta para o proximo elemento do vetor Y
	addi $s3, $s3, 1		# Incremento do contador do numero de primos
	
	addi $t4,$t4,1			# Incrementa o contador do loop dos elementos vetor
	bgt $t4, $s1, fim_loop_primos	# Caso precisa, salta para o loop	
	addi $t0, $t0,4			# Aponta para o proximo elemento do vetor X
	j loop_primos			# Caso precisa, salta para o loop	
	
fim_loop_primos: 			
	jr $ra				# Salta de volta para a funcao chamadora



# ----- LEITURA DO VETOR ESTATICO -----

# t1: Contador iniciando em 0
# t2: auxiliar para valor lido do usuario
# t3: Copia do endereço base do vetor

# v0: usado nas instrucoes de syscall pra obter codigos de acoes
# a0: usado nas instrucoes de syscall para argumentos

ler_vetor:
	la $t3, X		# Carregando em $t3 o endereço base do vetor (Ponteiro para X)
	li $t1, 0		# Iniciando contador com zero
	
	loop:
	
	li $v0, 4		# Carregando instrucao de printar string
	la $a0, msg1		# Carregando mensagem para printar
	syscall			# Chamada de sistema
	
	li $v0, 1		# Carregando instrucao de printar inteiro
	move $a0, $t1		# Carregando valor para printar
	syscall			# Chamada de sistema
	
	li $v0,4		# Carregando instrucao de printar string
	la $a0, msg2		# Carregando mensagem para printar
	syscall 		# Chamada de sistema
	
	li $v0, 5		# Recebendo um inteiro do usuario
	syscall			# Chamada de sistema

	move $t2, $v0		# Movendo valor lido para $t2
	sw $t2, 0($t3)		# Salvando no vetor o valor lido 
	addi $t3, $t3, 4	# Apontando para a proxima posicao do vetor
	addi $t1, $t1, 1	# Acrescentando o contador em +1
	
	beq $t1, $s1, fim_loop	# Verifica se contador é igual ao tamanho maximo do vetor
	j loop			# Caso seja menor, slata para o loop novamente
	
fim_loop:
	jr $ra			# Retorna para o procedimento que chamou



# ----- PRINTAR VETOR DE PRIMOS -----

# t1: Contador iniciando em 0
# t2: auxiliar para valor lido do usuario
# t3: Copia do endereço base do vetor

# v0: usado nas instrucoes de syscall pra obter codigos de acoes
# a0: usado nas instrucoes de syscall para argumentos

printar_vetor:
	la $t3, Y		# Carregando em $t3 o endereço base do vetor (Ponteiro para X)
	li $t1, 0		# Iniciando contador com zero
	
	# Printando a quantidade de elementos primos 
	la $a0, msg3			# Carrega a mensagem a ser impressa
	li $v0, 4			# Carrega a instrução a ser impressa
	syscall				# Chamada de sistema
	
	li $v0, 1			# Carrega instrucao de printar inteiro
	move $a0, $s3			# Carrega o valor a ser impresso 
	syscall				# Chamada de sistema
		
	# Printando elementos do vetor Y
	li $v0, 4		# Carregando instrucao de printar string
	la $a0, msg4		# Carregando mensagem para printar
	syscall			# Chamada de sistema
	
	loop_print:
	
	li $v0, 1		# Carregando instrucao de printar inteiro 
	lw $a0, ($t3)		# Carregando valor para printar
	syscall			# Chamada de sistema
	
	li $v0,4		# Carregando instrucao de printar string
	la $a0, msg5		# Carregando mensagem para printar
	syscall 		# Chamada de sistema

	addi $t3, $t3, 4	# Apontando para a proxima posicao do vetor
	addi $t1, $t1, 1	# Acrescentando o contador em +1
	
	beq $t1, $s3, fim_print	# Verifica se contador é igual ao tamanho maximo do vetor
	j loop_print			# Caso seja menor, slata para o loop novamente
	
fim_print:
	li $v0, 4		# Carregando instrucao de printar string
	la $a0, msg6		# Carregando mensagem para printar
	syscall			# Chamada de sistema
	jr $ra			# Retorna para o procedimento que chamou