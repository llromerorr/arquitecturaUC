.data
fib_sequence: .space 40     # Espacio para almacenar la secuencia de Fibonacci (10 números x 4 bytes cada uno)
newline:      .asciiz "\n"  # Salto de línea para formatear la salida

.text
.globl main

main:
    # Inicializar los primeros dos números de la secuencia
    li $t0, 0  # Primer número (Fib(0))
    li $t1, 1  # Segundo número (Fib(1))

    # Imprimir el primer número de la secuencia (Fib(0))
    move $a0, $t0       # Cargar el valor de $t0 (Fib(0)) en el argumento para imprimir
    li $v0, 1           # Cargar el código del servicio de impresión entera en $v0
    syscall             # Realizar la llamada al sistema para imprimir el número
    la $a0, newline     # Cargar la dirección de la cadena de salto de línea en $a0
    li $v0, 4           # Cargar el código del servicio de impresión de cadena en $v0
    syscall             # Realizar la llamada al sistema para imprimir el salto de línea

    # Imprimir el segundo número de la secuencia (Fib(1))
    move $a0, $t1       # Cargar el valor de $t1 (Fib(1)) en el argumento para imprimir
    li $v0, 1           # Cargar el código del servicio de impresión entera en $v0
    syscall             # Realizar la llamada al sistema para imprimir el número
    la $a0, newline     # Cargar la dirección de la cadena de salto de línea en $a0
    li $v0, 4           # Cargar el código del servicio de impresión de cadena en $v0
    syscall             # Realizar la llamada al sistema para imprimir el salto de línea

    # Calcular e imprimir los siguientes 8 números de la secuencia
    li $t2, 8           # Contador del bucle (número de términos adicionales)
    loop:
        # Calcular el siguiente número de la secuencia: Fib(n) = Fib(n-1) + Fib(n-2)
        add $t3, $t0, $t1  # Sumar los dos últimos números calculados
        move $a0, $t3      # Cargar el valor del nuevo número de Fibonacci en el argumento para imprimir
        li $v0, 1          # Cargar el código del servicio de impresión entera en $v0
        syscall            # Realizar la llamada al sistema para imprimir el número
        la $a0, newline    # Cargar la dirección de la cadena de salto de línea en $a0
        li $v0, 4          # Cargar el código del servicio de impresión de cadena en $v0
        syscall            # Realizar la llamada al sistema para imprimir el salto de línea

        # Actualizar los valores para la siguiente iteración del bucle
        move $t0, $t1  # Mover el valor de $t1 (Fib(n-1)) a $t0 (Fib(n-2))
        move $t1, $t3  # Mover el valor de $t3 (Fib(n)) a $t1 (Fib(n-1))

        # Decrementar el contador del bucle
        sub $t2, $t2, 1
        bnez $t2, loop  # Si el contador no es cero, repetir el bucle

    # Salir del programa
    li $v0, 10       # Cargar el código del servicio de terminación en $v0
    syscall          # Realizar la llamada al sistema para terminar el programa
