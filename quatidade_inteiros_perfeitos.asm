# ALGORITMOS PARA ENCONTRAR A QUANTIDADE DE INTEIROS PERFEITOS

# Um número inteiro é dito perfeito se o dobro dele é igual à soma de todos os seus
# divisores. Por exemplo, como os divisores de 6 são 1, 2, 3 e 6 e 1 + 2 + 3 + 6 = 12, 6 é
# perfeito. A matemática ainda não sabe se a quantidade de números perfeitos é ou não finita.

.data 

vet:

msg1: .asciiz "Leitura do vetor"
msg2: .asciiz "\n\nNumero de elementos do vetor = "
msg3: .asciiz "Vet["
msg4: .asciiz "] = "
msg7: .asciiz "\nNumero de inteiros perfeitos: "

.text
main:
	jal ler_vetor		 	# Procendimento de leitura do vetor
	j inteiros_perfeitos	    	# Procedimento de busca da quantidade de inteiros amigos
	retorno_inteiros_perfeitos: 	# Ponto de retorno para a funcao de inteiros_amigos
	
	li $v0,10		 	# Carregando instrucao de finalizacao de programa
	syscall			 	# Chamada de sistema
	
	
# --- INTEIROS PERFEITOS ---

inteiros_perfeitos:
	la $t0, vet			# Carrega em $t0 o endereço base do vetor
	li $s1, 0			# Inicia com zero o contador de inteiros amigos
	li $t2, 0			# Inicia com zero o contador do loop do vetor
	
loop_inteiros_perfeitos:
	lw $t1, 0($t0)			# Carrega o valor de $t0(valor atual do vetor) para $t1 (auxiliar)
	
	beq $t1, 1, acrescentar_contador_perfeitos # Verifica a excessão (Quando o valor do vetor é igual a 1)
	
	move $a0, $t1			# Move o valor atual do vetor para $a0 (Parametro da funcao seguinte)
	jal somar_divisores		# Chamada de procedimento 
	
	add $t4, $t4, $t1		# Soma o valor atual do vetor com a somatoria de seus 
	move $a0, $t1			# Carrega para $0 o valor atual do vetor
	mul $a0, $a0, 2			# Multiplica o valor por 2
	   
	bne $t4, $a0, acrescentar_contador_perfeitos # Verifica se o valor é perfeito ou não 
	
	addi $s5, $s5, 1		# Aumenta o contador de numeros perfeitos
	
	acrescentar_contador_perfeitos:
	addi $t0, $t0, 4		# Aponta para a proxima instrução
	addi $t2, $t2, 1		# Aumenta o contador em +1
	blt $t2, $s0, loop_inteiros_perfeitos	# Verifica se deve continuar no loop

	la $a0, msg7			# Carrega endereço da mensagem 7
	li $v0, 4			# Carrega instrução para printar string
	syscall				# Chamada de sistema
	
	li $v0, 1			# Carrega instrucao para printar inteiro
	move $a0, $s5			# Move o contador de inteiros perfeitos para printar 
	syscall				# Chamada de sistema
				 
	j retorno_inteiros_perfeitos	# Retorna para a main


# --- SOMAR DIVISORES ---

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