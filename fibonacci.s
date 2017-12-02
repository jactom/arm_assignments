; Generating fibonacci sequence
; Submitted by Tomin Sebastian

; The sequence is stored starting from this address

	AREA myData, DATA
		
FIB_START EQU 0x20000000
	
	AREA myCode, CODE
		ENTRY
		EXPORT __main
; When the program begins, r0 = 0 and r1 = 1. The fibonacci sequence is 
; computed by f(n) = f(n - 1) + f(n - 2). In the register r7 we store the
; length of the sequence. The generated sequence is then moved to memory
; location starting from FIB_START
__main		FUNCTION
		MOV r0, #0 ; First number in the sequence
		MOV r1, #1 ; Second number in the sequence
		MOV r7, #5 ; Length of the sequence
		
		LDR r3, =FIB_START ; Starting location of the sequence in memory
		STR r0, [r3] ; Store first number to memory
		ADD r3, r3, #4 ; Increament memory pointer.
		STR r1, [r3] ; Store second number to memory
		ADD r3, r3, #4 ; Increament memory pointer
loop 		CBZ r7, stop ; Stop computing once required length is generated
		MOV r2, r1 ; r2 is a temporary variable holding value of r1
		ADD r1, r1, r0 ; update r1 to next number in sequence
		MOV r0, r2 ; update r0 to previous value in sequence
		STR r1, [r3] ; store the new value to memory
		ADD r3, r3, #4 ; Increament pointer
		SUB r7, #1 ; decrement the loop variable
		B loop 
stop		B stop
		ENDFUNC
		END
