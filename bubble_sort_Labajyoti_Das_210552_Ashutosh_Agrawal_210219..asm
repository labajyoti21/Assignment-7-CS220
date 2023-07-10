.data
prompt: .asciiz "Input :\n"
 result: .asciiz "output done "
.text
main:
# show prompt
li  $v0, 4
 la $a0, prompt
syscall

li $v0, 5
syscall
add $s0, $v0, $zero
 
move $a0, $s0
jal input


move $a1, $s0
jal bubble

move $s2, $zero
outputcall:
move $a2, $s0
jal output


li $v0, 4
 la $a0, result
 syscall

 li $v0, 10 # $v0 = 10
syscall


input:
bne $s1, $a0, scan
jr $ra
scan:
addi $sp, $sp, -4
li $v0, 5
syscall
sw $v0, 0($sp)
addi $s1, $s1, 1
j input

.text

output:
bne $s2, $a2, sout
jr $ra
sout:
lw $a0, 0($sp)
li $v0, 1
syscall
li $a0, 32
li $v0, 11  # syscall number for printing character
syscall
addi $sp, $sp, 4
addi $s2, $s2, 1
j output

bubble:
addi $t0, $zero, 0
addi $s7, $zero, 1
sub $a1, $a1, $s7
loop1:
beq $t0, $a1, exit1 
addi $t1, $zero, 0
sub $t2, $a1, $t0
loop2:
beq $t1, $t2, exit2
add $s2, $t1, $zero
add $t3, $sp, $zero
loopforsp:
beq $s2, $zero next1
addi $t3, $t3, 4
sub $s2, $s2, $s7
j loopforsp
next1:
addi $t4, $t3, 4
lw $s2, 0($t3)
lw $s3, 0($t4)
ble $s2, $s3, increment
sw $s3, 0($t3)
sw $s2, 0($t4)
increment:
addi $t1, $t1, 1
j loop2
exit2:
addi $t0, $t0, 1
j loop1
exit1:
jr $ra
