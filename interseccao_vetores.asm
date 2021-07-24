# ALGORITMO DE INTERSECCAO DE VETORES
# O Algoritmo faz a leitura de dois vetores de inteiros e retorna um vetor contendo as interseccoes dos dois vetores.

.data
VetA: .space 60
VetB: .space 60
Inter: .space 60

msg1: .asciiz "\nLeitura do vetor"
msg2: .asciiz "\n\nNumero de elementos do vetor = "
msg3: .asciiz "VetA["
msg4: .asciiz "VetB["
msg5: .asciiz "] = "

msg6: .asciiz "\nA = { "
msg7: .asciiz "\nB = { "
msg8: .asciiz "\nInter = { "
msg9: .asciiz "}\n"
msg10: .asciiz " "

.text
# ---- MAIN ----

# $s0: Quantidade de elementos do vetA
# $s1: Quantidade de elementos do vetB
# $s2: Quantidade de elementos do Inter

# $a1, a2, a3: Argumentos

main:

	# Carregando parametros	
	la $a1, VetA			# Carregando endereço base do VetA para usar na rotina
	la $a3, msg3			# Carregando memoria adequada para passar como argumento
	jal ler_vetor_dinamico		# Chamada de rotina para leitura do vetor VetA
	move $s0, $s7			# Inserindo em $s0 o tamanho definido do VetA

	# Carregando parametros	
	la $a1, VetB			# Carregando endereço base do VetB para usar na rotina
	la $a3, msg4			# Carregando memoria adequada para passar como argumento
	jal ler_vetor_dinamico		# Chamada de rotina para leitura do vetor VetB
	move $s1, $s7			# Inserindo em $s1 o tamanho definido do VetB
	
	jal interseccao			# Chamada da rotina
	
	# Carregando parametros
	la $a1, VetA
	move $a2, $s0
	la $a3, msg6
	jal printar_vetor		# Chamando print com parametros do Vet A
	
	# Carregando parametros
	la $a1, VetB
	move $a2, $s1
	la $a3, msg7		
	jal printar_vetor		# Chamando print com parametros do Vet B
	
	# Carregando parametros
	la $a1, Inter
	move $a2, $s2
	la $a3, msg8
	jal printar_vetor		# Chamando print com parametros do Vet Inter
	
	li $v0, 10		 	# Carregando instrucao de finalizacao de programa
	syscall			 	# Chamada de sistema para finalizar programa
	
	
	
# ----- LEITURA DO VETOR DINAMICO -----
# $t0: Copia do endereco base do vetor
# $t1: Contador do loop
# $t2: Auxiliar que guarda temporariamente o valor que será inserido no vetor

# $s7: Tamanho do vetor definido pelo usuario

# $v0 e $a0: Usados para parametro e retorno de syscall

ler_vetor_dinamico:
	la $t0, ($a1)		# Carregando em $t3 o endereço base do vetor (Ponteiro para vet)
	li $t1, 0		# Setando contador com 0
	
	# Recebendo do usuario o tamanho do vetor
	li $v0, 4		# Carregando instrucao para printar string
	la $a0, msg1		# Carregando endereço da mensagem 1
	syscall			# Chamada de sistema
	
	li $v0, 4		# Carregando instrucao para printar string
	la $a0, msg2		# Carregando endereço da mensagem 2
	syscall			# Chamada de sistema
	
	li $v0, 5		# Carregando instrucao de leitura
	syscall			# Chamada de sistema
	
	move $s7, $v0		# Movendo para $s7 o valor que foi lido pelo usuario
	
	ble $s7, 0, fim_loop	# Se o tamanho do vetor inserido pelo usuario for menor ou igual a zero, nao faremos a leitura dos elementos
	
	# Recebendo do usuario e inserindo os valores no vetor
	loop:
	li $v0, 4		# Carregando instrucao de printar string
	la $a0, ($a3) 		# Carregando mensagem para printar
	syscall			# Chamada de sistema
	
	li $v0, 1		# Carregando instrucao de printar inteiro
	move $a0, $t1		# Carregando valor para printar
	syscall			# Chamada de sistema
	
	li $v0,4		# Carregando instrucao de printar string
	la $a0, msg5		# Carregando mensagem para printar
	syscall 		# Chamada de sistema
	
	li $v0, 5		# Recebendo um inteiro do usuario
	syscall			# Chamada de sistema

	move $t2, $v0		# Movendo valor lido para $t2
	sw $t2, 0($t0)		# Salvando no vetor o valor lido 
	addi $t0, $t0, 4	# Apontando para a proxima posicao do vetor
	addi $t1, $t1, 1	# Acrescentando o contador em +1
	
	blt $t1, $s7, loop	# Verifica se contador é maior que valor maximo do vetor "if(contador < vet.size)"
	
	fim_loop:
	jr $ra			# Retorna para o procedimento que chamou
	
	
	
# ---- VERIFICANDO INTERSECCOES ----

# $t0: Copia do endereço base dos vetor A
# $t1: Copia do endereço base dos vetor B
# $t2: Copia do endereço base dos vetor Inter

