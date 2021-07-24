# ALGORITMO DE VETOR COM TAMANHO DINAMICO
# O Tamanho do vetor sera definido pela entrada do usuario

.data
vet:

msg1: .asciiz "Leitura do vetor"
msg2: .asciiz "\n\nNumero de elementos do vetor = "
msg3: .asciiz "Vet["
msg4: .asciiz "] = "


.text
main:
	la $a1, vet			# Carregando o vetor que será preenchido para passar como argumento 
	jal ler_vetor_dinamico	 	# Procendimento de leitura do vetor
	li $v0,10		 	# Carregando instrucao de finalizacao de programa
	syscall			 	# Chamada de sistema
	
	
# ----- LEITURA DO VETOR DINAMICO -----
# $t0: Copia do endereco base do vetor
# $t1: Contador do loop
# $t2: Auxiliar que guarda temporariamente o valor que será inserido no vetor

# $s0: Tamanho do vetor definido pelo usuario

# $v0 e $a0: Usados para parametro e retorno de syscall

ler_vetor_dinamico:
	la $t0, ($a1)		# Carregando em $t3 o endereço base do vetor (Ponteiro para vet)
	
	# Recebendo do usuario o tamanho do vetor
	li $v0, 4		# Carregando instrucao para printar string
	la $a0, msg1		# Carregando endereço da mensagem 1
	syscall			# Chamada de sistema
	
	la $a0, msg2		# Carregando endereço da mensagem 2
	syscall			# Chamada de sistema
	
	li $v0, 5		# Carregando instrucao de leitura
	syscall			# Chamada de sistema
	
	la $s0, ($v0)		# Movendo para $s0 o valor que foi lido pelo usuario
	li $t1, 0		# Setando contador com 0
	
	ble $s0, 0, fim_loop	# Se o tamanho do vetor inserido pelo usuario for menor ou igual a zero, nao faremos a leitura dos elementos
	
	# Recebendo do usuario e inserindo os valores no vetor
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
	sw $t2, ($t0)		# Salvando no vetor o valor lido 
	addi $t0, $t0, 4	# Apontando para a proxima posicao do vetor
	addi $t1, $t1, 1	# Acrescentando o contador em +1
	
	blt $t1, $s0, loop	# Verifica se contador é maior que valor maximo do vetor
	
	fim_loop:
	jr $ra			# Retorna para o procedimento que chamou