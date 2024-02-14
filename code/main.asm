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

   
title_loop
                ldy #$0D ; number of chars in the title
                lda title,y             ; load character number y of the string
                sta SCREENRAM,y         ; save it at position y of the screen ram
                dey                     ; decrement y by 1
                bpl title_loop      ; is y positive? then repeat
                rts                     ; exit the program

   
author_loop

                ldy #$11   ; number of chars in the author
                lda author,y             ; load character number y of the string
                sta SCREENRAM,y         ; save it at position y of the screen ram
                dey                     ; decrement y by 1
                bpl author_loop      ; is y positive? then repeat
                rts                     ; exit the program

title           !scr "blackburn dos"     ; the title
author          !scr "by nickyblackburn" ; the author 