# $t3: Contador que ira percorrer os elementos do vetA
# $t4: Contador que ira percorrer os elementos do vetB

# $t5: Auxiliar dos valores do vetA
# $t6: Auxiliar dos valores do vetB

# $t7: Copia do endereço base do Inter para percorrer o vetor e verificar duplicatas
# $t8: Contador para percorre o vet Inter
# $t9: Valor atual do vet Inter
	
# $s0: Quantidade de elementos do vetA
# $s1: Quantidade de elementos do vetB
# $s2: Quantidade de elementos do vet Inter
	
interseccao:
	la $t0, VetA		# Copiando endereco base do vetA para o registrador
	la $t1, VetB		# Copiando endereco base do vetB para o registrador
	la $t2, Inter		# Copiando endereco base do Inter para o registrador
	
	li $s2, 0		# Setando contador de elementos do Vet Inter com zero
	
	li $t3, 0		# Setando contador com zero
	
	# Verificando se algum dos vetores estao vazios
	ble $s0, $zero, fim_intersec # Se o tamanho do vetor for menor ou igual a zero, saimos
	ble $s1, $zero, fim_intersec # Se o tamanho do vetor for menor ou igual a zero, saimos
	
	loop_intersec:
	lw $t5, 0($t0)		# Carrega valor atual do vetor A para $t5 (auxiliar)	
	li $t4, 0		# Setando contador com zero
	la $t1, VetB		# Copiando endereco base do vetB para o registrador

	loop_vetB:
	lw $t6, 0($t1)		# Carrega valor atual do vetor B para $t6 (auxiliar)	
	
	beq $t5, $t6, verifica_duplicacao  # Se os valores das posicoes atuais dos vetores forem iguas, podemos inserir no vetor Inter
	
	inc_counter:
	addi $t4, $t4, 1	# Incrementando o contador que percorre o vetB
	addi $t1, $t1, 4	# Apontando para a proxima posicao no vetor Inter
	blt $t4, $s1, loop_vetB	# Verifica se deve continuar no loop que percorre os elementos do vetor B "if(contadorB < vetB.size)"
	
	verifica_loop_intersec:
	addi $t3, $t3, 1 	# Incrementando o contador do vetA
	addi $t0, $t0, 4	# Apontando para a proxima posicao do vet A
	blt $t3, $s0, loop_intersec	# if(contadorA < vetA.size)
	j fim_intersec
	
	verifica_duplicacao:
	la $t7, Inter		# Salvando a posicao atual do ponteiro Inter
	li $t8, 0		# Set contador com zero
	
	loop_duplicacao:
	lw $t9, 0($t7)		# Carrega valor atual do vetor Inter para $t9 (auxiliar)
	beq $t9, $t6, verifica_loop_intersec # Se o valor que queremos add é igual ao que ja esta no vetor inter, nao vamos adiciona-lo
	
	addi $t8, $t8, 1
	addi $t7, $t7, 4
	blt $t8, $s2, loop_duplicacao
	
	add_inter:
	sb $t6, ($t2)  		# Inserindo o elemento no vetor Inter 
	addi $t2, $t2, 4	# Apontando para a proxima posicao no vetor Inter
	addi $s2, $s2, 1	# Incrementando o contador de elementos do vet Inter
	j verifica_loop_intersec
	
	fim_intersec:
	jr $ra
	
	
# ---- PRINTAR VETORES ----
# $t0: Copia do endereço base dos vetor A
# $t1: Contador
# $t2: Auxiliar para valor atual do vetor

# $a1: Parametro contendo o endereco do vetor
# $a2: Parametro contendo o tamanho do vetor
# $a3: Parametro contendo a mensagem personalizada
	
printar_vetor:
	la $t0, ($a1)		# Copiando endereco base do vetA para o registrador
	li $t1, 0		# Setando contador para começar com 0
	
	# Printando qual o vetor
	li $v0, 4		# Carregando instrucao de printar string
	la $a0, ($a3)		# Carregando mensagem para printar
	syscall 		# Chamada de sistema	
	
	ble $a2, $zero, fim_loop_print # Se o tamanho do vetor for menor ou igual a zero, saimos
	
	loop_print:
	lw $t2, ($t0)		# Carrega valor atual do vetor A para $t5 (auxiliar)			
	
	# Printando o valor
	li $v0, 1		# Carregando instrucao de printar inteiro
	move $a0, $t2		# Carregando valor para printar
	syscall			# Chamada de sistema
	
	# Printando um espaco
	li $v0, 4		# Carregando instrucao de printar string
	la $a0, msg10		# Carregando mensagem para printar
	syscall 		# Chamada de sistema	
	
	addi $t1, $t1, 1	#incrementando contador
	addi $t0, $t0, 4	# Apontando para a proxima posicao do vetor
	blt $t1, $a2, loop_print	# Verificando se deve continuar no loop "if(contador < vet.size)"
	
	fim_loop_print:
	# Printando o fechamento da chave
	li $v0, 4		# Carregando instrucao de printar string
	la $a0, msg9		# Carregando mensagem para printar
	syscall 		# Chamada de sistema	
	jr $ra