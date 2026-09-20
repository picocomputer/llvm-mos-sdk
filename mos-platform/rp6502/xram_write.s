; 2026, Rumbledethumps
;
; XRAM block copies, optimally unrolled.

.include "rp6502.inc"
.include "imag.inc"

.section .text.xram0_write,"ax",@progbits
.globl xram0_write
.type xram0_write,@function
xram0_write:
    sta RIA_ADDR0
    stx RIA_ADDR0+1
    lda #1
    sta RIA_STEP0
    ldy #0
    ldx __rc5
    beq .Lxram0_write_tail
.Lxram0_write_page:
    .rept 8
    lda (__rc2),y
    sta RIA_RW0
    iny
    .endr
    bne .Lxram0_write_page
    inc __rc3
    dex
    bne .Lxram0_write_page
.Lxram0_write_tail:
    lda __rc4
    beq .Lxram0_write_done
    and #7
    beq .Lxram0_write_eights
    tax
.Lxram0_write_rest:
    lda (__rc2),y
    sta RIA_RW0
    iny
    dex
    bne .Lxram0_write_rest
.Lxram0_write_eights:
    lda __rc4
    lsr
    lsr
    lsr
    beq .Lxram0_write_done
    tax
.Lxram0_write_eight:
    .rept 8
    lda (__rc2),y
    sta RIA_RW0
    iny
    .endr
    dex
    bne .Lxram0_write_eight
.Lxram0_write_done:
    rts
.size xram0_write, .-xram0_write

.section .text.xram1_write,"ax",@progbits
.globl xram1_write
.type xram1_write,@function
xram1_write:
    sta RIA_ADDR1
    stx RIA_ADDR1+1
    lda #1
    sta RIA_STEP1
    ldy #0
    ldx __rc5
    beq .Lxram1_write_tail
.Lxram1_write_page:
    .rept 8
    lda (__rc2),y
    sta RIA_RW1
    iny
    .endr
    bne .Lxram1_write_page
    inc __rc3
    dex
    bne .Lxram1_write_page
.Lxram1_write_tail:
    lda __rc4
    beq .Lxram1_write_done
    and #7
    beq .Lxram1_write_eights
    tax
.Lxram1_write_rest:
    lda (__rc2),y
    sta RIA_RW1
    iny
    dex
    bne .Lxram1_write_rest
.Lxram1_write_eights:
    lda __rc4
    lsr
    lsr
    lsr
    beq .Lxram1_write_done
    tax
.Lxram1_write_eight:
    .rept 8
    lda (__rc2),y
    sta RIA_RW1
    iny
    .endr
    dex
    bne .Lxram1_write_eight
.Lxram1_write_done:
    rts
.size xram1_write, .-xram1_write
