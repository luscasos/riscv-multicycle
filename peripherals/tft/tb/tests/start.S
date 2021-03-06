.section .text
.global _start
.global _start
.global _pvstart
.global init_data_section

_pvstart:
/* zero-initialize all registers */
/* addi x1, zero, 0
addi x2, zero, 0
addi x3, zero, 0
addi x4, zero, 0
addi x5, zero, 0
addi x6, zero, 0
addi x7, zero, 0
addi x8, zero, 0
addi x9, zero, 0
addi x10, zero, 0
addi x11, zero, 0
addi x12, zero, 0
addi x13, zero, 0
addi x14, zero, 0
addi x15, zero, 0
addi x16, zero, 0
addi x17, zero, 0
addi x18, zero, 0
addi x19, zero, 0
addi x20, zero, 0
addi x21, zero, 0
addi x22, zero, 0
addi x23, zero, 0
addi x24, zero, 0
addi x25, zero, 0
addi x26, zero, 0
addi x27, zero, 0
addi x28, zero, 0
addi x29, zero, 0
addi x30, zero, 0
addi x31, zero, 0 */

/* set stack pointer */
/* lui sp, %hi(4*1024*1024) */
/* addi sp, sp, %lo(4*1024*1024) */

/* set stack pointer: ram(rwx) : ORIGIN = 0x0002000000, LENGTH = 2k = 0x2000800  = 33556480*/
lui sp, %hi(33556480)         
addi sp, sp,%lo(33556480)

/* Set Global pointer: RAM init @  ORIGIN = 0x0002000000,*/
lui gp, %hi(33554432)
addi gp, gp, %lo(33554432)


/* lui	a5,0x2000
li	a4,0x123456F8
sw a4, 0(a5)
sb a4, 4(a5)
sh a4, 6(a5)

lhu	a6,0(a5)
lh	a7,2(a5)

lb s2, 0(a5)
lb s3, 1(a5)
lb s4, 2(a5)
lb s5, 3(a5) */


/* jal init_data_section */

/* push zeros on the stack for argc and argv */
/* (stack is aligned to 16 bytes in riscv calling convention) */
addi sp,sp,-16
sw zero,0(sp)
sw zero,4(sp)
sw zero,8(sp)
sw zero,12(sp)

/* j _start */
jal main
ebreak
 

 
