
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

; Dolphin DOS-like memory layout
;SCREENRAM     = $0800   ; Adjust the screen memory start address
;SCREEN_WIDTH  = 40      ; Adjust the screen width

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

                ; Clear the screen
                ldy #$00
clear_loop      lda #$20
                sta SCREENRAM,y
                iny
                cpy #$e8
                bne clear_loop

                ldy #$0b                ; The string "hello world!" has 12 (= $0b) characters

character_loop

                lda hello,y             ; Load character number y of the string
                sta SCREENRAM+($40*2+3),y ; Save it at position y of the screen RAM (2nd line)
                dey                     ; Decrement y by 1
                bpl character_loop      ; Is y positive? Then repeat

                ; Additional text strings
                ldy #$08                ; The string "blackburn dos" has 13 characters
title_loop
                lda title,y             ; Load character number y of the string
                sta SCREENRAM+($40*3+7),y ; Save it at position y of the screen RAM (3rd line)
                dey                     ; Decrement y by 1
                bpl title_loop          ; Is y positive? Then repeat

                ldy #$0b                ; The string "by nicky blackburn" has 18 characters
author_loop
                lda author,y            ; Load character number y of the string
                sta SCREENRAM+($40*4+3),y ; Save it at position y of the screen RAM (4th line)
                dey                     ; Decrement y by 1
                bpl author_loop         ; Is y positive? Then repeat

                rts                     ; Exit the program

hello           !scr "hello world!"     ; Our string to display
title           !scr "blackburn dos"    ; Title string
author          !scr "by nicky blackburn" ; Author string