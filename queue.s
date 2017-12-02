; Implementation of Circular queue (ring buffer).
; By Tomin Sebastian

; Here the address space for queue are defined
	AREA myData, DATA
		
QUEUE_START		EQU 0x20000000
QUEUE_END		EQU 0x20000028
LENGTH			EQU QUEUE_END - QUEUE_START ; It is the size limit of queue
	
; Code starts here

	AREA myCode, CODE
		ENTRY
		EXPORT __main

; Variables used
; r0 = head address of queue
; r1 = tail address of queue
; r2 = size of queue is updated here. Limit is LENGTH 
; r3 = Define how many elementsto be enqued or dequed.
; r4 = The variable holding data to write/read to/from the queue
; r8 = A constant variable holding the end address of the queue space


; This is the enqueue function. It adds to the queue number of elements defined
; in register r3 or untill the queue is full. Queue length is updated in register
; r2

enq
go		CMP r2, #LENGTH ; Chech wheather queue is full
		BNE go0
		BX lr
go0		CMP r3, #0 			; Check the required number of elements are added
		BNE go1
		BX lr
go1		ADD r4, r4, #1 
		STR r4, [r1] 		; Store a number to queue tail
		ADD r2, r2, #1 		; Increase the length of queue
		SUB r3, r3, #1 		; Decrease the no. of items
; Implementing the Ring buffer. If tail address reach the end of
; queue address space, it is assigned the start of queue address space
; else the address is increamented by four
		CMP r1, r8
		BNE go2
		LDR r1, =QUEUE_START
		B go
go2 	ADD r1, r1, #4
		B go


; This is the dqueue function. It pops from the queue number of elements defined
; in register r3 or untill the queue is full. Queue length is updated in register
; r2. The poped value can be found in register r4

deq
do		CMP r2, #0 			; Chech wheather queue is empty
		BNE do0
		BX lr
do0 	CMP r3, #0 			; Check the required number of elements are added
		BNE do1
		BX lr
do1 	LDR r4, [r0] 		; Read from the queue head to r4 and Dequeue
		SUB r2, r2, #1 		; Decrease the length of queue
		SUB r3, r3, #1 		; Decrease the no. of items
; Implementing the Ring buffer. If head address reach the end of
; queue address space, it is assigned the start of queue address space
; else the address is increamented by four
		CMP r0, r8
		BNE do2
		LDR r0, =QUEUE_START
		B do
do2 	ADD r0, r0, #4
		B do


__main
		LDR r0, =QUEUE_START ; Initialize head address
		LDR r1, =QUEUE_START ; Initialize tail address
		LDR r8, =QUEUE_END	 ; Store the end of queue address space
		MOV r2, #0			 ; Initialize the lenght to zero
		MOV r3, #0x28
		MOV r4, #10
		BL enq				 ; Add #r3 elements to the queue
		MOV r3, #0x10
		BL deq				 ; Dequeue #r3 elements from the queue
stop		B	stop
		END
		
		
