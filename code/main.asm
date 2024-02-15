;==========================================================
; LABELS
; Comment or uncomment the lines below 
; Depending on your target machine
;==========================================================

; C64
BGCOLOR       = $d020
BORDERCOLOR   = $d021
BASIC         = $0801
SCREENRAM     = $0590
SECONDLINE =  $05e0

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
                ldx #$00                ; Initialize x to 0 to start from the left
                ldy #$0e                ; The string "blackburn dos" has 13 characters
title_loop
                lda title,x             ; Load character number x of the string
                sta SCREENRAM ; Save it at the calculated position y of the screen RAM (3rd line)
                lda author,x  
                sta SECONDLINE
                inx                     ; Increment x by 1
                cpx #$28                 ; Is x equal to 18 (end of string)? If yes, exit loop
                bne title_loop         ; If not, repeat

                rts                     ; Return from subroutine

; Subroutine to clear the screen
clear_screen
                lda #$93                ; Load CHR$(147) character code
                jsr $ffd2               ; Call KERNAL routine to print CHR$(147)
                rts                     ; Return from subroutine

            
title           !scr "blackburn dos"    ; Title string
author          !scr "by nicky blackburn" ; Author string
