; Taylor series implementation of e^x
; By Tomin Sebastian

; Taylor series expansion of e^x
; e^x = 1 + x + (x^2 / 2) + (x^3 / 6) + ... + (x^n / n!) + ...

; Code starts here.
	AREA myCode, CODE
			ENTRY
			EXPORT __main

; Variables used
; s0 - counter: The loop counter.
; s1 - x 	  :	The value of power of e. (x)
; s2 - i	  : The number of terms in the taylor series considered. More the number
;	  			more will be precision (till over flow). But more time to compute.
; s3 - result : The result is stored here.
; s4 - id	  : An intermediate variable storing value of (x^n / n!).
; s5 - inc	  : The counter increament. VADD operates only on FPU registers.

__main
			VMOV.F32 s0, #1.0 
			VMOV.F32 s5, #1.0 				  
			VMOV.F32 s1, #5.0 
			VMOV.F32 s2, #15.0 
			VMOV.F32 s3, #1.0 
			
			VDIV.F32 s4, s1, s0 		; Initialized with ((x = 3) / (n = 1)).
			
loop		VADD.F32 s3, s3, s4 		; result = result + id
			VMUL.F32 s4, s4, s1 		; id = id * x
			VADD.F32 s0, s0, s5 		; counter = counter + inc
			VDIV.F32 s4, s4, s0 		; id = id / counter
			VCMP.F32 s0, s2     		; Is (counter == i) ?
			VMRS 	 APSR_nzcv, FPSCR 	; Copy FPSCR to APSR_nzcv
			BNE 	 loop				; If (counter != i) then loop

stop		B		 stop;				; else stop. 

; Code ends here,
			END							
			