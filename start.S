.syntax unified
.cpu cortex-m4
.thumb

// Global memory locations.
.global vtable
.global __hard_reset__

/*
* vector table
*/
.type vtable, %object
.type __hard_reset__, %function

vtable:
    .word __stack_start
    .word __hard_reset__+1
    .size vtable, .-vtable

__hard_reset__:
    bl lab2  @ Викликаємо lab2
_loop:
    b _loop  @ Безкінечний цикл
    .size __hard_reset__, .-__hard_reset__
