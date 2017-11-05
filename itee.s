	AREA myCode, CODE
		ENTRY
		EXPORT __main
			
__main
		MOV r2, #10
		MOV r7, #10
		MOV r4, #5
		CMP r2, r7
		ITTEE NE
		SUBNE r2, r2, r7
		MOVNE r2, #0
		ADDEQ r2, r2, r4
		MOVEQ r4, #0
stop 	B stop
		END