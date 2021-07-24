# ALGORITMO DE INPUT E OUTPUT DE UM VETOR

.data
	X: .space 60		# 15 espaços no vetor * 4 (tamanho de um inteiro)

	in1: .asciiz "Insira um valor no vetor["
	in2: .asciiz "]: "
	
	out1: .asciiz "Valor["
	out2: .asciiz "]: "
	
	jline: .asciiz "\n"
	
# s0 -> endereço base do vetor
# s1 -> Numero de posicoes do vetor
# s2 -> copia do endereço base da matriz

# t1 -> aux que recebe o valor vindo do usuario

# a0 -> Temporaria para imprimir strings
# a1 -> valor de i (contador)

.text
	main: 	
	la $s0, X 		# Endereço base do vetor
	
	li $s1,15 		# Número de posicoes no vetor
	
	jal LeituraVetor	# Chamada da rotina de leitura dos valores no vetor
	jal PrintVetor		# Chamada da rotina de impressao dos valores do vetor
	
	li $v0, 10		# Código para finalizar o programa
	syscall 		# Finaliza o programa

		
LeituraVetor:
	subi $sp, $sp, 4 	# Espaço para 1 item na pilha
	sw $ra, ($sp) 		# Salva o retorno para a main
	
	move $s2, $s0 		# vetAux = endereço base de mat
	li $a1, 0		# Setando contador(i) para 0
	
	l: la $a0, in1 		# Carrega o endereço da string
	li $v0, 4 		# Código de impressão de string
	syscall 		# Imprime a string
	
	move $a0, $a1 		# Valor de i para impressão
	li $v0, 1 		# Código de impressão de inteiro
	syscall 		# Imprime i
	
	la $a0, in2 		# Carrega o endereço da string
	li $v0, 4 		# Código de impressão de string
	syscall 		# Imprime a string
	
	li $v0, 5 		# Código de leitura de inteiro
	syscall 		# Leitura do valor (retorna em $v0)
	
	move $t1, $v0 		# aux = valor lido
			
	sw $t1, ($s2) 		# vet[i] = aux
			
	addi $a1, $a1, 1 	# i++
	addi $s2, $s2, 4	# Soma 4 para ir para a proxima posicao do vetor (i++)
	blt $a1, $s1, l 	# if(i < tamanhoDoVetor) goto l
	
	lw $ra, ($sp) 		# Recupera o retorno para a main
	addi $sp, $sp, 4 	# Libera o espaço na pilha
	move $v0, $a3 		# Endereço base da matriz para retorno
	
	jr $ra			# Retorna para a rotina chamadora


PrintVetor:
	subi $sp, $sp, 4 	# Espaço para 1 item na pilha
	sw $ra, ($sp) 		# Salva o retorno para a main	
	
	move $s2, $s0 		# vetAux = endereço base de mat
	li $a1, 0		# Setando contador(i) para 0
	
	loop:
	la $a0, out1 		# Carrega o endereço da string
	li $v0, 4 		# Código de impressão de string
	syscall 		# Imprime a string
	
	move $a0, $a1 		# Valor de i para impressão
	li $v0, 1 		# Código de impressão de inteiro
	syscall 		# Imprime i
	
	la $a0, out2 		# Carrega o endereço da string
	li $v0, 4 		# Código de impressão de string
	syscall 		# Imprime a string
	
	lw $a0, ($s2)		# Valor do vetor para impressão
	li $v0, 1 		# Código de impressão de inteiro
	syscall 		# Imprime o valor da posicao atual do vetor
	
	la $a0, jline 		# Carrega o endereço da string
	li $v0, 4 		# Código de impressão de string
	syscall 		# Imprime a string
	
	addi $a1, $a1, 1 	# i++
	addi $s2, $s2, 4	# Soma 4 para ir para a proxima posicao do vetor (i++)
	blt $a1, $s1, loop 	# if(i < tamanhoDoVetor) goto l
	
	lw $ra, ($sp) 		# Recupera o retorno para a main
	addi $sp, $sp, 4 	# Libera o espaço na pilha
	move $v0, $a3 		# Endereço base da matriz para retorno
	
	jr $ra			# Retorna para a rotina chamadora