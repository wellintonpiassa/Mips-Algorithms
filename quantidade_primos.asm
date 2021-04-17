# ALGORITMO PARA ENCONTRAR A QUANTIDADE DE NUMEROS QUE SAO PRIMOS NO VETOR

.data 

vet:

msg1: .asciiz "Leitura do vetor"
msg2: .asciiz "\n\nNumero de elementos do vetor = "
msg3: .asciiz "Vet["
msg4: .asciiz "] = "
msg5: .asciiz "\nNumero de inteiros primos: "


.text
main:
	jal ler_vetor		 	# Procendimento de leitura do vetor
	jal primos		 	# Procedimento de busca da quantidade de inteiros primos 

	li $v0,10		 	# Carregando instrucao de finalizacao de programa
	syscall			 	# Chamada de sistema
	

# ----- NUMEROS PRIMOS -----	

# s3: Contador de primos
# t0: endereço base do vetor
# t1: Contador do loop de divisores
# t2: Guarda o valor da posicao atual do vetor
# t4: Contador do loop principal que percorre os elementos do vetor
# t5: resto da divisao

primos:
	la $t0, vet			# Carrega em $t0 o endereço base do vetor
	li $t4, 1  			# Inicia o contador com 1
	  
loop_primos:
	lw $t2, 0($t0)			# Carrega valor atual do vetor para $t2 (auxiliar)
	
	beq $t2, 1, excessao1		# Verifica se o valor atual do vetor é igual a 1 (Caso de excessao)
	beq $t2, 2, excessao2		# Verifica se o valor atual do vetor é igual a 2 (Caso de excessao)
	
	li $t1, 2 			# Carrega o valor 2 a qual o loop se inicia
	loop_verifica_primo:		
	rem $t5, $t2, $t1		# Divide $t2 por $t1 e o resto coloca em $t5 para verificação
	beqz $t5, incrementa_contador	# Verifica se o resto da divisao anterior é igual a zero
	
	addi $t1, $t1, 1		# Acrescenta o contador do loop de divisores
	blt $t1, $t2, loop_verifica_primo # if($t1 < $t2)
	
	addi $s3, $s3, 1		# Acrescenta o contador de primos
	
	incrementa_contador:
	addi $t4,$t4,1 			# Incrementa o contador do loop do vetor
	addi $t0, $t0, 4		# Aponta para o proximo elemento do vetor
	bgt $t4, $s0, fim_loop_primos	# Verifica se chegou ao final do loop
	j loop_primos			# Caso ainda não tenha chego ao final, ocorre um salto para o loop
	
excessao1:
	addi $t4,$t4,1			# Incrementa o contador do loop dos elementos vetor
	bgt $t4, $s0, fim_loop_primos	# Verifica se deve voltar para o loop	
	addi $t0, $t0,4			# Aponta para o proximo elemento do vetor
	j loop_primos			# Caso precisa, salta para o loop

excessao2:
	addi $s3, $s3, 1		# Verifica se deve voltar para o loop
	bgt $t4, $s0, fim_loop_primos	# Caso precisa, salta para o loop	
	addi $t0, $t0,4			# Aponta para o proximo elemento do vetor 
	j loop_primos			# Caso precisa, salta para o loop	
	
fim_loop_primos: 			
	la $a0, msg5			# Carrega a mensagem a ser impressa
	li $v0, 4			# Carrega a instrução a ser impressa
	syscall				# Chamada de sistema
	
	li $v0, 1			# Carrega instrucao de printar inteiro
	move $a0, $s3			# Carrega o valor a ser impresso 
	syscall				# Chamada de sistema
	jr $ra				# Salta de volta para a funcao chamadora



# ----- LEITURA DO VETOR -----

ler_vetor:
	la $t3, vet		# Carregando em $t3 o endereço base do vetor (Ponteiro para vet)
	
	li $v0, 4		# Carregando instrucao para printar string
	la $a0, msg1		# Carregando endereço da mensagem 1
	syscall			# Chamada de sistema
	
	la $a0, msg2		# Carregando endereço da mensagem 2
	syscall			# Chamada de sistema
	
	li $v0, 5		# Carregando instrucao de leitura
	syscall			# Chamada de sistema
	
	move $s0, $v0		# Movendo para $s0 o valor que foi lido pelo usuario
	addi $t1, $zero,1	# Contador de elementos do vetor
	
	loop:
	
	li $v0, 4		# Carregando instrucao de printar string
	la $a0, msg3		# Carregando mensagem para printar
	syscall			# Chamada de sistema
	
	li $v0, 1		# Carregando instrucao de printar inteiro
	move $a0, $t1		# Carregando valor para printar
	syscall			# Chamada de sistema
	
	li $v0,4		# Carregando instrucao de printar string
	la $a0, msg4		# Carregando mensagem para printar
	syscall 		# Chamada de sistema
	
	li $v0, 5		# Recebendo um inteiro do usuario
	syscall			# Chamada de sistema

	move $t2, $v0		# Movendo valor lido para $t2
	sw $t2, 0($t3)		# Salvando no vetor o valor lido 
	addi $t3, $t3, 4	# Apontando para a proxima posicao do vetor
	addi $t1, $t1, 1	# Acrescentando o contador em +1
	
	bgt $t1, $s0, fim_loop	# Verifica se contador é maior que valor maximo do vetor
	j loop			# Caso seja menor, slata para o loop novamente
	
fim_loop:
	jr $ra			# Retorna para o procedimento que chamou
