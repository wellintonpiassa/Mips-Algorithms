# ALGORITMO PARA ENCONTRAR A QUANTIDADE DE INTEIROS AMIGOS

# Dois números inteiros são ditos amigos se a soma dos divisores de cada um deles
# (menores que eles) é igual ao outro. Por exemplo, os divisores de 220 são 1, 2, 4, 5, 10,11, 20, 22, 44, 55 e 110 e 1 + 2 + 4+ 5 + 10 + 11 + 20 + 22 + 44 + 55 + 110 = 284 
# e os divisores de 284 são 1, 2, 4, 71 e 142 e 1 + 2 + 4 + 71 + 142 = 220.

.data 

vet:

msg1: .asciiz "Leitura do vetor"
msg2: .asciiz "\n\nNumero de elementos do vetor = "
msg3: .asciiz "Vet["
msg4: .asciiz "] = "
msg6: .asciiz "\nNumero de inteiros amigos: "

.text
main:
	jal ler_vetor		 	# Procendimento de leitura do vetor
	j inteiros_amigos	 	# Procedimento de busca da quantidade de inteiros amigos
	retorno_inteiros_amigos: 	# Ponto de retorno para a funcao de inteiros_amigos
	
	li $v0,10		 	# Carregando instrucao de finalizacao de programa
	syscall			 	# Chamada de sistema

# ----- INTEIROS AMIGOS -----

# s1: Contador de inteiros amigos

# t0: Endereço base do vetor
# t1: Carrega o valor da posicao atual do vetor
# t2: Contador do loop do vetor
# t4: Guarda a soma dos valores divisiveis

inteiros_amigos:
	la $t0, vet			# Carrega em $t0 o endereço base do vetor
	li $s1, 0			# Inicia com zero o contador de inteiros amigos
	li $t2, 0			# Inicia com zero o contador do loop do vetor
	
loop_inteiros_amigos:
	lw $t1, 0($t0)			# Carrega o valor de $t0(valor atual do vetor) para $t2 (auxiliar)
	
	beq $t1, 1, acrescentar_contador_amigos	# Verifica a excessão (Quando o valor do vetor é igual a 1)
	
	move $a0, $t1			# Move o valor atual do vetor para $a0 (Parametro da funcao seguinte)
	jal somar_divisores		# Chamada de procedimento
		
	move $a0, $t4			# Move o valor atual do vetor para $a0 (Parametro da funcao seguinte) 
	jal somar_divisores		# Chamada de procedimento 
	   
	bne $t4, $t1, acrescentar_contador_amigos # Verifica é um amigo ou não
	
	addi $s1, $s1, 1		# Acrescenta +1 no contador de inteiros amigos
	
	acrescentar_contador_amigos:
	addi $t0, $t0, 4		# Apontando para a proxima posicao do vetor
	addi $t2, $t2, 1		# Acrescenta +1 ao contador
	blt $t2, $s0, loop_inteiros_amigos # Verifica se deve continuar no loop

	la $a0, msg6			# Carregando mensagem 6 para printar
	li $v0, 4			# Carrega instrução de printar string
	syscall				# Chamada de sistema
	
	li $v0, 1			# Carrega instrucao de printar inteiro
	move $a0, $s1			# Move o valor do inteiros amigos a ser printado
	syscall				# Chamada de sistema
				 
	j retorno_inteiros_amigos	# Retorna para a main



# ---- SOMAR DIVISORES ----
# a0: Carrega valor do vetor
# t3: Guarda os valores que vao ser divididos pelo valor atual do vetor
# t4: Guarda a soma dos valores divisiveis
# t5: Guarda a quantidade maxima que o loop executa (vet[i] / 2)
# t6: Guarda o resto da divisao 

somar_divisores:
	
	li $t3, 2			# Iniciando registrado que ira conter o valores da divisao
	li $t4, 1			# Definindo 1 para o registrador que ira guardar o somatorio
	div $t5, $a0, 2			# Contador de quantas vezes o loop do somatório ira acontecer
	
	loop_somar_divisores:
	rem $t6, $a0, $t3		# Divide $a0 por $t3 e o resto coloca em $t6 para verificação
	beqz $t6, somar_div		# Verifica se o resto da divisao anterior é igual a zero
	addi $t3, $t3, 1		# Acrescenta +1 nos valor que vai ser dividido pela posicao atual do vetor
	ble $t3, $t5, loop_somar_divisores	# Se o divisor atual for menor ou igual ao valor maximo($t5), o loop continua
	 
	jr $ra
	 
	somar_div:
	add $t4, $t4, $t3		# Soma o valor divisivel no registrador $t4
	addi $t3, $t3, 1		# Acrescenta +1 nos valor que vai ser dividido pela posicao atual do vetor
	ble $t3, $t5, loop_somar_divisores	# Se o divisor atual for menor ou igual ao valor maximo($t3), o loop continua
	
	jr $ra


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
