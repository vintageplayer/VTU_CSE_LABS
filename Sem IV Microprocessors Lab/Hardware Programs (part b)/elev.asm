UP MACRO N
        LOCAL AGN
        MOV AL,0F0H
        AGN:MOV DX,PA
            OUT DX,AL
            DELAY
            INC AL
            CMP AL,N
            JLE AGN
        ENDM

DOWN MACRO M
        LOCAL AGN
        MOV AL,M
        AGN:    MOV DX,PA
                OUT DX,AL
                DELAY
                DEC AL
                CMP AL,0F0H
                JGE AGN
        ENDM

DELAY MACRO
        LOCAL D1,D2
        PUSH BX
        PUSH CX
        MOV BX,0FFFH
        D1:MOV CX,0FFFFH
        D2:LOOP D2
        DEC BX
        JNZ D1
        POP CX
        POP BX
        ENDM

.MODEL SMALL
.DATA
        PA      EQU     9800H
        PB      EQU     9801H
        CWR     EQU     9803H

.CODE
        MOV AX,@DATA
        MOV DS,AX
        MOV AL,82H
        MOV DX,CWR
        OUT DX,AL
ECH:    MOV AL,00
        MOV DX,PA
        OUT DX,AL
        MOV AL,0F0H
        MOV DX,PA
        OUT DX,AL
        MOV DX,PB
        IN AL,DX
        AND AL,0FH
        CMP AL,0EH
        JNE L1
        DELAY
        JMP ECH
L1:     CMP AL,0DH
        JNE L3
        PUSH AX
        UP 0F3H
        DELAY
        DELAY
        DELAY
        MOV AL,00
        MOV DX,PA
        OUT DX,AL
        DOWN 0F3H
        POP AX
L3:     CMP AL,0BH
        JNE L4
        PUSH AX
        UP 0F6H
        DELAY
        DELAY
        DELAY
        MOV AL,00
        MOV DX,PA
        OUT DX,AL
        DOWN 0F6H
        POP AX
L4:     CMP AL,07H
        JNE L5
        PUSH AX
        UP 0F9H
        DELAY
        DELAY
        DELAY
        MOV AL,00
        MOV DX,PA
        OUT DX,AL
        DOWN 0F9H
        POP AX
L5:     MOV AH,0BH
        INT 21H
        OR AL,AL
        JNZ STOP
        JMP ECH
STOP:   MOV AH,4CH
        INT 21H

        END



