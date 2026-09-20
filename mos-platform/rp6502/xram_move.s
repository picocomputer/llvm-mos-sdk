; 2026, Rumbledethumps
;
; XRAM to XRAM move, optimally unrolled.

.include "rp6502.inc"
.include "imag.inc"

.section .text.xram_move,"ax",@progbits
.globl xram_move
.type xram_move,@function
xram_move:
    sta __rc6                   ; dest
    stx __rc7
    sec                         ; dest - src < count means backward
    lda __rc6
    sbc __rc2
    tay
    lda __rc7
    sbc __rc3
    tax
    tya
    cmp __rc4
    txa
    sbc __rc5
    bcc .Lxram_move_back
    lda __rc2
    sta RIA_ADDR0
    lda __rc3
    sta RIA_ADDR0+1
    lda __rc6
    sta RIA_ADDR1
    lda __rc7
    sta RIA_ADDR1+1
    lda #1
    bne .Lxram_move_step
.Lxram_move_back:               ; the last byte of each region
    clc
    lda __rc2
    adc __rc4
    sta __rc2
    lda __rc3
    adc __rc5
    sta __rc3
    clc
    lda __rc6
    adc __rc4
    sta __rc6
    lda __rc7
    adc __rc5
    sta __rc7
    lda __rc2
    bne 1f
    dec __rc3
1:  dec __rc2
    lda __rc6
    bne 2f
    dec __rc7
2:  dec __rc6
    lda __rc2
    sta RIA_ADDR0
    lda __rc3
    sta RIA_ADDR0+1
    lda __rc6
    sta RIA_ADDR1
    lda __rc7
    sta RIA_ADDR1+1
    lda #$FF
.Lxram_move_step:
    sta RIA_STEP0
    sta RIA_STEP1
    ldx __rc5
    beq .Lxram_move_tail
.Lxram_move_page:
    ldy #32
.Lxram_move_pg:
    .rept 8
    lda RIA_RW0
    sta RIA_RW1
    .endr
    dey
    bne .Lxram_move_pg
    dex
    bne .Lxram_move_page
.Lxram_move_tail:
    lda __rc4
    beq .Lxram_move_done
    and #7
    beq .Lxram_move_eights
    tax
.Lxram_move_rest:
    lda RIA_RW0
    sta RIA_RW1
    dex
    bne .Lxram_move_rest
.Lxram_move_eights:
    lda __rc4
    lsr
    lsr
    lsr
    beq .Lxram_move_done
    tax
.Lxram_move_blk:
    .rept 8
    lda RIA_RW0
    sta RIA_RW1
    .endr
    dex
    bne .Lxram_move_blk
.Lxram_move_done:
    rts
.size xram_move, .-xram_move
