;==========================================================
; LABELS
; Comment or uncomment the lines below 
; Depending on your target machine
;==========================================================


; C64
BGCOLOR       = $d020
BORDERCOLOR   = $d021
BASIC         = $0801
SCREENRAM     = $0400

;==========================================================
; BASIC header
;==========================================================

* = BASIC

                !byte $0b, $08      ; Title length and line number
                !byte $E3                     
                !byte $07, $9E
                !byte '0' + entry % 10000 / 1000        
                !byte '0' + entry %  1000 /  100        
                !byte '0' + entry %   100 /   10        
                !byte '0' + entry %    10             
                !byte $00, $00, $00  ; End of BASIC

;==========================================================
; CODE
;==========================================================

entry

                lda #$00            ; Set background color to black
                sta BGCOLOR         
                lda #$0d            ; Set border color to light blue
                sta BORDERCOLOR         

                ; Clear the screen
                ldy #$00
clear_loop      lda #$20
                sta SCREENRAM,y
                iny
                cpy #$e8
                bne clear_loop

                ; Display "Nicky DOS Dev-0.1" message
title_loop      ldy #$0d
                lda title,y
                sta $0400+($40*2),y ; Set starting position to left side of the screen
                dey
                bpl title_loop

                ; Display "Author message" message
author_loop     ldy #$11
                lda author,y
                sta $0400+($40*3),y ; Set starting position to left side of the screen
                dey
                bpl author_loop

                rts

title           !scr "nicky dos dev"
author          !scr " by nicky blackburn"
