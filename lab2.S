.global lab2
.syntax unified
#define A #4
#define B #6
#define C #3

lab2:

    push {lr}       
// Ініціалізація a,b,c
    mov r0, A          
    mov r1, B           
    mov r2, C          

    add r3, r0, r1      @ r3 = a + b
    asr r3, r3, #1      @ r3 = (a + b) / 2

    mov r4, #1          @ r4 = 1 (факторіал починається з 1)
    mov r5, r2          @ r5 = c (лічильник факторіала)
    cmp r5, #1          @ Перевіряємо, чи c <= 1
    ble factorial_done  @ Якщо так, факторіал = 1

factorial_loop:
    mul r4, r4, r5      @ r4 = r4 * r5
    subs r5, r5, #1     @ r5 = r5 - 1
    bne factorial_loop  @ Якщо r5 != 0, повторити

factorial_done:
    add r0, r3, r4      @ r0 = (a + b) / 2 + c!
    bl test_var         @ Викликаємо перевірку

    pop {pc}            @ Відновлюємо і повертаємося

test_var:
    push { r0, r1, lr }
    cmp r0, r1
    ITE GE
    movGE r3, r0
    movLT r2, r0
    pop { r0, r1, r2, pc }
