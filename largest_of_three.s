; Find largest of three numbers
; Submitted by Tomin Sebastian

; Location where the largest number is stored.
	AREA myData, DATA
		LARGEST_STORE		EQU 0x20000000
	
	AREA myCode, CODE
		ENTRY
		EXPORT __main

__main
; The numbers are loaded to registers r0, r1, r2
		MOV r0, #0
		MOV r1, #1
		MOV r2, #2
		MOV r4, r0   ;current assumed larget
		LDR r3, =LARGEST_STORE
		
		CMP r4, r1
		IT LT ; If value in r4 is less than r1 then move the largest to r4
		MOVLT r4, r1

; Now the largest of first two numbers is found. It is compared with the third
; number to find the largest of all three
		CMP r4, r2
		IT LT ; If value in r4 is less than r2 then move the largest to r4
		MOVLT r4, r2
; Now r4 has the largest number. Store it to a memory location	
		STR r4, [r3]
stop	B stop
		END
