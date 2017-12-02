; Find gcd of the two numbers (by Euclid's Algorithm)
; Submitted by Tomin Sebastian

;The gcd is stored here
	AREA myData,DATA
		
GCD_VAL	EQU	0x20000000

	AREA myCode, CODE
		ENTRY
		EXPORT __main

; Here the gcd is find out by Euclid's method. The largest of the two numbers
; is substracted from other. Now the same is applied on the results untill
; values are the same. This common value will be their gcd.

__main		FUNCTION
		MOV r1, #45 ; load first number.
		MOV r2, #15 ; load the second number.
		LDR r3, =GCD_VAL
		B gcd		; jump to the gcd code.
loop		CMP r1, r2 ; compare the two numbers
		ITE GT ; if r1 > r2
		SUBGT r1, r1, r2 ; then r1 = r1 -r2
		SUBLE r2, r2, r1 ; else r2 = r2 - r1		
gcd		CMP r1, r2 ; Compare the two numbers
		BNE loop   ; If not equal substract thsmallest from the largest
		STR r1, [r3] ; store the gcd value to the memory location
stop		B stop
		ENDFUNC
		END
		
		
