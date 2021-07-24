# ALGORITMO VERIFICADOR DE NUMERO PALÍNDROME
# O algoritmo recebe um numero natural n > 10 e verifica se o mesmo é palíndrome.


.data
msg1: .asciiz "Leitura do valor\n"
msg2: .asciiz "Insira uma valor > 10: "
msg3: .asciiz "O valor nao é palindrome"
msg4: .asciiz "O valor é palindrome"
msg5: .asciiz "Insira um valor valido...\n\n"


.text
# ---- MAIN ---- 
main:

	jal ler_valor		 	# Procendimento de leitura do valor a ser verificado
	jal verifica_palindrome		# Procedimento de verificacao de numero palíndrome

	li $v0,10		 	# Carregando instrucao de finalizacao de programa
	syscall			 	# Chamada de sistema para finalizar programa
	
	
	
# --- LEITURA DO VALOR ---
# $s0: Valor lido do usuario

ler_valor:
	
	li $v0, 4		# Carregando instrucao de printar string
	la $a0, msg1		# Carregando mensagem para printar
	syscall			# Chamada de sistema
	
	li $v0, 4		# Carregando instrucao de printar string
	la $a0, msg2		# Carregando mensagem para printar
	syscall			# Chamada de sistema

	li $v0, 5		# Recebendo um inteiro do usuario
	syscall			# Chamada de sistema
	
	move $s0, $v0		# Movendo valor lido para $t2
	
	ble $s0, 10, erro	# Verifica se o valor inserido é maior que 10
	
	jr $ra

	# Caso o valor inserido seja menor ou igual a 10, vamos imprimir a mensagem de erro e retornar a leitura
	erro:
	li $v0, 4		# Carregando instrucao de printar string
	la $a0, msg5		# Carregando mensagem para printar
	syscall			# Chamada de sistema
	j ler_valor



# --- VERIFICADOR DE NUMERO PALINDROME ---

# $s0: Numero a ser verificado
# $s1: numero invertido				

# $t0: resto da divisao				
# $t1: Copia do valor a ser verificada		

verifica_palindrome:
	
	move $t1, $s0		# Copiando o valor a ser verificado para um registrador auxiliar
	li $s1, 0		# Certificando que o registrador com valor inverso começa com zero
	
	# Invertendo o numero 
	loop:
	rem $t0, $t1, 10	# Dividindo o registrador auxiliar por dez e inserindo o resto da divisao em $t0 (var = n % 10)
	mul $s1, $s1, 10	# Multiplicando valor atual do numero invertido por 10
	add $s1, $s1, $t0	# O valor invertido recebe ele mesmo somado ao resto da ultima divisao efetuada
	div $t1, $t1, 10	# Auxiliar recebe a divisao dele por 10 (n = n/10)	
	bgt $t1, 0, loop
	
	# Após ter o inverso do numero, podemos verificar se ambos sao iguais
	beq $s0, $s1, palindrome	# Se ambos sao iguais, significa que o numero é palindrome
	
	nao_palindrome:
	li $v0, 4		# Carregando instrucao de printar string
	la $a0, msg3		# Carregando mensagem para printar
	syscall			# Chamada de sistema
	j fim
	
	palindrome:
	li $v0, 4		# Carregando instrucao de printar string
	la $a0, msg4		# Carregando mensagem para printar
	syscall			# Chamada de sistema
	
	fim:
	jr $ra
	