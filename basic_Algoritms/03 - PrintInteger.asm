.data 	
	idade: .word 20		# Valor inteiro na memória RAM
	
			
.text
	li $v0, 1		# Instrução para imprimir um inteiro
	lw $a0, idade		# Colocar o valor do inteiro no registrador 
	syscall			# Executar a ação do sistema				