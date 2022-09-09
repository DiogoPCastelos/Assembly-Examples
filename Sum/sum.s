.data #data segment
number1: .quad 0 #set a new changeable variable, "number1". A quadword set to 0 for now
number2: .quad 0 #same as above, but called "number2"

.global main #make main visible
.text #segment where it's read only

#load of fucking strings (\n == increment in line)
welcome: .asciz "\nDo you also wanna kill yourself? Try assembly! Brought to you by the x86_64 boys at AMD.\n\n"
prompt1: .asciz "Please enter the first number you wish to sum: "
prompt2: .asciz "Please enter the second number you wish to sum: "
input: .asciz "%ld" #%ld = placeholder of incoming value
output: .asciz "The result of the sum is: %ld\n" #same here

main:
    #epilogue
    push %rbp #push the base pointer
    mov %rsp, %rbp #copy the stack pointer value to base pointer

    #print out welcome string
    mov $welcome, %rdi #first parameter: message string
    mov $0, %rax #0 rax
    call printf #call printf to print

    #print out prompt 1
    mov $prompt1, %rdi #same as above (line 20-22), but with string "prompt1"
    mov $0, %rax
    call printf

    #"prints" out input
    mov $input, %rdi #sets first parameter to input string
    mov $number1, %rsi #sets the address of the variable "number1" in register rsi
    mov $0, %rax #o rax
    call scanf #call scanf to scan for input

    #print out prompt 2 ++ inupt
    mov $prompt2, %rdi #same as prompt 1 (line 25-29), but with string "prompt2"
    mov $0, %rax
    call printf

    mov $input, %rdi #same as input for number1, but with number2 variable (line 30-33)
    mov $number2, %rsi
    mov $0, %rax
    call scanf

    #Sum both variables
    mov number1, %rax #Sum the value of number1 to register rax
    add %rsi, %rax #Sum value of rax with value of rsi (number2)
    mov %rax, %r9 #move the high result from rax to register 9

    #print out the output prompt and result
    mov $output, %rdi # first parameter:  message string
    mov %r9, %rsi # second parameter: the actual result (previously stored in register 9)
    mov $0, %rax #0 rax
    call printf #call printf to print

    #exit routine
    call exit

    #prologue
   	mov %rbp, %rsp #clear local variables from stack
	pop %rbp #restore base pointer location