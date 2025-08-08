  .data
  str1: .asciiz "media: "  # string para exibir antes do resultado
  str2: .asciiz "erro: numero de elementos nao pode ser zero!"  # mensagem de erro
  three: .float 3.0  # constante 
  
  .text
  .globl main
  .ent main
  main:
      # le numeros ponto flutuante
      li $v0, 6    # solicita entrada float
      syscall      # le float
      mov.s $f1, $f0  # armazena em $f1
      
      li $v0, 6
      syscall
      mov.s $f2, $f0  # armazena em $f2
      
      li $v0, 6
      syscall
      mov.s $f3, $f0  # armazena em $f3
      
      # (n1 + n2 + n3) / 3.0
      add.s $f4, $f1, $f2   # soma n1 + n2 em $f4
      add.s $f4, $f4, $f3   # soma resultado + n3 em $f4
      l.s $f5, three        # carrega 3.0 em $f5
      div.s $f6, $f4, $f5   # media armazenada em $f6
      
      # imprime  
      la $a0, str1  # carrega endereco
      li $v0, 4
      syscall
      
      # imprime ponto flutuante
      li $v0, 2    # syscall para imprimir float
      mov.s $f12, $f6    # carrega media
      syscall
      
      li $v0, 10 
      syscall
  .end main
