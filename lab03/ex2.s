.globl main

.data
source:
    .word   3
    .word   1
    .word   4
    .word   1
    .word   5
    .word   9
    .word   0
dest:
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0
    .word   0

.text
fun:
    addi t0, a0, 1
    sub t1, x0, a0
    mul a0, t0, t1
    jr ra

main:
    # BEGIN PROLOGUE
    addi sp, sp, -20
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw ra, 16(sp)
    # END PROLOGUE
    addi t0, x0, 0
    addi s0, x0, 0
    # s1 points at the source[0]
    la s1, source
    # s2 points at the dest[0]
    la s2, dest
loop:
    #  s3 is the offset by adding 4 btyes
    slli s3, t0, 2
    # t1 is the address of sources[k], based-address + offset
    add t1, s1, s3
    # load sources[k]
    lw t2, 0(t1)
    # termination point
    beq t2, x0, exit
    # argument is the sources[k] by caller
    add a0, x0, t2
    # stack pointer  by callee
    # BEGIN PROLOGUE
    addi sp, sp, -8
    # save sources[0]
    sw t0, 0(sp)
    # save sources[k]
    sw t2, 4(sp)
    # go to function `fun`
    jal fun
    # END PROLOGUE
    lw t0, 0(sp)
    lw t2, 4(sp)
    addi sp, sp, 8
    # t2 is the return value
    add t2, x0, a0
    # s3 is the offset, s2 is the address of dest[0], so the t3 is the address of dest[k]
    add t3, s2, s3
    # assign the return value to the dest[k]
    sw t2, 0(t3)
    # sum is the s0, so accumulate the sum
    add s0, s0, t2
    # t0 is the k
    addi t0, t0, 1
    jal x0, loop
exit:
    # calulate the sum return vakue
    add a0, x0, s0
    # BEGIN EPILOGUE
    lw s0, 0(sp)
    lw s1, 4(sp)
    lw s2, 8(sp)
    lw s3, 12(sp)
    lw ra, 16(sp)
    addi sp, sp, 20
    # END EPILOGUE
    jr ra
