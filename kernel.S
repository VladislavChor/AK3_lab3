.syntax unified
.cpu cortex-m4

//.fpu softvfp
.thumb

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
	.word __stack_start
	.word __kernel_reset__+1
	.size vtable_kernel, .-vtable_kernel

.section .rodata
	start: .asciz "kernel start\n"
	finish: .asciz "result in reg #3: "

.section .text
__kernel_reset__:
	ldr r0, =start
	bl dbgput_line

	// calc part	

    mov r0, #2
    mov r1, #2
    mov r2, #1
    cmp r0,r1
    ITE GE
    addGE r3,r0,r1
    SUBLT r3,r0,r1
    sdiv r3,r2

    ldr r0, =finish
    bl dbgput

    mov r0, r3      // Move result to r0
    bl dbgput_num
    
end:
b end

