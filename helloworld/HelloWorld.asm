BITS 64

; The cycle number of for loop

%define NUMBER_OF_LOOP 3

; A macro with two parameters
; Implements the write system call
%macro print_string 2 
  mov rax, 1        
  mov rdi, 1        
  mov rsi, %1    ; msg
  mov rdx, %2    ; msg length
  syscall    
%endmacro

global _start

section .rodata
  msg: db "Hello, world!", 10 ; 10 = \n at the end
  msglen: equ $ - msg

section .text

    _start:         

      mov rcx, NUMBER_OF_LOOP
      jmp _loop    

    _exit:
      mov rax, 60       
      mov rdi, 0        
      syscall           


    _loop:

      push rcx                  ; We stack to keep the value before the print (which can modify the value of the register)
      print_string msg, msglen  ; We print
      pop rcx                   ; We put the value of the stack back in its place [pop retreats the value at the top of the stack and puts it in rcx]
      loop _loop                ; We loop if rcx > 0
      jmp _exit                 ; Else exit
      
      
      ; Other method

      ; dec r9            we decrement register r9
      ; [Action]
      ; cmp r9, 0         we compare it to 0
      ; je _exit          if it is equal to 0 we jump on exit
      ; jmp loop          else we loop
    
