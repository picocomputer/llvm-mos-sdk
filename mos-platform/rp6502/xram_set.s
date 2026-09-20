; 2026, Rumbledethumps
;
; XRAM fill, optimally unrolled.

.include "rp6502.inc"
.include "imag.inc"

.section .text.xram0_set,"ax",@progbits
.globl xram0_set
.type xram0_set,@function
xram0_set:
    sta RIA_ADDR0
    stx RIA_ADDR0+1
    lda #1
    sta RIA_STEP0
    lda __rc2
    ldx __rc4
    beq .Lxram0_set_tail
.Lxram0_set_page:
    ldy #16
.Lxram0_set_pg:
    .rept 16
    sta RIA_RW0
    .endr
    dey
    bne .Lxram0_set_pg
    dex
    bne .Lxram0_set_page
.Lxram0_set_tail:
    ldy __rc3
    beq .Lxram0_set_done
    tya
    and #15
    beq .Lxram0_set_sixteens
    tax
    lda __rc2
.Lxram0_set_rest:
    sta RIA_RW0
    dex
    bne .Lxram0_set_rest
.Lxram0_set_sixteens:
    tya
    lsr
    lsr
    lsr
    lsr
    beq .Lxram0_set_done
    tax
    lda __rc2
.Lxram0_set_blk:
    .rept 16
    sta RIA_RW0
    .endr
    dex
    bne .Lxram0_set_blk
.Lxram0_set_done:
    rts
.size xram0_set, .-xram0_set

.section .text.xram1_set,"ax",@progbits
.globl xram1_set
.type xram1_set,@function
xram1_set:
    sta RIA_ADDR1
    stx RIA_ADDR1+1
    lda #1
    sta RIA_STEP1
    lda __rc2
    ldx __rc4
    beq .Lxram1_set_tail
.Lxram1_set_page:
    ldy #16
.Lxram1_set_pg:
    .rept 16
    sta RIA_RW1
    .endr
    dey
    bne .Lxram1_set_pg
    dex
    bne .Lxram1_set_page
.Lxram1_set_tail:
    ldy __rc3
    beq .Lxram1_set_done
    tya
    and #15
    beq .Lxram1_set_sixteens
    tax
    lda __rc2
.Lxram1_set_rest:
    sta RIA_RW1
    dex
    bne .Lxram1_set_rest
.Lxram1_set_sixteens:
    tya
    lsr
    lsr
    lsr
    lsr
    beq .Lxram1_set_done
    tax
    lda __rc2
.Lxram1_set_blk:
    .rept 16
    sta RIA_RW1
    .endr
    dex
    bne .Lxram1_set_blk
.Lxram1_set_done:
    rts
.size xram1_set, .-xram1_set
