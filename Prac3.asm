;------------- definiciones e includes ------------------------------
;.INCLUDE "m1280def.inc" ; Incluir definiciones de Registros para 1280
.INCLUDE "m2560def.inc" ; Incluir definiciones de Registros para 2560

;call delay20us
;call delay4ms
call delay1s
;call myRand ; Retorna valor en R25
nop

delay20us:
	ldi R24,103
	nop
	nxt20us:
		dec R24
		brne nxt20us
		ret

delay4ms:
	ldi R24,162
	nxt4ms_1:
		nop
		nop
		ldi R25,130
		nxt4ms_2:
			dec R25
			brne nxt4ms_2
		dec R24
		brne nxt4ms_1
		ret

delay1s: 
	ldi R24,252
	jmp nxt1s_1
	nxt1s_1:
		ldi R25,236
		nxt1s_2:
			ldi R26,88
			nop
			nop
			nxt1s_3:
				dec R26
				brne nxt1s_3
			dec R25
			brne nxt1s_2
		nop
		nop
		nop
		nop
		nop
		dec R24
		brne nxt1s_1
	jmp fin
fin: ret

myRand:
	
	iniciarR16: lpm R16, Z ;Iniciar número "semilla"
	ld R17,X			   ;Iniciar número aux

	mov R18, R16		   ;cnt para saber cuantas veces incrementar R17, para simular aleatoriedad
	loop:
		inc R17
		dec R18
		brne loop	
	asr R17				   ;R17 final a usar, aplicar un  Arithmetic Shift Right
	mul R16, R17           ;Generamos num aleatorio con mul, se guarda en R0:R1
	com R0				   ;Negamos resultado (complemento a1)
	adc R0, R17            ;dar mas "aleatoriedad"
    clr R1                 ;Limpiar R1 porque no nos interesa solo R0 (8 bits)
	mov R25, R0            ;Donde nos interesa que se guarde el num
	clr R0                 ;Se limpia todo porque solo interesa R25
	clr R16
	clr R17
    ret
