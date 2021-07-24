# ALGORITMO DE SOMA DE POSICOES DO VETOR
# O algoritmo calcula a soma dos elementos das posicoes pares do VetA e a soma dos elementos de posicoes impares do VetB.

.data
VetA: .space 40		# 10 posicoes * 4 bytes
VetB: .space 40		# 10 posicoes * 4 bytes

msg1: .asciiz "VetA["
msg2: .asciiz "VetB["
msg3: .asciiz "] = "
msg4: .asciiz "\n"

msg5: .asciiz "Soma dos elementos das posicoes pares do VetA: "
msg6: .asciiz "Soma dos elementos das posicoes impares do VetB: "


.text
# ---- MAIN ----

# $s0: Quantidade de elementos do VetA
# $s1: Quantidade de elementos do VetB

# $a1, $a2, $a3: Usados para argumentos

main:
	li $s0, 10			# Definindo quantidade de elementos do VetA
	li $s1, 10			# Definindo quantidade de elementos do VetB
	
	la $a1, VetA			# Carregando endereço base do VetA para usar na rotina
	move $a2, $s0			# Carregando quantidade de elementos para passar como argumento
	la $a3, msg1			# Carregando memoria adequada para passar como argumento
	jal ler_vetor			# Chamada de rotina para leitura do vetor VetA

	la $a1, VetB			# Carregando endereço base do VetB para usar na rotina
	move $a2, $s1			# Carregando quantidade de elementos para passar como argumento
	la $a3, msg2			# Carregando memoria adequada para passar como argumento
	jal ler_vetor			# Chamada de rotina para leitura do vetor VetB
	
	la $a1, VetA			# Carregando endereço base do VetA para usar na rotina
	move $a2, $s0			# Carregando quantidade de elementos para passar como argumento
	jal somar_posicoes_pares	# Chamada de rotina para calcular a soma dos elementos de posicoes pares do vetor

	la $a1, VetB			# Carregando endereço base do VetB para usar na rotina
	move $a2, $s1			# Carregando quantidade de elementos para passar como argumento
	jal somar_posicoes_impares	# Chamada de rotina para calcular a soma dos elementos de posicoes impares do vetor

	li $v0,10		 	# Carregando instrucao de finalizacao de programa
	syscall			 	# Chamada de sistema para finalizar programa
	


# ----- LEITURA DO VETOR ESTATICO -----

# t0: Copia do endereço base do vetor
# t1: Contador iniciando em 0
# t2: auxiliar para valor lido do usuario

# a1: Endereço base do vetor (Parametro)
# a2: Tamanho do vetor (Parametro)
# a3: Mensagem personalizada do vetor (Parametro)

# v0: usado nas instrucoes de syscall pra obter codigos de acoes
# a0: usado nas instrucoes de syscall para argumentos

ler_vetor:
	la $t0, ($a1)		# Carregando em $t0 o endereço base do vetor (Ponteiro para VetA)
	li $t1, 0		# Iniciando contador com zero
	
	loop_leitura:
	li $v0, 4		# Carregando instrucao de printar string
	la $a0, ($a3)		# Carregando mensagem para printar
	syscall			# Chamada de sistema
	
	li $v0, 1		# Carregando instrucao de printar inteiro
	move $a0, $t1		# Carregando valor para printar
	syscall			# Chamada de sistema
	
	li $v0,4		# Carregando instrucao de printar string
	la $a0, msg3		# Carregando mensagem para printar
	syscall 		# Chamada de sistema
	
	li $v0, 5		# Recebendo um inteiro do usuario
	syscall			# Chamada de sistema

	move $t2, $v0		# Movendo valor lido para $t2
	sw $t2, 0($t0)		# Salvando no vetor o valor lido 
	addi $t0, $t0, 4	# Apontando para a proxima posicao do vetor
	addi $t1, $t1, 1	# Acrescentando o contador em +1
	
	beq $t1, $a2, fim_loop	# Verifica se contador é igual ao tamanho maximo do vetor
	j loop_leitura		# Caso seja menor, slata para o loop novamente
	
