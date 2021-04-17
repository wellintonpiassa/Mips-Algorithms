.data					# Área onde vão ficar todas as declarações de dados
	msg: .asciiz "Hello World!"	# Mensagem a ser exibida ao usuário



.text 					# Área para instruções do programa
	li $v0,4			# Instrução para a impressão de string
	la $a0, msg			# Indica o endereço de onde se encontra a mensagem
	syscall 			# Imprimir
