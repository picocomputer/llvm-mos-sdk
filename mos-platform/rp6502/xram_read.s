; 2026, Rumbledethumps
;
; XRAM block copies, optimally unrolled.

.include "rp6502.inc"
.include "imag.inc"

.section .text.xram0_read,"ax",@progbits
.globl xram0_read
.type xram0_read,@function
xram0_read:
    sta RIA_ADDR0
    stx RIA_ADDR0+1
    lda #1
    sta RIA_STEP0
    ldy #0
    ldx __rc5
    beq .Lxram0_read_tail
.Lxram0_read_page:
    .rept 8
    lda RIA_RW0
    sta (__rc2),y
    iny
    .endr
    bne .Lxram0_read_page
    inc __rc3
    dex
    bne .Lxram0_read_page
.Lxram0_read_tail:
    lda __rc4
    beq .Lxram0_read_done
    and #7
    beq .Lxram0_read_eights
    tax
.Lxram0_read_rest:
    lda RIA_RW0
    sta (__rc2),y
    iny
    dex
    bne .Lxram0_read_rest
.Lxram0_read_eights:
    lda __rc4
    lsr
    lsr
    lsr
    beq .Lxram0_read_done
    tax
.Lxram0_read_eight:
    .rept 8
    lda RIA_RW0
    sta (__rc2),y
    iny
    .endr
    dex
    bne .Lxram0_read_eight
.Lxram0_read_done:
    rts
.size xram0_read, .-xram0_read

.section .text.xram1_read,"ax",@progbits
.globl xram1_read
.type xram1_read,@function
xram1_read:
    sta RIA_ADDR1
    stx RIA_ADDR1+1
    lda #1
    sta RIA_STEP1
    ldy #0
    ldx __rc5
    beq .Lxram1_read_tail
.Lxram1_read_page:
    .rept 8
    lda RIA_RW1
    sta (__rc2),y
    iny
    .endr
    bne .Lxram1_read_page
    inc __rc3
    dex
    bne .Lxram1_read_page
.Lxram1_read_tail:
    lda __rc4
    beq .Lxram1_read_done
    and #7
    beq .Lxram1_read_eights
    tax
.Lxram1_read_rest:
    lda RIA_RW1
    sta (__rc2),y
    iny
    dex
    bne .Lxram1_read_rest
.Lxram1_read_eights:
    lda __rc4
    lsr
    lsr
    lsr
    beq .Lxram1_read_done
    tax
.Lxram1_read_eight:
    .rept 8
    lda RIA_RW1
    sta (__rc2),y
    iny
    .endr
    dex
    bne .Lxram1_read_eight
.Lxram1_read_done:
    rts
.size xram1_read, .-xram1_read