fim_loop:
	li $v0,4		# Carregando instrucao de printar string
	la $a0, msg4		# Carregando mensagem para printar
	syscall 		# Chamada de sistema
	jr $ra			# Retorna para o procedimento que chamou



# ---- SOMAR ELEMENTOS DE POSICOES PARES DO VETOR ----

# $a1: Endereço base do vetor (Parametro)
# $a2: Quantidade de elementos do vetor (Parametro)

# $t0: Copia do endereço base do vetor
# $t1: Contador de iteracoes no loop
# $t2: Valor da posicao atual do vetor
# $t3: Resto da divisao

# $s2: Somatorio dos elementos de posicoes pares

somar_posicoes_pares:
	la $t0, ($a1)		# Carregando em $t0 o endereço base do vetor (Ponteiro para VetA)
	li $t1, 0		# Iniciando contador com zero	
	li $s2, 0		# Setando o valor do somador com 0
	
	loop_pares:
	lw $t2, ($t0)		# Carrega valor atual do vetor para $t2 (auxiliar)	
	
	rem $t3, $t1, 2		# Dividindo a posicao do vetor por 2 para descobrir se a posicao do vetor é par 
	bnez $t3, inc_loop_par  # Se o resto da divisao nao for zero, entao a posicao atual do vetor é impar e podemos somente continuar o loop
	
	add $s2, $s2, $t2	# Somando o elemento atual do vetor ao somador de elementos

	inc_loop_par:
	addi $t1, $t1, 1	# Incrementando contador
	addi $t0, $t0, 4	# Mudando o ponteiro para a proxima posicao do vetor
	blt $t1, $a2, loop_pares# if (count < vet.size)
	
	# Printando o resultado
	li $v0,4		# Carregando instrucao de printar string
	la $a0, msg5		# Carregando mensagem para printar
	syscall 		# Chamada de sistema
	
	li $v0, 1		# Carregando instrucao de printar inteiro
	move $a0, $s2		# Carregando valor para printar
	syscall			# Chamada de sistema
	
	li $v0,4		# Carregando instrucao de printar string
	la $a0, msg4		# Carregando mensagem para printar
	syscall 		# Chamada de sistema
	
	jr $ra			# Salta de volta para a funcao chamadora




# ---- SOMAR ELEMENTOS DE POSICOES IMPARES DO VETOR ----

# $a1: Endereço base do vetor (Parametro)
# $a2: Quantidade de elementos do vetor (Parametro)

# $t0: Copia do endereço base do vetor
# $t1: Contador de iteracoes no loop
# $t2: Valor da posicao atual do vetor
# $t3: Resto da divisao

# $s3: Somatorio dos elementos de posicoes pares

somar_posicoes_impares:
	la $t0, ($a1)		# Carregando em $t0 o endereço base do vetor (Ponteiro para VetA)
	li $t1, 0		# Iniciando contador com zero	
	li $s3, 0		# Setando o valor do somador com 0
	
	loop_impares:
	lw $t2, ($t0)		# Carrega valor atual do vetor para $t2 (auxiliar)	
	
	rem $t3, $t1, 2		# Dividindo a posicao do vetor por 2 para descobrir se a posicao do vetor é par 
	beqz $t3, inc_loop_impar # Se o resto da divisao nao for zero, entao a posicao atual do vetor é impar e podemos somente continuar o loop
	
	add $s3, $s3, $t2	# Somando o elemento atual do vetor ao somador de elementos

	inc_loop_impar:
	addi $t1, $t1, 1	# Incrementando contador
	addi $t0, $t0, 4	# Mudando o ponteiro para a proxima posicao do vetor
	blt $t1, $a2, loop_impares # if (count < vet.size)
	
	# Printando o resultado
	li $v0,4		# Carregando instrucao de printar string
	la $a0, msg6		# Carregando mensagem para printar
	syscall 		# Chamada de sistema
	
	li $v0, 1		# Carregando instrucao de printar inteiro
	move $a0, $s3		# Carregando valor para printar
	syscall			# Chamada de sistema
	
	li $v0,4		# Carregando instrucao de printar string
	la $a0, msg4		# Carregando mensagem para printar
	syscall 		# Chamada de sistema
	
	jr $ra			# Salta de volta para a funcao chamadora
