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

                !byte $0e, $08           ; Title length and line number
                !byte $E3                     
                !byte $07, $9E
                !byte '0' + entry % 10000 / 1000        
                !byte '0' + entry %  1000 /  100        
                !byte '0' + entry %   100 /   10        
                !byte '0' + entry %    10             
                !byte $00, $00, $00      ; End of basic


;==========================================================
; CODE
;==========================================================

entry

                lda #$00                ; Set background color to black
                sta BGCOLOR             ; Change background color
                lda #$0d                ; Load the color light blue
                sta BORDERCOLOR         ; Change border color

                ; Call subroutine to clear the screen
                jsr clear_screen

                ; Additional text strings
                ldy #$08                ; The string "blackburn dos" has 13 characters
title_loop
                lda title,y             ; Load character number y of the string
                sta SCREENRAM+($40*3+3),y ; Save it at position y of the screen RAM (3rd line)
                dey                     ; Decrement y by 1
                bpl title_loop          ; Is y positive? Then repeat

                ldy #$0b                ; The string "by nicky blackburn" has 18 characters
author_loop
                lda author,y            ; Load character number y of the string
                sta SCREENRAM+($40*4+3),y ; Save it at position y of the screen RAM (4th line)
                dey                     ; Decrement y by 1
                bpl author_loop         ; Is y positive? Then repeat

                rts                     ; Return from subroutine

; Subroutine to clear the screen
clear_screen
                lda #$93                ; Load CHR$(147) character code
                jsr $ffd2               ; Call KERNAL routine to print CHR$(147)
                rts                     ; Return from subroutine

            
title           !scr "blackburn dos"    ; Title string
author          !scr "by nicky blackburn" ; Author string
