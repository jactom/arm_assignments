; Check weather a given number is odd or even;
; Submitted by Tomin Sebastian

	AREA myCode, CODE
		ENTRY
		EXPORT __main

; The number is loaded to register r1. It is then AND with #1. Result 
; is stored in register r2. If number is odd, the content in r2 is #1. 
; Otherwise it is zero

__main
		MOV r1, #46
		AND r2, r1, #1
stop 	B stop
		END