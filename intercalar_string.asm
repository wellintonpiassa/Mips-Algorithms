# PROGRAMA DE INTERCALAÇÃO DE STRINGS

.data
msg1: .asciiz "Digite a primeira string: "
msg2: .asciiz "Digite a segunda string: "
string1: .space 50
string2: .space 50
string_inter: .space 100

.text 
main:
	la $a0, msg1			# Carrega a mensagem1 em $a0 para printar
	la $a1, string1			# Carrega o endereço a qual vai ser colocado a string lida em $a1
	jal leitura_string		# Salta para procedimento que faz a leitura da string
	
	la $a0, msg2			# Carrega a mensagem2 em $a0 para printar
	la $a1, string2			# Carrega o endereço a qual vai ser colocado a string lida em $a1
	jal leitura_string		# Salta para procedimento que faz a leitura da string
	
	la $a0, string1			# Carrega em $a0 a string1 para manipulacao na rotina a seguir 
	la $a1, string2			# Carrega em $a1 a string2 para manipulacao na rotina a seguir
	la $a2, string_inter		# Carrega em $a2 a string_inter para ser preenchida
	jal intercalar			# Chamada da rotina de intercalar string

	la $a0, string_inter		# Carregando a string intercalada para printar	
	li $v0, 4			# Carregando instrucao de printar string
	syscall				# Chamada de sistema

	li $v0, 10			# Carregando instrucao de finalizar programa
	syscall				# Chamada de sistema para finalizar o programa
	
	
leitura_string:
	li $v0, 4			# Carrega em $v0 a instrucao de printar string 
	syscall 			# Chamada de sistema para printar a string
	move $a0, $a1			# Move conteudo de $a1(espaco para a string a ser lida) para $a0
	li $a1, 50			# Carrega o tamanho maximo alocado para leitura
	li $v0, 8			# Carregando instrucao de leitura de string para $v0
	syscall				# Chamada de sistema
	jr $ra				# Salta de volta para o procedimento chamador


intercalar:
	
loop1:	
	lb $t1, ($a0)			# Carrega para $t1 o caracter atual da string1
	beq $t1, 10, fimString1		# Verifica se o caracter atual é '\n'
	sb $t1, ($a2)			# Insere na string concatenada o caracter atual da string1 
	addi $a0, $a0, 1		# Acrescente +1 ao ponteiro para apontar para o proximo caracter
	addi $a2, $a2, 1		# Acrescente +1 ao ponteiro da string intercalada
	bgtz $t1, loop2			# Verifica se o caracter da primeira string é null
	j loop1				# Caso a string1 seja null, continua no loop1
	
loop2:
	lb $t2, ($a1)			# Carrega para $t2 o caracter atual da string2
	beq $t2, 10, fimString2		# Verifica se o caracter atual é '\n'
	sb $t2, ($a2)			# Insere na string concatenada o caracter atual da string2 
	addi $a1, $a1, 1		# Acrescente +1 ao ponteiro para apontar para o proximo caracter
	addi $a2, $a2, 1		# Acrescente +1 ao ponteiro da string intercalada
	bgtz $t2, loop1			# Verifica se o caracter da segunda string é null
	j loop2				# Caso a string2 seja null, continua no loop2
	
	
fimString1:
	bne $t2,10, loop2		# Verifica se o caracter atual da string2 é '\n'
	jr $ra				# Salta de volta para o procedimento chamador
	
fimString2:
	bne $t1,10, loop1		# Verifica se o caracter atual da string1 é '\n'
	jr $ra				# Salta de volta para o procedimento chamador