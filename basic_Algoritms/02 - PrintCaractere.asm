.data 
	caractere: .byte 'A'	#Caractere a ser impresso


.text 
	li, $v0, 4		# Instrução para imprimir char ou string
	la, $a0, caractere	# Carrega o conteúdo que sera impresso
	syscall			# Chamada de ação do sistema