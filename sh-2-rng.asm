; SH-2-prng
; Conversion of NESHacker's prng library to SH-2 assembly (32X, Saturn, J2, etc)
; Might work on SH-4 (Dreamcast), but have not tested

; Some optimizations courtesy of the much superior chip have been made
; The program is small enough to execute from slave SH-2's 4KB cache, allowing for full parallelism if the programmer so chooses

; This code is designed to assemble with the AS macro assembler
; http://john.ccac.rwth-aachen.de:8000/as/
; As the SH-2 uses 16-bit wide instructions, there's only 8-bits available for immediate values on HW
; However AS can handle larger values automatically, so you may have to change some code if your assembler doesn't support this feature

; Simple 16-bit Galios LFSR random number generator implementation as explained
; in the "8-bit RNG" video.


; Returns a 16-bit random number in r0
; Clobbahs r0 and r1
galois16:

SECTION galoisRNG

	; for (y = 16; y > 0; y--) {
	mov.w seed,r0
	; load taps
	mov.w #$B400,r1
	; optimization - 32-bit CPU does 16-bit shifts with ease!
	shar r1
	; Shifts on SH-2 automatically set T bit, which just so happens to be true/false branching bit!
	; TODO - check behavior of branches in relation to pipeline - might be like MIPS where delay slots are needed
	bt skipXOR
	; Uncomment line below if delay slot needed
	; NOP
	; XOR
	xor r1,r0
skipXOR:
	;return
	rts
	
ENDSECTION galoisRNG


; Rolls a d20 with sampling rejection
; Returns result in r0
; Clobbahs r0 and r1
d20:
	
SECTION d20

loop:
	; random 0-64K
	jsr galois16
	; mask 0-31
	and #%00011111,r0
	; less than 20?
	clrt
	mov.b #20,r1
	cmp/hs r1,r0
	bt loop
	; add one
	add #1,r0
	; return
	rts

ENDSECTION d20